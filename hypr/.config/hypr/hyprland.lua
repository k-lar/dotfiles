-- Monitor config
hl.monitor({
    output   = "",
    mode     = "highrr",
    position = "auto",
    scale    = "auto",
})

-- Environment variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GTK_THEME", "gruvbox-dark-gtk")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Autostart these apps
hl.on("hyprland.start", function ()
    hl.exec_cmd("discord")
    hl.exec_cmd("if [ -e $HOME/.dotfiles/options/.laptop ]; then hypridle -c ${XDG_CONFIG_HOME}/hypr/hypridle_laptop.conf; else hypridle; fi")
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("emacs --daemon")
    hl.exec_cmd("kdeconnect-indicator")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("dunst")
    hl.exec_cmd("udiskie --smart-tray --file-manager=thunar")
    hl.exec_cmd("systemctl --user enable --now hyprpolkitagent.service")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Clipboard
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("hyprctl dispatch exec \"[workspace special silent] foot --title=nvim-scratch nvim\"")
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
        gaps_in  = 5,
        gaps_out = 12,

        border_size = -1,

        col = {
            active_border   = { colors = {"rgba(000000000)", "rgba(000000000)"}},
            inactive_border = "rgba(000000000)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
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

-- Variables
local terminal = "foot"
local launcher = "rofi -show run -show-icons"
local fileManager = "thunar"
local browser = "librewolf"
local browser2 = "chromium"
local mainMod = "SUPER"

-- My keybinds
hl.bind(mainMod .. "+ Return", hl.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- NOTE: You can do stuff like this with the returned handler:
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. "+ Shift + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + Shift + E", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + F", hl.exec_cmd(fileManager))
hl.bind(mainMod .. " + E", hl.exec_cmd("emacsclient -c -a 'emacs'"))
hl.bind(mainMod .. " + Tab", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.exec_cmd(launcher))
hl.bind(mainMod .. " + B", hl.exec_cmd(browser))
hl.bind(mainMod .. " + Shift + B", hl.exec_cmd(browser2))
hl.bind(mainMod .. " + L", hl.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Shift + L", hl.exec_cmd("sh -c \"~/.dotfiles/rofi/.config/rofi/scripts/rofi-hyprsunset\""))
hl.bind(mainMod .. " + P", hl.exec_cmd("sh -c \"~/.dotfiles/scripts/better_random_wall.sh random\""))
hl.bind(mainMod .. " + Shift + P", hl.exec_cmd("sh -c \"~/.dotfiles/scripts/better_random_wall.sh default\""))
hl.bind(mainMod .. " + S", hl.exec_cmd("sh -c \"~/.dotfiles/scripts/spongebob_case.sh\""))
hl.bind(mainMod .. " + space", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + K", hl.exec_cmd("rofi -show p -modi \"p:~/.config/rofi/scripts/rofi-power-menu --choices=shutdown/reboot/suspend/logout\""))
hl.bind("Print", hl.exec_cmd("grim -g \"$(slurp)\" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"))
hl.bind(mainMod .. " + Shift + W", hl.exec_cmd("pkill waybar && waybar"))
hl.bind(mainMod .. " + Shift + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + V", hl.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- Bind workspace switching and moving windows to workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Alt + Tab to switch windows
hl.bind("ALT + Tab", hl.dispatch(hl.dsp.window.cycle_next()))
hl.bind("ALT + Shift + Tab", hl.dispatch(hl.dsp.window.cycle_prev()))

-- Color picker
hl.bind("CTRL + Print", hl.exec_cmd("hyprpicker -a"))

-- Scroll throught existing workspaces with mouse wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

-- Move and resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), { repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +10%"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { repeating = true })

-- Move/resize windows with keyboard
hl.bind(mainMod .. " + right", hl.resize({ x = 10, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + left", hl.resize({ x = -10, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + up", hl.resize({ x = 0, y = 10, relative = true}), { repeating = true })
hl.bind(mainMod .. " + down", hl.resize({ x = 10, y = -10, relative = true}), { repeating = true })

-- Swap windows with keyboard
hl.bind(mainMod .. " + Shift + right", hl.dsp.window.swap({ "r" }))
hl.bind(mainMod .. " + Shift + left", hl.dsp.window.swap({ "l" }))
hl.bind(mainMod .. " + Shift + up", hl.dsp.window.swap({ "u" }))
hl.bind(mainMod .. " + Shift + down", hl.dsp.window.swap({ "d" }))

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
