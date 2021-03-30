from libqtile.dgroups import simple_key_binder

from keys import mod, keys
from groups import groups
from layouts import layouts, floating_layout
from widgets import widget_defaults, extension_defaults
from screens import screens
from mouse import mouse

main = None

# auto bind keys to dgroups mod+(1 to 9)
dgroups_key_binder = simple_key_binder(mod)

dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
auto_fullscreen = True
focus_on_window_activation = 'urgent'
wmname = 'LG3D'
