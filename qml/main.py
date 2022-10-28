import os
import sys, threading,time
from model import data
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject,Slot,Signal
from pathlib import Path
from controller import MainWindow

if __name__ == "__main__":
    
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    main = MainWindow()
    engine.rootContext().setContextProperty("backend",main)
    engine.load(os.fspath(Path(__file__).resolve().parent / "main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
