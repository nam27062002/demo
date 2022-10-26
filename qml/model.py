import subprocess, os, psutil
import screen_brightness_control as sbc
from subprocess import call
import platform
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
        self.__getInfoOS()
        self.__getInfoCPU()
        self.__getInfoDisk()
        self.__getInfoRAM()
        self.__getInfoBattery()
        self.__getInfoGPU()
    def __getInfoOS(self):
        result = self.__runTerminal("lsb_release -a")
        self.infoOS = self.__convertToList(result)
        my_system = platform.uname()
        self.infoOS.append(["System",my_system.system])
        self.infoOS.append(["Node Name",my_system.node])
        self.infoOS.append(["Release",my_system.release])
        self.infoOS.append(["Version",my_system.version])
        self.infoOS.append(["Machine",my_system.machine])
        self.infoOS.append(["Processor",my_system.processor])
    def __getInfoCPU(self):
        result = self.__runTerminal("lscpu")
        self.infoCPU = self.__convertToList(result)
        try:
            while len(self.infoCPU) >= 25:
                self.infoCPU.pop(25)
        except:
            pass
    def __getInfoDisk(self):
        result = self.__runTerminal("lshw -class disk -class storage")
        self.infoDisk = self.__convertToList(result)
    def __getInfoRAM(self):
        result = self.__runTerminal("sudo dmidecode --type 17", True)
        self.infoRAM = self.__convertToList(result)
    def __getInfoBattery(self):
        result = self.__runTerminal("upower -i `upower -e | grep 'BAT'`")
        self.infoBattery = self.__convertToList(result)
    def __getInfoGPU(self):
        result = self.__runTerminal("glxinfo -B | less", True)
        self.infoGPU = self.__convertToList(result)
    def getInfoMutiDevice(self):
        s = []     
        s.append(self.__findInList("Description",self.infoOS))
        s.append(self.__findInList("Model name",self.infoCPU))
        s.append(self.__findInList("product",self.infoDisk))
        s.append(self.__findInList("Size",self.infoRAM)+ "@ "+ self.__findInList("Speed",self.infoRAM))
        s.append(self.__findInList("energy-full-design",self.infoBattery))   
        s.append(self.__findInList("OpenGL renderer string",self.infoGPU))   
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
    def __runTerminal(self, request, pw=False):
        if pw == True:
            return subprocess.getoutput('echo ' + self.password + "|sudo -S " + request)
        else:
            return subprocess.getoutput(request)
    @staticmethod
    def getNamePC():
        return subprocess.getoutput("whoami")  
    def checkPassword(self,password):
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
        self.__runTerminal("nmcli radio wifi " + key)

    def getStateWifi(self):
        return self.__runTerminal("nmcli radio  wifi")
    
    def getStateBluetooth(self):
        v = self.__runTerminal("service bluetooth status", False)
        x = self.__convertToList(v)
        return self.__findInList("Status", x)

    def turnOffBluetooth(self):
        try:
            self.__runTerminal("sudo systemctl stop bluetooth")
        except:
            print("Error turn off bluetooth1")
        try:
            self.__runTerminal("sudo systemctl stop bluetooth", True)
        except:
            print("Error turn off bluetooth2")

    def turnOnBluetooth(self):
        try:
            self.__runTerminal("sudo systemctl start bluetooth")
        except:
            print("Error turn on bluetooth1")
        try:
            self.__runTerminal("sudo systemctl start bluetooth", True)
        except:
            print("Error turn on bluetooth2")
    @staticmethod
    def disableorEnableKeyboard(key):
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
            v = int(self.__findInList("Device Enabled (121)",self.__convertToList(self.__runTerminal("xinput list-props " + res))))
            if  v== 0:
                return "Off"
            else:
                return "On"
        except:
            print("Error")
    def disableWebcam(self):
        self.__runTerminal("sudo modprobe -r uvcvideo",True)
    def enableWebcam(self):
        self.__runTerminal("sudo modprobe uvcvideo",True)
    def getStateWebcam(self):
        v = self.__runTerminal("v4l2-ctl --list-devices")
        if "Cannot" in v:
            return "Off"
        else:
            return "On"
    def getStateTouchpad(self):
        return str(subprocess.check_output(["gsettings", "get", "org.gnome.desktop.peripherals.touchpad", "send-events"]))
    def toggle_touchpad(self):
        if self.getStateTouchpad().__contains__("enable"):
            newval = 'disabled'
        else:
            newval = 'enabled'
        subprocess.Popen(["gsettings", "set", "org.gnome.desktop.peripherals.touchpad", "send-events", newval])
    def toggle_micro(self):
        self.__runTerminal("amixer -D pulse sset Capture toggle")
    def getStateMicro(self):      
        if self.__runTerminal("pactl list | sed -n '/^Source/,/^$/p' | grep Mute").count("yes") == 2:
            return False
        else:
            return True
    def changeModePower(self,key):  
        if key == 1:        
            self.__runTerminal('''gdbus call --system --dest net.hadess.PowerProfiles --object-path /net/hadess/PowerProfiles --method org.freedesktop.DBus.Properties.Set 'net.hadess.PowerProfiles' 'ActiveProfile' "<'performance'>"''')
        elif key == 2:
            self.__runTerminal('''gdbus call --system --dest net.hadess.PowerProfiles --object-path /net/hadess/PowerProfiles --method org.freedesktop.DBus.Properties.Set 'net.hadess.PowerProfiles' 'ActiveProfile' "<'balanced'>"''')
        else:
            self.__runTerminal('''gdbus call --system --dest net.hadess.PowerProfiles --object-path /net/hadess/PowerProfiles --method org.freedesktop.DBus.Properties.Set 'net.hadess.PowerProfiles' 'ActiveProfile' "<'power-saver'>"''')
    def getStateModePower(self):
        res = self.__runTerminal("gdbus introspect --system --dest net.hadess.PowerProfiles --object-path /net/hadess/PowerProfiles")
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
        res = self.__runTerminal("amixer -D pulse")
        s = ""
        check = False
        for i in range(res.find("Front Left: Playback"),len(res),1):
            if res[i] == "%":
                break
            if check:
                s += res[i]
            if res[i] == "[":
                check = True
        return int(s)
    def seenInfo(self,data):
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