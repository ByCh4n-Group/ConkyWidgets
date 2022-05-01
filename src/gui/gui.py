import os
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtCore import Qt
from time import sleep

version = "2.0.0"

class Ui_MainWindow(object):

    def setupUi(self, MainWindow):
        self.the_list = []
        MainWindow.setObjectName("MainWindow")
        MainWindow.setFixedSize(390, 230)


        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.label = QtWidgets.QLabel(self.centralwidget)
        self.label.setGeometry(QtCore.QRect(190, -60, 261, 141))
        self.label.setObjectName("label")

        self.pushButton = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton.setGeometry(QtCore.QRect(250, 150, 111, 31))
        self.pushButton.setObjectName("pushButton")
        self.pushButton.clicked.connect(self.okbutton)



        self.pushButton_2 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton_2.setGeometry(QtCore.QRect(125, 150, 111, 31))
        self.pushButton_2.setObjectName("pushButton_2")
        self.pushButton_2.clicked.connect(self.quitbutton)


        self.checkBox = QtWidgets.QCheckBox(self.centralwidget)
        self.checkBox.setGeometry(QtCore.QRect(30, 20, 81, 20))
        self.checkBox.setObjectName("checkBox")
        self.checkBox.stateChanged.connect(self.clockisok)

        self.checkBox_2 = QtWidgets.QCheckBox(self.centralwidget)
        self.checkBox_2.setGeometry(QtCore.QRect(30, 50, 81, 20))
        self.checkBox_2.setObjectName("checkBox_2")
        self.checkBox_2.stateChanged.connect(self.fileisok)

        self.checkBox_3 = QtWidgets.QCheckBox(self.centralwidget)
        self.checkBox_3.setGeometry(QtCore.QRect(30, 80, 81, 20))
        self.checkBox_3.setObjectName("checkBox_3")
        self.checkBox_3.stateChanged.connect(self.spotify)

        self.checkBox_4 = QtWidgets.QCheckBox(self.centralwidget)
        self.checkBox_4.setGeometry(QtCore.QRect(30, 110, 81, 20))
        self.checkBox_4.setObjectName("checkBox_4")
        self.checkBox_4.stateChanged.connect(self.status)

        self.checkBox_5 = QtWidgets.QCheckBox(self.centralwidget)
        self.checkBox_5.setGeometry(QtCore.QRect(30, 140, 81, 20))
        self.checkBox_5.setObjectName("checkBox_5")
        self.checkBox_5.stateChanged.connect(self.system)

        MainWindow.setCentralWidget(self.centralwidget)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)
        self.menubar = QtWidgets.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 380, 26))
        self.menubar.setObjectName("menubar")
        MainWindow.setMenuBar(self.menubar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "Conky Widget Manager"))
        self.label.setText(_translate("MainWindow", f"Conky Widget Manager Ver {version}"))
        self.pushButton.setText(_translate("MainWindow", "Ok"))
        self.pushButton_2.setText(_translate("MainWindow", "Quit"))
        self.checkBox.setText(_translate("MainWindow", "Clock"))
        self.checkBox_2.setText(_translate("MainWindow", "File"))
        self.checkBox_3.setText(_translate("MainWindow", "Spotify"))
        self.checkBox_4.setText(_translate("MainWindow", "Status"))
        self.checkBox_5.setText(_translate("MainWindow", "System"))

    def clockisok(self,state):
        if state == Qt.Checked:
            self.the_list.append(" clock")
        elif state == Qt.Unchecked:
            if " clock" in self.the_list:
                self.the_list.remove(" clock")
            else:
                pass
    def fileisok(self,state):
        if state == Qt.Checked:
            self.the_list.append(" file")
        elif state == Qt.Unchecked:
            if " file" in self.the_list:
                self.the_list.remove(" file")
            else:
                pass

    def spotify(self,state):
        if state == Qt.Checked:
            self.the_list.append(" spotify")
        elif state == Qt.Unchecked:
            if " spotify" in self.the_list:
                self.the_list.remove(" spotify")
            else:
                pass

    def status(self,state):
        if state == Qt.Checked:
            self.the_list.append(" status")
        elif state == Qt.Unchecked:
            if " status" in self.the_list:
                self.the_list.remove(" status")
            else:
                pass

    def system(self,state):
        if state == Qt.Checked:
            self.the_list.append(" system")
        elif state == Qt.Unchecked:
            if " system" in self.the_list:
                self.the_list.remove(" system")
            else:
                pass

    def okbutton(self):
        wdglist = ""
        for m in range(0,len(self.the_list)):
            wdglist = wdglist + self.the_list[m]
        actvwidgets = "cwmanager --setup" + wdglist
        usewidgets = "cwmanager --reload" + wdglist
        os.system(actvwidgets)
        sleep(0.5)
        os.system(usewidgets)
        sys.exit(app.exec_())


    def quitbutton(self):
        self.the_list.clear()
        sys.exit(app.exec_())

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())
