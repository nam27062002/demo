from concurrent.futures import thread
import subprocess, os, psutil
import screen_brightness_control as sbc
from subprocess import call
import platform
import threading
import datetime
from datetime import date


class data:
    def __init__(self):
        self.password = "123456"
        self.infoBIOS = []
        self.infoOS = []
        self.infoCPU = []
        self.infoDisk = []
        self.infoRAM = []
        self.infoBattery = []
        self.infoGPU = []
        self.listHistory = self.history()
        self.__getInfoOS()
        self.__getInfoCPU()
        self.__getInfoDisk()
        self.__getInfoRAM()
        self.__getInfoBattery()
        self.__getInfoGPU()

    def __getInfoOS(self):
        result = self.runTerminal("lsb_release -a")
        self.infoOS = self.__convertToList(result)
        my_system = platform.uname()
        self.infoOS.append(["System", my_system.system])
        self.infoOS.append(["Node Name", my_system.node])
        self.infoOS.append(["Release", my_system.release])
        self.infoOS.append(["Version", my_system.version])
        self.infoOS.append(["Machine", my_system.machine])
        self.infoOS.append(["Processor", my_system.processor])

    def __getInfoCPU(self):
        result = self.runTerminal("lscpu")
        self.infoCPU = self.__convertToList(result)
        try:
            while len(self.infoCPU) >= 25:
                self.infoCPU.pop(25)
        except:
            pass
        for i in self.infoCPU:
            if i[0] == "Flags":
                self.infoCPU.remove(i)
                break
        for i in self.infoCPU:
            if i[0] == "NUMA node0 CPU(s)":
                self.infoCPU.remove(i)
                break

    def __getInfoDisk(self):
        result = self.runTerminal("lshw -class disk -class storage")
        self.infoDisk = self.__convertToList(result)
        s = []
        for i in self.infoDisk:
            if i[0] == "WARNING" or i[0] == "":
                s.append(i)
        index = 0
        for i in self.infoDisk:
            if index == 1:
                s.append(i)
            if i[0] == "clock":
                index = 1
        for i in s:
            try:
                self.infoDisk.remove(i)
            except:
                pass
        for i in self.infoDisk:
            if i[0] == "physical id":
                try:
                    self.infoDisk.remove(i)
                except:
                    pass
        result1 = self.runTerminal("sudo lshw -c disk", True)
        v1 = self.__convertToList(result1)
        x = self.__findInList("size", v1)
        self.infoDisk.append(['size', x])

    def __getInfoRAM(self):
        result = self.runTerminal("sudo dmidecode --type 17", True)
        self.infoRAM = self.__convertToList(result)
        s = []
        try:
            for i in self.infoRAM:
                if i[0] == '' or i[1] == '' or i[1] == "Unknown" or i[1] == "None" or i[0] == "[sudo] password for nam":
                    s.append(i)
            for i in s:
                self.infoRAM.remove(i)
        except:
            pass

    def __getInfoBattery(self):
        result = self.runTerminal("upower -i `upower -e | grep 'BAT'`")
        self.infoBattery = self.__convertToList(result)
        self.infoBattery.pop(4)
        try:
            for i in self.infoBattery:
                if i[0] == '' or i[1] == '':
                    self.infoBattery.remove(i)
        except:
            pass
        for i in range(-2, 0, 1):
            self.infoBattery.pop(i)

    def __getInfoGPU(self):
        result = self.runTerminal("glxinfo -B | less", True)
        self.infoGPU = self.__convertToList(result)
        s = []
        for i in self.infoGPU:
            if i[0] == "" or i[1] == "0" or i[1] == "" or i[0].find("OpenGL") != -1:
                s.append(i)
        for i in s:
            self.infoGPU.remove(i)
        index = 0
        for count, i in enumerate(self.infoGPU):
            if i[0] == "Device":
                index = count
                break
        ss = self.infoGPU[index][1]
        start = 0
        c = ""
        for i in range(len(ss) - 1, -1, -1):
            if ss[i] == ")":
                start = 1
            if start == 1:
                c = ss[i] + c
            if ss[i] == "(":
                break
        self.infoGPU[index][1] = ss.removesuffix(c)

    def getInfoMutiDevice(self):
        s = []
        s.append(self.__findInList("Description", self.infoOS))
        s.append(self.__findInList("Model name", self.infoCPU))
        s.append(self.__findInList("product", self.infoDisk))
        s.append(self.__findInList("Size", self.infoRAM) + "@ " + self.__findInList("Speed", self.infoRAM))
        s.append(self.__findInList("energy-full-design", self.infoBattery))
        s.append(self.__findInList("Device", self.infoGPU))
        return s

    @staticmethod
    def __convertToList(c):
        s = c.replace("\t", "")
        start = False
        index = -1
        for i in range(len(s)):
            if s[i] == ":":
                start = True
                break
            if s[i] == "\n":
                index = i
        res = [["", ""]]
        count = 0
        v = ""
        state = 0
        for i in range(index + 1, len(s), 1):
            if s[i] == ":":
                state = 1
                res[count][0] = v.lstrip()
                v = ""
            elif s[i] == "\n":
                state = 2
                res[count][1] = v.lstrip()
                res.append(["", ""])
                count += 1
                v = ""
            if s[i] != ":" and s[i] != "\n":
                v += s[i]
            if (i == len(s) - 1):
                res[count][1] = v.lstrip()
        return res

    @staticmethod
    def __findInList(value, v):
        for i in range(len(v)):
            if value in v[i][0]:
                return v[i][1] + " "
                break

    def runTerminal(self, request, pw=False):
        if pw == True:
            return subprocess.getoutput('echo ' + self.password + "|sudo -S " + request)
        else:
            return subprocess.getoutput(request)

    @staticmethod
    def getNamePC():
        return subprocess.getoutput("whoami")

    def checkPassword(self, password):
        if os.system('echo %s|sudo -S %s' % (password, "sudo dmidecode -t bios -q")) == 256:
            self.password = password
            return False
        else:
            return True

    @staticmethod
    def change_brightness(value):
        os.system(
            'gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.freedesktop.DBus.Properties.Set org.gnome.SettingsDaemon.Power.Screen Brightness "<int32 ' + str(
                value) + '>"')

    @staticmethod
    def getCurrentBrightness():
        return sbc.get_brightness()[0]

    def turnOnOrOffWifi(self, key):
        if key == "on":
            self.addHistory("Wi-fi", 1)
        else:
            self.addHistory("Wi-fi", 0)
        self.runTerminal("nmcli radio wifi " + key)

    def getStateWifi(self):
        return self.runTerminal("nmcli radio  wifi")

    def addHistory(self, device, status, check=0):
        if check == 0:
            if status == 1:
                s = "On"
            else:
                s = "Off"
        else:
            if check == 1:
                s = "Performance"
            elif check == 2:
                s = "Balanced"
            else:
                s = "Power saver"
        self.listHistory.reverse()
        self.listHistory.append([device, s, self.getDatetimeNow()])
        self.listHistory.reverse()

    def getStateBluetooth(self):
        v = self.runTerminal("service bluetooth status", False)
        x = self.__convertToList(v)
        return self.__findInList("Status", x)

    def turnOffBluetooth(self):
        self.addHistory("Bluetooth", 0)
        try:
            self.runTerminal("sudo systemctl stop bluetooth")
        except:
            print("Error turn off bluetooth1")
        try:
            self.runTerminal("sudo systemctl stop bluetooth", True)
        except:
            print("Error turn off bluetooth2")

    def turnOnBluetooth(self):
        self.addHistory("Bluetooth", 1)
        try:
            self.runTerminal("sudo systemctl start bluetooth")
        except:
            print("Error turn on bluetooth1")
        try:
            self.runTerminal("sudo systemctl start bluetooth", True)
        except:
            print("Error turn on bluetooth2")

    def disableorEnableKeyboard(self, key):
        if key == "enable":
            self.addHistory("Keyboard", 1)
        else:
            self.addHistory("Keyboard", 0)
        x = subprocess.getoutput("xinput list")
        check = False
        res = ""
        try:
            for i in range(len(x)):
                if x[i] == "k" and x[i + 1] == "e" and x[i + 2] == "y" and x[i + 3] == "b" and x[i + 4] == "o" and x[
                    i + 8] == ":":
                    check = True
                if check == True:
                    if x[i] == "i" and x[i + 1] == "d" and x[i + 2] == "=":
                        for j in range(i + 3, len(x), 1):
                            if x[j] == "[":
                                break
                            else:
                                res += x[j]
            os.system("xinput --" + key + " " + res)
        except:
            print("Error")

    def getStateKeyboard(self):
        x = subprocess.getoutput("xinput list")
        check = False
        res = ""
        try:
            for i in range(len(x)):
                if x[i] == "k" and x[i + 1] == "e" and x[i + 2] == "y" and x[i + 3] == "b" and x[i + 4] == "o" and x[
                    i + 8] == ":":
                    check = True
                if check == True:
                    if x[i] == "i" and x[i + 1] == "d" and x[i + 2] == "=":
                        for j in range(i + 3, len(x), 1):
                            if x[j] == "[":
                                break
                            else:
                                res += x[j]
            v = int(self.__findInList("Device Enabled (121)",
                                      self.__convertToList(self.runTerminal("xinput list-props " + res))))
            if v == 0:
                return "Off"
            else:
                return "On"
        except:
            print("Error")

    def disableWebcam(self):
        self.addHistory("Webcam", 0)
        self.runTerminal("sudo modprobe -r uvcvideo", True)

    def enableWebcam(self):
        self.addHistory("Webcam", 1)
        self.runTerminal("sudo modprobe uvcvideo", True)

    def getStateWebcam(self):
        v = self.runTerminal("v4l2-ctl --list-devices")
        if "Cannot" in v:
            return "Off"
        else:
            return "On"

    def getStateTouchpad(self):
        return str(
            subprocess.check_output(["gsettings", "get", "org.gnome.desktop.peripherals.touchpad", "send-events"]))

    def toggle_touchpad(self):
        if self.getStateTouchpad().__contains__("enable"):
            self.addHistory("Touchpad", 0)
            newval = 'disabled'
        else:
            self.addHistory("Touchpad", 1)
            newval = 'enabled'
        subprocess.Popen(["gsettings", "set", "org.gnome.desktop.peripherals.touchpad", "send-events", newval])

    def toggle_micro(self):
        if self.getStateMicro() == True:
            self.addHistory("Micro", 1)
        else:
            self.addHistory("Micro", 0)
        self.runTerminal("amixer -D pulse sset Capture toggle")

    def getStateMicro(self):
        if self.runTerminal("pactl list | sed -n '/^Source/,/^$/p' | grep Mute").count("yes") == 2:
            return False
        else:
            return True

    def changeModePower(self, key):
        self.addHistory("Power", 1, key)
        if key == 1:
            self.runTerminal(
                '''gdbus call --system --dest net.hadess.PowerProfiles --object-path /net/hadess/PowerProfiles --method org.freedesktop.DBus.Properties.Set 'net.hadess.PowerProfiles' 'ActiveProfile' "<'performance'>"''')
        elif key == 2:
            self.runTerminal(
                '''gdbus call --system --dest net.hadess.PowerProfiles --object-path /net/hadess/PowerProfiles --method org.freedesktop.DBus.Properties.Set 'net.hadess.PowerProfiles' 'ActiveProfile' "<'balanced'>"''')
        else:
            self.runTerminal(
                '''gdbus call --system --dest net.hadess.PowerProfiles --object-path /net/hadess/PowerProfiles --method org.freedesktop.DBus.Properties.Set 'net.hadess.PowerProfiles' 'ActiveProfile' "<'power-saver'>"''')

    def getStateModePower(self):
        res = self.runTerminal(
            "gdbus introspect --system --dest net.hadess.PowerProfiles --object-path /net/hadess/PowerProfiles")
        index = res.find("ActiveProfile")
        if res[index + 17] + res[index + 18] == "ba":
            return 2
        elif res[index + 17] + res[index + 18] == "pe":
            return 1
        else:
            return 3

    @staticmethod
    def changeVolume(value):
        call(["amixer", "-D", "pulse", "sset", "Master", str(value) + "%"])

    def getPercentVolume(self):
        res = self.runTerminal("amixer -D pulse")
        s = ""
        check = False
        for i in range(res.find("Front Left: Playback"), len(res), 1):
            if res[i] == "%":
                break
            if check:
                s += res[i]
            if res[i] == "[":
                check = True
        return int(s)

    def seenInfo(self, data):
        if data == "OS":
            return self.infoOS
        elif data == "CPU":
            return self.infoCPU
        elif data == "DISK":
            return self.infoDisk
        elif data == "Memory":
            return self.infoRAM
        elif data == "Battery":
            return self.infoBattery
        else:
            return self.infoGPU

    def getPercentCPU(self):
        return psutil.cpu_percent()

    def getMemory(self):
        return int(self.__findInList("Size", self.infoRAM).replace("GB", ""))

    def getPercentRamUsed(self):
        return psutil.virtual_memory()[2]

    def getToTalMemoryDisk(self):
        x = self.runTerminal("df -h")
        s = []
        a = []
        v = ""
        for count, i in enumerate(x):
            if i == "\n" or count + 1 == len(x):
                s.append(a)
                a = []
                continue
            if i != " ":
                v += i
            elif i == " " and x[count - 1] != " ":
                a.append(v)
                v = ""
        s.pop(0)
        return s

    @staticmethod
    def convertMB(data):
        if "K" in data:
            return 0
        elif "M" in data:
            data = data.replace("M", "")
            data1 = ""
            for i in range(len(data)):
                if (data[i] == ","):
                    data1 += "."
                else:
                    data1 += data[i]
            return float(data1) / 1024
        elif "G" in data:
            data = data.replace("G", "")
            data1 = ""
            for i in range(len(data)):
                if (data[i] == ","):
                    data1 += "."
                else:
                    data1 += data[i]
            return float(data1)

    @staticmethod
    def getDate():
        today = date.today()
        return [today.day, today.month, today.year]

    @staticmethod
    def getPercentGPU():
        f = open("qml/gpu.txt", "r")
        lines = f.readlines()
        x = ""
        for line in lines:
            x = line
        arr = []
        s = ""
        for index, value in enumerate(x):
            if value != " ":
                s += value
            elif value == " " and x[index - 1] != " ":
                arr.append(s)
                s = ""
        try:
            return float(arr[5])
        except:
            pass

    def getPercentBattery(self):
        x = self.runTerminal("upower -i `upower -e | grep 'BAT'`")
        x = self.__convertToList(x)
        for i in x:
            if i[0] == "percentage":
                x = i[1]
                break
        x = x.replace("%", "")
        return float(x)

    def history(self):
        f = open("qml/history.txt", "r")
        lines = f.readlines()
        arr = []
        for line in lines:
            arr.append([])
            s = ""
            for index, i in enumerate(line):
                if i != "|":
                    s += i
                else:
                    arr[-1].append(s)
                    s = ""
                if index == len(line) - 2:
                    arr[-1].append(s)
        arr.reverse()
        return arr

    def saveFile(self):
        f = open("qml/history.txt", "w")
        self.listHistory.reverse()
        for i in self.listHistory:
            s = ""
            for j in range(len(i)):
                if j != len(i) - 1:
                    s += i[j] + "|"
                else:
                    s += i[j] + "\n"
            f.write(s)

    @staticmethod
    def getDatetimeNow():
        x = datetime.datetime.now()
        return str(x.year) + "-" + str(x.month) + "-" + str(x.day) + " " + str(x.hour) + ":" + str(
            x.minute) + ":" + str(x.second)
