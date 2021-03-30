from libqtile.config import Key, Group, Match
from libqtile.command import lazy

groups = [
    Group('other', label='  '),

    Group('term', label='  ', init=False, persist=False, matches=[Match(wm_class=['Alacritty'])], position=1),
    Group('browser', label='  ', init=False, persist=False, matches=[Match(wm_class=['firefox'])], position=2),
    Group('discord', label='  ', init=False, persist=False, matches=[Match(wm_class=['discord'])], position=3),
]
