from libqtile.config import Key, Group
from libqtile.command import lazy
from keys import mod, keys

groups = [Group(i) for i in "123456789"]

for i, group in enumerate(groups):
    current_key = str(i + 1)
    keys.extend([
        # Switch to group N
        Key([mod], current_key, lazy.group[group.name].toscreen()),
        # Send window to group N
        Key([mod, "shift"], current_key, lazy.window.togroup(group.name))
    ])
