from libqtile.config import Screen
from libqtile import bar
from widgets import widgets

def status_bar(widget_dict):
    return bar.Bar(widget_dict, 20, opacity=0.95)

screens = [ Screen(top=status_bar(widgets)) ]
