# ECE-385-Final-Project
## System Verilog code to create a simplistic side scrolling, coin collecting mario-styled game for ECE 385 at UIUC

The point of the game is to help Neil collect ECE385 mastery (There were 9 labs, therefore, 9 coins) and ECE 385 final project difficulty points (10 points possible). One of the coins, the 4th one, is red, as it symbolizes the change from TTL logic to System verilog and is a "powerup" in Neil's 385 ability. At the end, he hits the A+ because thats what Neil wants on the Final project but doesn't receive, so he has to hope for help from the Curve gods!

The game is displayed over VGA; all of the games physics and graphics are determined in hardware. 

I worked on this game with my partner Siddhant Jain (github: Siddhant-Jain); we have included both our initial proposal and final lab report; for an understanding of how the game (its physics, graphics, etc,) work, the final lab report provides comprehensive diagrams and explanations. 

I would like to thank Rishi Thakker for providing several scripts that converted images into some sort of arrays; those scripts are linked : https://github.com/Atrifex/ECE385-HelperTools. We wrote some additional python scripts to convert the output of these scripts into the arrays, format, and encoding that we needed.   

## Heres what the files do:
**keyboard.sv:** read inputs from ps/2 keyboard 

**ball.sv:** control movement of player based on key inputs

**sprite.sv:**
stores the images for most of the enviornment

**hero_sprite_decider.sv:**
takes input from Framedecider and decides whether the player is powered up or not

**Framedecider.sv:**
makes all of the games decisions + graphics; outputs "value" which is the color of the pixel

**scorecounter.sv:**
takes increments from Framedecider and sends back the current score

**color_mapper.sv:**
takes in value and converts into RGB value's for VGA

**VGA_controller.sv:**
takes output of color_mapper and displays onscreen
