from libqtile.widget import base
from pathlib import Path

class NightShiftStatus(base._TextBox):
    """
    Display night shift status
    """
    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ("update_interval", 0.2, "The update interval"),
    ]

    def __init__(self, **config):
        super().__init__("", **config)
        self.add_defaults(NightShiftStatus.defaults)
        self.text = "" # nf-fa-adjust / nf-fa-circle

    def timer_setup(self):
        self.timeout_add(self.update_interval, self._check_night_shift_status)

    def _check_night_shift_status(self):
        if Path("~/.dots/util/redshift/.night-shift-enabled").expanduser().is_file():
            self.text = ""
        else:
            self.text = ""

        self.bar.draw()
        self.timeout_add(self.update_interval, self._check_night_shift_status)
