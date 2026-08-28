#!/usr/bin/env python3
"""Waybar lyrics module: show the current LRC line while MPD is playing."""
import json
import os
import re
import socket
import time
import unicodedata
from pathlib import Path

HOST = "127.0.0.1"
PORT = 6600
MUSIC_ROOT = Path(os.path.expanduser("~/Music"))
DISPLAY_WIDTH = 36
SCROLL_SECONDS = 0.15
SLEEP_PLAYING = 0.1
SLEEP_IDLE = 0.5
TIME_RE = re.compile(r"\[(\d+):(\d{1,2})(?:[.:](\d+))?\]")
META_RE = re.compile(r"(?:作词|作曲|编曲|制作人|监制|录音|混音|母带|OP|SP)\s*[:：]")


def cjk_count(text):
    return sum(1 for ch in text if "\u4e00" <= ch <= "\u9fff")


def char_cols(char):
    return 2 if unicodedata.east_asian_width(char) in ("W", "F") else 1


def column_width(text):
    return sum(char_cols(ch) for ch in text)


def take_columns(text, start_col, width):
    result = []
    col = 0
    skipped = 0
    for ch in text:
        w = char_cols(ch)
        if skipped + w <= start_col:
            skipped += w
            continue
        if col + w > width:
            break
        result.append(ch)
        col += w
    return "".join(result)


def format_line(text, elapsed, line_start):
    if not text:
        return "\u00a0" * DISPLAY_WIDTH
    total = column_width(text)
    if total <= DISPLAY_WIDTH:
        return text + "\u00a0" * (DISPLAY_WIDTH - total)
    cycle = text + "\u00a0\u00a0\u00a0" + text
    cycle_width = column_width(cycle)
    offset = int(max(0.0, elapsed - line_start) / SCROLL_SECONDS) % max(1, cycle_width)
    window = take_columns(cycle, offset, DISPLAY_WIDTH)
    return window + "\u00a0" * (DISPLAY_WIDTH - column_width(window))


def mpd_snapshot():
    data = {}
    try:
        with socket.create_connection((HOST, PORT), timeout=2) as sock:
            stream = sock.makefile("rb")
            stream.readline()
            sock.sendall(b"status\ncurrentsong\n")
            for _ in range(2):
                while True:
                    raw = stream.readline()
                    if not raw:
                        return data
                    line = raw.decode("utf-8", "replace").rstrip("\r\n")
                    if line == "OK":
                        break
                    if ":" in line:
                        key, _, value = line.partition(":")
                        data.setdefault(key.strip(), value.strip())
    except OSError:
        return None
    return data


def parse_elapsed(data):
    for key in ("elapsed", "time"):
        value = data.get(key)
        if not value:
            continue
        if ":" in value:
            value = value.split(":", 1)[0]
        try:
            return max(0.0, float(value))
        except ValueError:
            continue
    return 0.0


def parse_lrc(path, elapsed):
    try:
        content = path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return None, []

    candidates = []
    for raw in content.splitlines():
        matches = list(TIME_RE.finditer(raw))
        if not matches:
            continue
        if META_RE.search(raw):
            continue
        body = TIME_RE.sub("", raw).strip()
        if not body:
            continue
        for match in matches:
            minutes = int(match.group(1))
            seconds = int(match.group(2))
            millis = int(match.group(3) or 0) / 1000.0
            timestamp = minutes * 60 + seconds + millis
            candidates.append((timestamp, body))

    if not candidates:
        return None, 0.0, []

    candidates.sort(key=lambda item: item[0])
    best_time = candidates[0][0]
    line = candidates[0][1]
    for timestamp, body in candidates[1:]:
        if timestamp > elapsed + 0.03:
            break
        if timestamp == best_time:
            if cjk_count(body) < cjk_count(line):
                line = body
        elif timestamp > best_time:
            line = body
            best_time = timestamp
    return line, best_time, [body for _, body in candidates]


def build_payload(data):
    if not data or data.get("state") != "play":
        return {"text": ""}

    rel = data.get("file", "").lstrip("/")
    if not rel:
        return {"text": ""}

    rel_path = Path(rel)
    audio = rel_path if rel_path.is_absolute() else MUSIC_ROOT / rel_path
    lrc_path = audio.with_suffix(".lrc")
    artist = data.get("Artist", "")
    title = data.get("Title", "") or rel_path.stem
    fallback = f"{artist} - {title}" if artist else title
    elapsed = parse_elapsed(data)

    line, line_start, bodies = (
        parse_lrc(lrc_path, elapsed) if lrc_path.exists() else (None, 0.0, [])
    )
    if line is None:
        payload = {
            "text": format_line(fallback, elapsed, 0.0),
            "tooltip": f"{fallback}\n\n(no local .lrc)",
            "class": "playing",
        }
    else:
        lines = list(dict.fromkeys(body for body in bodies if body))
        tooltip = f"{fallback}\n\n" + "\n".join(lines)
        payload = {
            "text": format_line(line, elapsed, line_start),
            "tooltip": tooltip[:2000],
            "class": "playing",
        }

    return payload


def main():
    while True:
        data = mpd_snapshot()
        payload = build_payload(data)
        print(json.dumps(payload, ensure_ascii=False), flush=True)
        time.sleep(SLEEP_PLAYING if payload.get("text") else SLEEP_IDLE)


if __name__ == "__main__":
    main()
