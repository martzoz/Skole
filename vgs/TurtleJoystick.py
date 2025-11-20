from turtle import *
import pyfirmata
import time

board = pyfirmata.Arduino('COM7') # sette på port 7
it = pyfirmata.util.Iterator(board)
it.start()

analog_x = board.get_pin('a:0:i') # Leser av A0 på arduino
analog_y = board.get_pin('a:1:i') # Leser av A1 på arduino

speed(250)
shape("turtle")

while True: # Looper koden
	
	XValue = analog_x.read() # Leser Xverdi
	YValue = analog_y.read() # Leser Yverdi
	print(XValue)

	if XValue is not None:
		if XValue < 0.8:
			left(20)
		if XValue > 0.3:
			right(20)

	if YValue is not None:
		if YValue > 0.8:
			backward(20)
		if YValue < 0.3:
			forward(20)

	time.sleep(0.001)