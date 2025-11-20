import serial
import time
from datetime import datetime


ser = serial.Serial(
'COM7', 9600, timeout=0, parity=serial.PARITY_NONE, rtscts=1
)

while True:
	try:
		s = str(ser.readline(100).decode())
		if s != "":
			f = open("Adgangslogg.txt", "a+")
			f.write(str(datetime.now()))
			f.write(" - ")
			f.write(s)
			f.close()
			print(s.strip('\r\n'))
	except:
		print('ERROR')

	time.sleep(1)
