from libqtile import widget, bar
from colors import colors

from custom_widgets.netstatus import NetStatus
from custom_widgets.volume import VolumeDisplay

def base(fg='text', bg='dark'):
    return { 'foreground': colors[fg], 'background': colors[bg] }

def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)

def icon(fg='text', bg='dark', fontsize=16, text='?'):
    return widget.TextBox(**base(fg, bg), fontsize=fontsize, text=text, padding=3)

def powerline(fg='light', bg='dark'):
    return widget.TextBox(
        **base(fg, bg),
        text='',
        fontsize=30,
        font='UbuntuMono Nerd Font',
        padding=-2
    )

def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='SF Pro Display',
            fontsize=25,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=10,
            borderwidth=1,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['light'],
            block_highlight_text_color=colors['dark'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator()
    ]

widgets = [
    *workspaces(),

    widget.Spacer(length=bar.STRETCH),
    powerline('light', 'dark'),

    icon(fg='dark', bg='light', fontsize=25, text='墳'),
    VolumeDisplay(**base(bg='light', fg='dark')),

    icon(fg='dark', bg='light', fontsize=20, text=''),

    icon(fg='dark', bg='light', fontsize=20, text=''),
    NetStatus(**base(fg='dark', bg='light')),

    widget.Clock(**base(bg='light'), format='%a %b %d  %H:%M ', padding=5)
]

widget_defaults = {
    'font': 'SF Pro Display Medium',
    'fontsize': 14,
    'padding': 1,
}

extension_defaults = widget_defaults.copy()
