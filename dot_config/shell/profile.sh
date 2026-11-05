#!/usr/bin/sh
# .config/shell/profile.sh
# set universal ENV, use `/bin/sh`(-> '/bin/dash') for better efficiency

export XKB_DEFAULT_OPTIONS=caps:swapescape

export XDG_DOWNLOAD_DIR="$HOME/dls"
export XDG_DOCUMENTS_DIR="$HOME/doc"
export XDG_MUSIC_DIR="$HOME/mus"
export XDG_PICTURES_DIR="$HOME/pic"
export XDG_VIDEOS_DIR="$HOME/vid"

export XDG_CONFIG_HOME="$HOME/.config"      # analogous to /etc
export XDG_CACHE_HOME="$HOME/.cache"        # analogous to /var/cache
export XDG_DATA_HOME="$HOME/.local/share"   # analogous to /usr/share
export XDG_STATE_HOME="$HOME/.local/state"

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:${PATH}"
[ -d "$HOME/.local/sbin" ] && export PATH="$HOME/.local/sbin:${PATH}"

