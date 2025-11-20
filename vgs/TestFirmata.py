import pyfirmata
import time
#import nødvendige libraries

board = pyfirmata.Arduino('COM7') # sette på port 7
it = pyfirmata.util.Iterator(board)
it.start()

analog_x = board.get_pin('a:0:i') # Leser av A0 på arduino
analog_y = board.get_pin('a:1:i') # Leser av A1 på arduino

while True: # Looper koden
	
	XValue = analog_x.read() # Leser Xverdi
	YValue = analog_y.read() # Leser Yverdi
	print(XValue) # Printer verdien
	print('') # Mellomrom for å kunne lese lettere
	time.sleep(0.1) # Delay