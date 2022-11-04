import psutil
readtime = (psutil.disk_io_counters().read_time / 1000) / 1000
writetime = (psutil.disk_io_counters().write_time / 1000) / 1000
busytime = readtime + writetime
percentage = (busytime) / 60
print(percentage)