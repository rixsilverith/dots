from libqtile.config import Key, Group, Match
from libqtile.command import lazy
from keys import mod, keys

groups = [
    Group('term', label='  ', init=True, persist=True, matches=[Match(wm_class=['Alacritty'])], position=1),
    Group('browser', label='  ', init=True, persist=True, matches=[Match(wm_class=['firefox'])], position=2),
    Group('discord', label='  ', init=True, persist=True, matches=[Match(wm_class=['discord'])], position=3),

    Group('other', label='  '),
]

for i, group in enumerate(groups):
    current_key = str(i + 1)
    keys.extend([
        # Switch to group N. Here toggle=False prevents the group from being toggle
        # with the last used it's already on the screen
        Key([mod], current_key, lazy.group[group.name].toscreen(toggle=False)),
        # Send window to group N
        Key([mod, "shift"], current_key, lazy.window.togroup(group.name))
    ])
