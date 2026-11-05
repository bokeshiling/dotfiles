local mainMod  = "SUPER"
local terminal = "foot"
local menu     = "wmenu-run"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + E", 
    hl.dsp.window.fullscreen({
        mode = "maximized",
        action = "toggle",
    })
)
hl.bind(mainMod .. " + SHIFT + E",
    hl.dsp.window.fullscreen({
        mode = "fullscreen",
        action = "toggle",
    })
)

-- 焦点切换
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))


-- 移动窗口
hl.bind(mainMod .. " + SHIFT + left",
    hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right",
    hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",
    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",
    hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H",
    hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L",
    hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K",
    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J",
    hl.dsp.window.move({ direction = "down" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- 工作区切换
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end


-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- To switch between windows in a floating workspace:
hl.bind("SUPER + Tab", function()
    -- Change focus to another window
    hl.dispatch(hl.dsp.window.cycle_next())
    -- Bring it to the top
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("shoot"))
--
hl.bind(mainMod .. " + Minus", hl.dsp.exec_cmd("audio sink --minus10"))
hl.bind(mainMod .. " + Equal", hl.dsp.exec_cmd("audio sink --plus10"))
hl.bind(mainMod .. " + SHIFT + Minus", hl.dsp.exec_cmd("audio sink --minus"))
hl.bind(mainMod .. " + SHIFT + Equal", hl.dsp.exec_cmd("audio sink --plus"))
hl.bind(mainMod .. " + Backspace", hl.dsp.exec_cmd("audio sink --mute"))


hl.bind(mainMod .. " + CONTROL + Minus", hl.dsp.exec_cmd("audio source --minus10"))
hl.bind(mainMod .. " + CONTROL + Equal", hl.dsp.exec_cmd("audio source --plus10"))
hl.bind(mainMod .. " + CONTROL + SHIFT + Minus", hl.dsp.exec_cmd("audio source --minus"))
hl.bind(mainMod .. " + CONTROL + SHIFT + Equal", hl.dsp.exec_cmd("audio source --plus"))
hl.bind(mainMod .. " + CONTROL + Backspace", hl.dsp.exec_cmd("audio source --mute"))
hl.bind(mainMod .. " + Bracketleft", hl.dsp.exec_cmd("bright --minus10"))
hl.bind(mainMod .. " + Bracketright", hl.dsp.exec_cmd("bright --plus10"))
hl.bind(mainMod .. " + SHIFT + Bracketleft", hl.dsp.exec_cmd("bright --minus"))
hl.bind(mainMod .. " + SHIFT + Bracketright", hl.dsp.exec_cmd("bright --plus"))
hl.bind(mainMod .. " + SHIFT + Bracketleft", hl.dsp.exec_cmd("bright --minus"))
