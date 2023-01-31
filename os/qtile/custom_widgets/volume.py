from libqtile.widget import base
import subprocess

class VolumeDisplay(base._TextBox):
    """
    Display current volume
    """
    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ("update_interval", 0.2, "The update interval"),
    ]

    def __init__(self, **config):
        super().__init__("", **config)
        self.add_defaults(VolumeDisplay.defaults)
        self.text = "M"

    def timer_setup(self):
        self.timeout_add(self.update_interval, self.get_volume)

    def get_volume(self):
        vol = subprocess.run(['pamixer', '--get-volume'], stdout=subprocess.PIPE).stdout.decode('utf-8')
        self.text = vol.replace("\n", "")
        self.bar.draw()
        self.timeout_add(self.update_interval, self.get_volume)
