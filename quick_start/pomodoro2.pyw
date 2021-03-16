#!/bin/python

import tkinter
import tkinter.messagebox
from enum import Enum
import datetime  # for log

"""
# TODO  list:
- [x] change icon. problem in tkinter, change to remove the icon
- [x] function packing
- [x] generate a usage record
- [x] refactor code
- [x] adding a remind of every end of pomodoro
"""


class Status(Enum):
    """ work status """
    WORK = 1
    REST = 2


class PomodoroUI:
    """
    use Tkinter for UI
    """

    def __init__(self, workTime, restTime):
        self.work_time = workTime
        self.rest_time = restTime
        self.minite = workTime
        self.second = 0
        self.status = Status.WORK
        self.log_file = open("pomodoro.log", "a+")

        tk_root = tkinter.Tk()
        screen_width, screen_height = tk_root.maxsize()
        window_width = 100
        window_height = 40
        # window size
        window_posx = screen_width - window_width - 10
        window_posy = screen_height - window_height - 30
        win_size = "{:d}x{:d}+{:d}+{:d}".format(window_width, window_height,
                                                window_posx, window_posy)
#        win_size = "100x40+1600+900"
        print(win_size)
        tk_root.geometry(win_size)
        tk_root.wm_attributes("-topmost", 1)  # always on top
        tk_root.title(" ")

        # set the icon
        #    img = tkinter.PhotoImage(file=clock_icon_file)
        #    root.tk.call('wm', 'iconphoto', root._w, img)

        self.time_label = tkinter.Label(text="{:d} : 0{:d}".format(
            self.minite, self.second))
        self.time_label.pack()
        self.time_label.bind("<Button-1>", self.label_click)
        self.todo_entry = tkinter.Entry()
        self.todo_entry.pack()

        # start timer
        self.time_label.after(1000, self.label_update)
        tk_root.mainloop()

    def label_update(self):
        """
        invoked every second util time over
        """
        # time not over
        if self.second_reduce():
            self.time_label.after(1000, self.label_update)
        else:  # time over
            if self.status == Status.WORK:
                result = tkinter.messagebox.askyesno(title="Work Time Down",
                                                     message="Have Focued?", icon="info")
                if result:
                    self.log_file.write(str(datetime.datetime.now()) + " p+ ")
                    self.log_file.write(self.todo_entry.get())
                    self.log_file.write("\n")
                    self.log_file.flush()
                else:
                    self.log_file.write(str(datetime.datetime.now()) + " p- ")
                    self.log_file.write(self.todo_entry.get())
                    self.log_file.write("\n")
                    self.log_file.flush()
                self.status = Status.REST

            else:
                self.status = Status.WORK
        self.set_label_time()

    def label_click(self, event):
        """ invoked when time_label_clicked """
        # timer stopped, click to start
        if self.second == 0 and self.minite == 0:
            if self.status == Status.WORK:
                self.minite = self.work_time
                self.time_label["background"] = "gray85"
            else:
                self.minite = self.rest_time
                self.time_label["background"] = "#33FF00"
            self.label_update()
        # stop the timer
        else:
            self.second = 0
            self.minite = 0

    def second_reduce(self):
        """
        reduce time by second
        return False if time over
        """
        if self.second == 0 and self.minite == 0:
            return False

        if self.second == 0:
            self.second = 59
            self.minite -= 1
        else:
            self.second -= 1
        return True

    def set_label_time(self):
        """ set current time to time_label """
        second_text = str(self.second)
        if self.second < 10:
            second_text = "0" + second_text
        minite_text = str(self.minite)
        if self.minite < 10:
            minite_text = "0" + minite_text
        time_text = minite_text + " : " + second_text
        self.time_label.config(text=time_text)


if __name__ == "__main__":
    UI = PomodoroUI(25, 5)
