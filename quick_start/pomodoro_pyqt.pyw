#!/bin/python

import sys
from PyQt5.QtCore import QTimer
from PyQt5.QtWidgets import QApplication, QVBoxLayout, QLCDNumber, QWidget, QMessageBox, QLineEdit
from PyQt5.QtCore import Qt
import datetime
import os

"""
还是qt的代码比较舒服
一方面Timer看起来比用Tk用label空间要优雅
然后窗口控制上移动的位置也好控制
还有个不知道哪方面的bug，窗口无法移动到最右方（移动到右边约1/4位置会移动失效）
"""


class Pomodoro(QWidget):
    def __init__(self, parent=None):
        super(Pomodoro, self).__init__(parent)
        self.resize(70, 35)
        desktop = QApplication.desktop()
        win_x = (desktop.width() - self.width()) // 2 + 600
        win_y = (desktop.height() - self.height()) // 2
        self.move(win_x, win_y)

        self.setWindowTitle("QTimerDemo")
        self.setWindowFlags(Qt.WindowStaysOnTopHint)

        self.lcdWidget = QLCDNumber()
        self.lcdWidget.setDigitCount(10)
        self.lcdWidget.setMode(QLCDNumber.Dec)
        self.lcdWidget.setSegmentStyle(QLCDNumber.Flat)
        self.lcdWidget.setNumDigits(5)
        self.lcdWidget.display("25:00")

        self.todoTextEdit = QLineEdit()

        layout = QVBoxLayout()
        layout.addWidget(self.lcdWidget)
        layout.addWidget(self.todoTextEdit)
        layout.setSpacing(1)
        layout.setContentsMargins(0, 0, 0, 0)
        self.setLayout(layout)

        # 新建一个QTimer对象
        self.timer = QTimer()
        self.timer.setInterval(1000)
        self.timer.start()
        self.timer.timeout.connect(self.onTimeEverySecond)

        # 时间
        self.workTime = 25
        self.restTime = 5
        self.minite = self.workTime
        self.second = 1
        self.workStatus = "WORK"

        # log
        self.logFile = open("pomodoro.log", "a+")

        self.isClicked = False  # 判断是否为鼠标点击过

    def onTimeEverySecond(self):
        """ 每秒运行一次，时间操作与显示操作 """
        if self.workStatus == "WORK-IDEL" or self.workStatus == "REST-IDEL":
            return

        if self.second == 0 and self.minite == 0:
            self.timeOverProcessing()
        else:
            if self.second == 0:
                self.second = 59
                self.minite -= 1
            else:
                self.second -= 1

        self.lcdWidget.display(self.get_label_time_string())

    def timeOverProcessing(self):
        print("time over")
        if self.isClicked:
            self.isClicked = False
        else:
            os.system("flyPoints")
        if self.workStatus == "WORK":
            msgBox = QMessageBox()
            msgBox.setIcon(QMessageBox.Information)
            msgBox.setText("Have focused?")
            msgBox.setWindowTitle("Example")
            msgBox.setStandardButtons(QMessageBox.Yes | QMessageBox.No)
            desktop = QApplication.desktop()
            msgBox.move(desktop.width() / 2, desktop.height() / 2)
            result = msgBox.exec()
            if result == QMessageBox.Yes:
                self.writePomodoroLog()
            self.workStatus = "WORK-IDEL"  # WORK状态转的IDEL
        elif self.workStatus == "REST":
            self.workStatus = "REST-IDEL"

    def mousePressEvent(self, event):
        if event.buttons() == Qt.LeftButton:
            # WORK状态计时完毕转的WORK-IDEL状态
            if self.workStatus == "WORK-IDEL":
                self.workStatus = "REST"
                self.minite = self.restTime
            # REST状态计时完毕转的REST-IDEL状态
            elif self.workStatus == "REST-IDEL":
                self.workStatus = "WORK"
                self.minite = self.workTime
            # WORK状态或者REST状态正在计时（计时器清零）
            else:
                self.isClicked = True
                self.minite = 0
                self.second = 0

            event.accept()

    def writePomodoroLog(self):
        self.logFile.write(str(datetime.datetime.now()) + " p+ ")
        self.logFile.write(self.todoTextEdit.text())
        self.logFile.write("\n")
        self.logFile.flush()

    def get_label_time_string(self):
        """ set current time to time_label """
        second_text = str(self.second)
        if self.second < 10:
            second_text = "0" + second_text
        minite_text = str(self.minite)
        if self.minite < 10:
            minite_text = "0" + minite_text
        time_text = minite_text + ":" + second_text
        return time_text


if __name__ == '__main__':

    app = QApplication(sys.argv)
    t = Pomodoro()
    t.show()
    sys.exit(app.exec_())
