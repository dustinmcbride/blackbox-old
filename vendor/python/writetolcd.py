#!/usr/bin/python

# Usage: wrtitetolcd.py "message for line 1" "message for line 2"

from Adafruit_CharLCD import Adafruit_CharLCD

import sys

total = len(sys.argv)
cmdargs = str(sys.argv)

lcd = Adafruit_CharLCD()
lcd.begin(16, 2)
lcd.clear()


lcd.message(sys.argv[1])
lcd.message("\n")
lcd.message(sys.argv[2])
