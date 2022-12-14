import os
import sys, threading,time
from model import data
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject,Slot,Signal
from pathlib import Path
class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.data = data()
        self.running = True
        self.threadPanel = False
        self.threadSystem = False
        self.thread()
    # ---------------------signal---------------------------------------
    getNamePC = Signal(str)
    checkPassword = Signal(bool)
    percentBrightness = Signal(int)
    percentVolume = Signal(int)
    statusWifi = Signal(str)
    statusBluetooth = Signal(str)
    statusKeyboard = Signal(str)
    statusWebcam = Signal(str)
    statusTouchpad = Signal(str)
    statusMicro = Signal(bool)
    statusModePower = Signal(int)
    seenSignalShowSceen = Signal(list,int)
    seenInfo = Signal(list)
    seenPercentCPU = Signal(float)
    seenDataSystem = Signal(int)
    seenPercentRAM = Signal(float)
    seenDataMemoryDisk = Signal(list)
    seenPercentGPU = Signal(float)
    seenToday = Signal(list)
    SeenPercentGPU = Signal(float)
    seenPercentBattery = Signal(float)
    seenHistory = Signal(list)
    #-------------------send function-------------------------------------
    # lay lich su sua doi
    @Slot()
    def getHistory(self):
        self.seenHistory.emit(self.data.listHistory)
    # nhan tinh hieu va gui ten pc
    @Slot()
    def funcGetNamePC(self):
        self.getNamePC.emit(self.data.getNamePC())
    # nhan password va gui bool
    @Slot(str)
    def funcCheckPassword(self,password):
        def newThread():
            self.checkPassword.emit(self.data.checkPassword(password))
        threading.Thread(target=newThread).start()
    # nhan % do sang man 
    @Slot(int)
    def funcChangeBrightness(self,percent):
        data.change_brightness(percent)
    # nhan tin hieu ket thuc chuong trinh
    @Slot()
    def closeProgram(self):
        self.data.saveFile()
        self.running = False
    # nhan tinh hieu loop panel
    @Slot()
    def loopPanel(self):
        if self.threadPanel:
            self.threadPanel = False
        else:
            self.threadPanel = True
    # nhan tinh hieu loop system
    @Slot()
    def loopSystem(self):
        if self.threadSystem:
            self.threadSystem = False
        else:
            self.threadSystem = True
    # gui do sang man hinh 
    def seenBrightness(self):
        while self.running:
            if (self.threadPanel):
                self.percentBrightness.emit(self.data.getCurrentBrightness())
                time.sleep(0.1)
    # gui trang thai wifi
    def seenStatusWifi(self):
        while self.running:
            if (self.threadPanel):
                self.statusWifi.emit(self.data.getStateWifi())
                time.sleep(0.1)
    # gui trang thai bluetooth
    def seenStatusBluetooth(self):
        while self.running:
            if (self.threadPanel):
                self.statusBluetooth.emit(self.data.getStateBluetooth())
                time.sleep(0.1)
    # gui trang thai keyboard
    def seenStatusKeyboard(self):
        while self.running:
            if (self.threadPanel):
                self.statusKeyboard.emit(self.data.getStateKeyboard())
                time.sleep(0.1)
    # gui trang thai webcam
    def seenStatusWebcam(self):
        while self.running:
            if (self.threadPanel):
                self.statusWebcam.emit(self.data.getStateWebcam())
                time.sleep(0.1)
    # gui trang thai touchpad
    def seenStatusTouchpad(self):
        while self.running:
            if (self.threadPanel):
                self.statusTouchpad.emit(self.data.getStateTouchpad())
                time.sleep(0.1)
    # gui trang thai micro
    def seenStatusMic(self):
        while self.running:
            if (self.threadPanel):
                self.statusMicro.emit(self.data.getStateMicro())
                time.sleep(0.1)
    # gui trang thai power
    def seenStatusPower(self):
        while self.running:
            if (self.threadPanel):
                self.statusModePower.emit(self.data.getStateModePower())
                time.sleep(0.1)
    # gui phan tram volume 
    def seenStatusVolume(self):
        while self.running:
            if (self.threadPanel):
                self.percentVolume.emit(self.data.getPercentVolume())
                time.sleep(0.1)
    # gui percent cpu 
    def percentCPU(self):
        while self.running:
            if (self.threadSystem):
                self.seenPercentCPU.emit(self.data.getPercentCPU())
                self.seenPercentRAM.emit(self.data.getPercentRamUsed())
                time.sleep(0.1)
    # gui percent gpu
    def percentGPU(self):
        while self.running:
            if (self.threadSystem):
                self.seenPercentGPU.emit(self.data.getPercentGPU())
                self.seenPercentBattery.emit(self.data.getPercentBattery())
                time.sleep(1)
    @Slot()
    def seenDataSystemm(self):
        self.seenDataSystem.emit(self.data.getMemory())      
    # turn on Wifi
    @Slot(bool)
    def turnOnAndOffWifi(self,check):
        if (check):
            self.data.turnOnOrOffWifi("on")
        else:
            self.data.turnOnOrOffWifi("off")
    # turn on or off bluetooth
    @Slot(bool)
    def turnOnAndOffBluetooth(self,check):
        if (check):
            self.data.turnOnBluetooth()
        else:
            self.data.turnOffBluetooth()
    # turn on or off keyboard
    @Slot(bool)
    def turnOnAndOffKeyboard(self,check):
        if (check):
            self.data.disableorEnableKeyboard("changeModePower")
        else:
            self.data.disableorEnableKeyboard("disable")
    # change mode power
    @Slot(int)
    def changeModePower(self,key):
        self.data.changeModePower(key)
    # turn on or off webcam
    @Slot(bool)
    def turnOnAndOffWebcam(self,check):
        if (check):
            self.data.enableWebcam()
        else:
            self.data.disableWebcam()
    # disable and enable touchpad
    @Slot()
    def toggle_touchpad(self):
        self.data.toggle_touchpad()
    # toggle micro
    @Slot()
    def toggle_micro(self):
        self.data.toggle_micro()
    @Slot(int)
    def changeVolume(self,value):
        self.data.changeVolume(value)
    # nhan tinh hieu show man hinh
    @Slot(str,int)
    def showScreen(self,data,val):
        self.seenSignalShowSceen.emit(self.data.seenInfo(data),val)
    @Slot()
    def seenInfoOS(self):
        self.seenInfo.emit(self.data.getInfoMutiDevice())
    @Slot()
    def seenDay(self):
        self.seenToday.emit(self.data.getDate())
    # tao cac luong
    def thread(self):
        threading.Thread(target=self.seenBrightness).start()
        threading.Thread(target=self.seenStatusWifi).start()
        threading.Thread(target=self.seenStatusBluetooth).start()
        threading.Thread(target=self.seenStatusKeyboard).start()
        threading.Thread(target=self.seenStatusWebcam).start()
        threading.Thread(target=self.seenStatusTouchpad).start()
        threading.Thread(target=self.seenStatusMic).start()
        threading.Thread(target=self.seenStatusPower).start()
        threading.Thread(target=self.seenStatusVolume).start()
        threading.Thread(target=self.percentCPU).start()
        threading.Thread(target=self.percentGPU).start()
        
