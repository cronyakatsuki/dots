from typing import Any

from libqtile import bar
from libqtile.widget import base

from subprocess import check_output


class CommandTextBox(base._TextBox):
    defaults = [
        ("font", "sans", "Text font"),
        ("fontsize", None, "Font pixel size. Calculated if None."),
        ("fontshadow", None, "font shadow color, default is None(no shadow)"),
        ("padding", None, "Padding left and right. Calculated if None."),
        ("foreground", "#ffffff", "Foreground colour."),
    ]

    def __init__(self, command=" ", width=bar.CALCULATED, **config):
        text = str(check_output(command).decode("utf-8"))
        base._TextBox.__init__(self, text=text, width=width, **config)

    def cmd_update(self, text):
        """Update the text in a TextBox widget"""
        self.update(text)

    def cmd_get(self):
        """Retrieve the text in a TextBox widget"""
        return self.text
