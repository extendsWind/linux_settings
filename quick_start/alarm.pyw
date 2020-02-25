#!/bin/python3

# just a test program for py gtk

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk
from gi.repository import Gdk


class MyWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="Hello World")

        self.set_border_width(10)

        self.button = Gtk.Button()
        self.button.modify_bg(Gtk.StateType.NORMAL, Gdk.Color(20000, 10000, 10000))


        # self.button.set_property("background", "RED")
        self.button.connect("clicked", self.on_button_clicked)
        self.add(self.button)

        # self.label = Gtk.Label(label="test")
        # self.add(self.label)

    def on_button_clicked(self, widget):
        print("Hello World")




win = MyWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()
