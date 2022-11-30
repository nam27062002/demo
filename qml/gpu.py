from model import data
import threading
import time
x = data()
x.runTerminal("sudo intel_gpu_top -o qml/gpu.txt",True)

