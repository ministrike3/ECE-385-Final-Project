from PIL import Image
from collections import Counter
from scipy.spatial import KDTree
import os
import sys
import numpy as np
def hex_to_rgb(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
def rgb_to_hex(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
filename = input("What's the image name? ")
new_w, new_h = map(int, input("What's the new width x height? Like 40 80. ").split(' '))
palette_hex = ['0xFF00FF', '0x000000', '0x101010', '0xF8F8F8', '0xA7A7A7', '0xFFD2B8', '0xFFD3BA', '0xFFFFFF',
'0xFFA23C', '0xFFDE78', '0xF00000', '0xFF0000', '0x9A9A9A','0x431313', '0xF44418', '0x5C3C25' ,
'0xFF7233', '0xFA9A6C', '0xFFD3BA', '0x736037', '0xB3C2D4', '0x003C86',
'0x0056D0', '0x1E1E50', '0x6F5144', '0xCA673C', '0xEF6225', '0xFC6220', '0xB3C2D4',
'0xB3C2D4', '0x0056D0', '0x1E1E50','0x5C3C25', '0x7E6037', '0xFF7233', '0x63D413', '0x003E83', '0x76603C',
'0xC3794E', '0xAD6338', '0xB0663B', '0xB46A3F', '0x442D1A', '0x503926', '0xA3290D', '0x381616', '0x391919', '0xB86E43',
'0xB96F44', '0xFFF30F', '0xFF7B0F', '0x00F000', '0xFF0F0F', '0xA3290D', '0xCF9F87', '0xCFA087']
palette_rgb = [hex_to_rgb(color) for color in palette_hex]

pixel_tree = KDTree(palette_rgb)
im = Image.open("./sprite_originals/" + filename+ ".png") #Can be many different formats.
im = im.convert("RGBA")
im = im.resize((new_w, new_h),Image.ANTIALIAS) # regular resize
pix = im.load()
pix_freqs = Counter([pix[x, y] for x in range(im.size[0]) for y in range(im.size[1])])
pix_freqs_sorted = sorted(pix_freqs.items(), key=lambda x: x[1])
pix_freqs_sorted.reverse()
outImg = Image.new('RGB', im.size, color='white')
outFile = open("./sprite_bytes/" + filename + '.txt', 'w')
i = 0
for y in range(im.size[1]):
    for x in range(im.size[0]):
        pixel = im.getpixel((x,y))
        if(pixel[3] < 200):
            outImg.putpixel((x,y), palette_rgb[0])
            #ministrike3 changed the %x to a %d because I hate hex
            outFile.write("%d\n" % (0))
        else:
            index = pixel_tree.query(pixel[:3])[1]
            outImg.putpixel((x,y), palette_rgb[index])
            #ministrike3 changed the %x to a %d because I hate hex
            outFile.write("%d\n" % (index))
        i += 1
outFile.close()
#--------------
# everything above is a very slightly modified version of github user atrifex's 
#repo named ECE385-helper tools 
#I wanted the ability to have my sprites available to me as arrays 
#So i changed his hex output into decimal
#and then wrote a bit down here that reformats it into the right array 
os.system('cls' if os.name == 'nt' else 'clear')
name = "./sprite_bytes/" + filename + '.txt'
rawtxt =  open(name, "r")
text= rawtxt.read()
text=text.splitlines()
xval=new_w
yval=new_h
os.system('cls' if os.name == 'nt' else 'clear')
f = open("./sprite_bytes/" + filename + 'array.txt', 'w')
sys.stdout = f
swagger = "\'{"
print(filename + " <=")
print("\'{")
for y in range(0,yval):
    for x in range(0,xval):
        values=str(text[y*xval+x])
        if values == "a":
            values = "17"
        if values == "b":
            values = "18"
        if values == "c":
            values = "19"
        if values == "d":
            values = "20"
        if values == "e":
            values = "21"
        if values == "f":
            values = "22"
        if values == "1a":
            values = "23"
        if values == "1b":
            values = "24"
        if values == "1c":
            values = "25"
        if values == "1d":
            values = "26"
        if values == "1e":
            values = "27"
        if values == "1f":
            values = "28"
        if values == "2a":
            values = "29"
        if values == "2b":
            values = "30"
        if values == "2c":
            values = "31"
        if values == "2d":
            values = "32"
        if values == "2e":
            values = "33"
        if values == "2f":
            values = "34"
        if values == "3a":
            values = "35"
        if values == "3b":
            values = "36"
        if values == "3c":
            values = "37"
        if values == "3d":
            values = "38"
        if values == "3e":
            values = "39"
        if values == "3f":
            values = "40"
        if values == "4a":
            values = "41"
        if values == "4b":
            values = "42"
        if values == "7":
            values = "0"
        swagger = swagger+values
        if(x<xval-1):
            swagger=swagger+(",")
    swagger=swagger+"}"
    if(y<yval-1):
        swagger=swagger+(",")
    print(swagger)
    swagger = "\'{"
print("};")
os.remove("./sprite_bytes/" + filename + '.txt')
outImg.save("./sprite_converted/" + filename + ".png")
