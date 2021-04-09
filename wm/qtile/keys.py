from libqtile.config import Key
from libqtile.command import lazy

mod = 'mod4'

keys = [Key(key[0], key[1], *key[2:]) for key in [
    # Switch focus between windows
    ([mod], "j", lazy.layout.down()),
    ([mod], "k", lazy.layout.up()),
    ([mod], "h", lazy.layout.left()),
    ([mod], "l", lazy.layout.right()),

    # Move windows in the current stack
    ([mod, "shift"], "j", lazy.layout.shuffle_down()),
    ([mod, "shift"], "k", lazy.layout.shuffle_up()),
    ([mod, "shift"], "h", lazy.layout.shuffle_left()),
    ([mod, "shift"], "l", lazy.layout.shuffle_right()),

    # Toggle floating
    ([mod, "shift"], "f", lazy.window.toggle_floating()),

    # Kill window
    ([mod], "w", lazy.window.kill()),

    # Other Qtile keybinds
    ([mod], "Tab", lazy.next_layout()),
    ([mod, "control"], "r", lazy.restart()),
    ([mod, "control"], "q", lazy.shutdown()),

    # Application specific keybinds
    ([mod], "m", lazy.spawn("rofi -show drun")),
    ([mod], "b", lazy.spawn("firefox")),
    ([mod], "e", lazy.spawn("thunar")),
    ([mod], "Return", lazy.spawn("alacritty")),
    ([mod], "r", lazy.spawn("dot system night-shift toggle")),

    # Multimedia keys
    ([], "XF86AudioLowerVolume", lazy.spawn("pamixer --decrease 5")),
    ([], "XF86AudioRaiseVolume", lazy.spawn("pamixer --increase 5")),
    ([], "XF86AudioMute", lazy.spawn("pamixer --toggle-mute")),

    # Brightness keys
    ([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
    ([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
]]
