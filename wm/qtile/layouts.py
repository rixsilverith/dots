from libqtile import layout
from libqtile.config import Match

layout_config = {
    'border_width': 0,
    'margin': 16
}

layouts = [ layout.MonadTall(**layout_config) ]

floating_layout = layout.Floating(
    float_rules = [
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),
        Match(wm_class='makebranch'),
        Match(wm_class='maketag'),
        Match(wm_class='ssh-askpass'),
        Match(title='branchdialog'),
        Match(title='pinentry'),
    ],
)
