from libqtile.widget import base
import urllib.request

class NetStatus(base._TextBox):
    """
    Displays interface connection status
    """
    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ("update_interval", 2, "The update interval"),
        ("url", "http://google.com", "URL to test the connection"),
    ]

    def __init__(self, **config):
        super().__init__("", **config)
        self.add_defaults(NetStatus.defaults)
        self.net_connection_status = False
        self.text = "No Internet"

    def timer_setup(self):
        self.timeout_add(self.update_interval, self._check_net_connection)

    def _check_net_connection(self):
        self.net_connection_status = self.get_net_status()
        self.text = "" if self.net_connection_status else self.text == "No Internet"

        self.bar.draw()
        self.timeout_add(self.update_interval, self._check_net_connection)

    def get_net_status(self):
        try:
            urllib.request.urlopen(self.url)
            return True
        except:
            return False


