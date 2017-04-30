palette_hex = ['0xFF00FF', '0x000000', '0x101010', '0xF8F8F8', '0xA7A7A7', '0xFFD2B8', '0xFFD3BA', '0xFFFFFF',
'0xFFA23C', '0xFFDE78', '0xF00000', '0xFF0000', '0x9A9A9A','0x431313', '0xF44418', '0x5C3C25' ,
'0xFF7233', '0xFA9A6C', '0xFFD3BA', '0x736037', '0xB3C2D4', '0x003C86',
'0x0056D0', '0x1E1E50', '0x6F5144', '0xCA673C', '0xEF6225', '0xFC6220', '0xB3C2D4',
'0xB3C2D4', '0x0056D0', '0x1E1E50','0x5C3C25', '0x7E6037', '0xFF7233', '0x63D413', '0x003E83', '0x76603C',
'0xC3794E', '0xAD6338', '0xB0663B', '0xB46A3F', '0x442D1A', '0x503926', '0xA3290D', '0x381616', '0x391919', '0xB86E43',
'0xB96F44', '0xFFF30F', '0xFF7B0F', '0x00F000', '0xFF0F0F', '0xA3290D', '0xCF9F87', '0xCFA087']
length = len(palette_hex)
reddit=palette_hex[1]
reddit=reddit[2:]
reddit=reddit.lower()
digits=bin(1)
digits=digits[2:]
while len(digits) < 6:
    digits= "0"+ digits;
print("if ((value==6\'b"+digits+ "))")
print("begin")
print("Red=8\'h"+reddit[0:2]+";")
print("Green=8\'h"+reddit[2:4]+";")
print("Blue=8\'h"+reddit[4:]+";")
print("end")
for color in range(2,length):
    reddit=palette_hex[color]
    reddit=reddit[2:]
    reddit=reddit.lower()
    digits=bin(color)
    digits=digits[2:]
    while len(digits) < 6:
        digits= "0"+ digits;
    print("else if ((value==6\'b"+digits+ "))")
    print("begin")
    print("Red=8\'h"+reddit[0:2]+";")
    print("Green=8\'h"+reddit[2:4]+";")
    print("Blue=8\'h"+reddit[4:]+";")
    print("end")
print("else")
print("begin")
print("Red=8\'hff ;")
print("Green=8\'hff;")
print("Blue=8\'hff;")
print("end")
print("end")
print("endmodule")
