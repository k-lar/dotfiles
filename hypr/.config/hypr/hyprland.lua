local utils = require("hyprland_utils")
require("modules.show_active_window")

local scripts = {
    hyprsunset = "~/.dotfiles/rofi/.config/rofi/scripts/rofi-hyprsunset",
    wallpaper  = "~/.dotfiles/scripts/better_random_wall.sh",
    spongebob  = "~/.dotfiles/scripts/spongebob_case.sh"
}

-- Monitor config
hl.monitor({
    output   = "",
    mode     = "highrr",
    position = "auto",
    scale    = "auto",
})

-- Environment variables
local function envs(vars)
	for k, v in pairs(vars) do
		hl.env(k, v)
	end
end

envs({
    XCURSOR_SIZE = "24",
    HYPRCURSOR_SIZE = "24",
    GTK_THEME = "gruvbox-dark-gtk",
    QT_QPA_PLATFORM = "wayland;xcb",
    XDG_CURRENT_DESKTOP = "Hyprland",
    XDG_SESSION_TYPE = "wayland",
    XDG_SESSION_DESKTOP = "Hyprland"
})

-- Autostart these apps
hl.on("hyprland.start", function()
        hl.exec_cmd("discord")
        hl.exec_cmd("if [ -e $HOME/.dotfiles/options/.laptop ]; then hypridle -c ${XDG_CONFIG_HOME}/hypr/hypridle_laptop.conf; else hypridle; fi")
        hl.exec_cmd("qs -c noctalia-shell")
        hl.exec_cmd("awww-daemon")
        hl.exec_cmd("emacs --daemon")
        hl.exec_cmd("kdeconnect-indicator")
        hl.exec_cmd("nm-applet")
        hl.exec_cmd("udiskie --smart-tray --file-manager=thunar")
        hl.exec_cmd("systemctl --user enable --now hyprpolkitagent.service")
        hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

        -- Clipboard
        hl.exec_cmd("wl-paste --type text --watch cliphist store")
        hl.exec_cmd("wl-paste --type image --watch cliphist store")

        -- Special workspace for nvim scratchpad
        -- hl.dsp.exec_cmd({ cmd = "foot --title=nvim-scratch nvim", rules = { workspace = "special silent" } })

        -- Start recording with noctalia-shell's screen recorder plugin (replay buffer)
        -- Start after 1 minute to ensure it starts after the plugin is loaded
        hl.exec_cmd("sleep 60 && qs -c noctalia-shell ipc call plugin:screen-recorder startReplay")
end)

-- General Hyprland config
hl.config({
    input = {
        kb_layout = "si, ru",
        kb_variant = ",phonetic",
        kb_options = "grp:alt_space_toggle",

        follow_mouse = 2,

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.3
        },

        sensitivity = 0 -- -1.0 - 1.0, 0 means no modification.
    },

    general = {
        gaps_in  = 3,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(00000000)", "rgba(00000000)" }},
            inactive_border = "rgba(00000000)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        shadow = { enabled = false }
    },

    animations = {
        enabled = true,
    },

    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },

    dwindle = {
        force_split = 2,
        preserve_split = true, -- you probably want this
        precise_mouse_move = true,
    },
})

-- Set up 10 persistent workspaces
for i = 1, 10 do
    hl.workspace_rule({ workspace = tostring(i), persistent = true })
end

-- Variables
local terminal = "foot"
local launcher = 'rofi -show combi -combi-modi "run,drun" -show-icons'
local fileManager = "thunar"
local browser = "librewolf"
local browser2 = "chromium"
local mainMod = "SUPER"

-- My keybinds
hl.bind(mainMod .. "+ Return", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- NOTE: You can do stuff like this with the returned handler:
-- closeWindowBind:set_enabled(false)

-- HACK: idk if this will work since no documentation on what a signal is but this seems alright
hl.bind(mainMod .. "+ SHIFT + Q", hl.dsp.window.signal({ signal = 9 }))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + F",  hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("emacsclient -c -a 'emacs'"))
hl.bind(mainMod .. " + Tab", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(browser2))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("sh -c \"" .. scripts.hyprsunset .. "\""))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(scripts.wallpaper .. " random"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(scripts.wallpaper .. " default"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(scripts.spongebob))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("rofi -show p -modi \"p:~/.config/rofi/scripts/rofi-power-menu --choices=shutdown/reboot/suspend/logout\""))
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("pkill waybar && waybar"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:screen-recorder startReplay"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:screen-recorder saveReplay"))

-- Bind workspace switching and moving windows to workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + "         .. key,     hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Alt + Tab to switch windows
hl.bind("ALT + Tab",         hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ previous = true }))

-- Color picker
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprpicker -a"))

-- Scroll throught existing workspaces with mouse wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e+1" }))

-- Move and resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), { repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +10%"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { repeating = true })

-- Zoom controls
hl.bind(mainMod .. " + plus", function()
    utils.scale_cursor_zoom(0.2)
end, { repeating = true })
hl.bind(mainMod .. " + minus", function()
    utils.scale_cursor_zoom(-0.2)
end, { repeating = true })
hl.bind(mainMod .. " + period", function()
    utils.set_cursor_zoom_factor(1.0)
end) -- Reset zoom

-- Move/resize windows with keyboard
hl.bind(mainMod .. " + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + left",  hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + up",    hl.dsp.window.resize({ x = 0, y = -10, relative = true}), { repeating = true })
hl.bind(mainMod .. " + down",  hl.dsp.window.resize({ x = 0, y = 10, relative = true}), { repeating = true })

-- Swap windows with keyboard
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))

-- Tag current window as private which should hide it from screensharing
hl.bind(mainMod .. " + H", hl.dsp.window.tag({ tag = "private" }))

-- Window rules
hl.window_rule({
    float = true,
    move = "0 0",
    suppress_event = "fullscreen",
    match = { title = "^(flameshot)" }
})

hl.window_rule({
    float = true,
    center = true,
    match = { class = "^(file-roller)$" }
})

-- Windows tagged with private should be hidden when screen sharing and have a red border to tell that to me
hl.window_rule({
    match = { tag = "private" },
    no_screen_share = true,
    border_color = "rgba(ff000099) rgba(ff000099)",
})

local common_modals = {
    "^(Open)$",
    "^(Choose Files)$",
    "^(Save As)$",
    "^(Confirm to replace files)$",
    "^(File Operation Progress)$",
    "^google-chrome$.*(Open Files)$",
    "^google-chrome$.*(Open File)$"
}

for _, title in ipairs(common_modals) do
    hl.window_rule({
        float = true,
        match = { title = title }
    })
end

hl.window_rule({
    float = true,
    size = "1280 720",
    match = { title = "^(nvim-scratch)$" },
    workspace = "special"
})
