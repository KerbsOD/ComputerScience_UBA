#!/usr/bin/env python

from libtest import *
import subprocess
import sys

# Este script crea las multiples imagenes de prueba a partir de unas
# pocas imagenes base.


IMAGENES=["NoCountryForOldMen.bmp","Wargames.bmp"]

assure_dirs()

sizes=['2048x1200','1024x600','512x300', '256x150', '128x75', '64x37', '32x18', '32x18']


for filename in IMAGENES:
	print(filename)
	for size in sizes:
		sys.stdout.write("  " + size)
		name = filename.split('.')
		file_in  = DATADIR + "/" + filename
		file_out = TESTINDIR + "/" + name[0] + "." + size + "." + name[1]
		resize = "convert -resize " + size + "! " + file_in + " " + file_out
		subprocess.call(resize, shell=True)
	print("")
