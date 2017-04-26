import os
name = input('Enter the name of the file to be opened (i.e coin.txt, enemy.txt): ')
rawtxt =  open( name, "r")
text= rawtxt.read()
text=text.splitlines()
name = input('Enter the name of the sprite (i.e coin, enemy): ')
name = name + "_text"
xval = int(input('Enter the x dimesion: '))
yval= int(input('Enter the y dimesion: '))
os.system('cls' if os.name == 'nt' else 'clear')
swagger = "\'{"
print(name + " <=")
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
        if values != "0":
            values = "1"
        swagger = swagger+values
        if(x<xval-1):
            swagger=swagger+(",")
    swagger=swagger+"}"
    if(y<yval-1):
        swagger=swagger+(",")
    print(swagger)
    swagger = "\'{"
print("};")
