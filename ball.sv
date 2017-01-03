// Module Ball controls the way the hero moves (ballX and BallY)
// Are assigned to heroX and HeroY in Framedecider.
//Based on various signals coming into the file (the stops) from FrameDecider
// and the keycode and press signals from the PS2 keyboard
// this determines the next clock cycles Hero Position
// And whether it moves, or stays in the same place.
// The ported signal is not used; I was trying to implement a portal
// but I got emergency surgery 3 days before the project was due and ran out of time
module  ball ( input Reset,
               input frame_clk,
		           input [15:0] keycode,
					     input press,downstop,rightstop,upstop,leftstop, startscreen,ported,
               output [9:0]  BallX, BallY
				 );
    // keycodes CAUTION THIS IS FOR PS2 USB IS DIFFERENT
    // up is keycode == 8'h75
    // left is keycode == 8'h6b
    // right is keycode == 8'h74
    // down is keycode == 8'h72

    logic [9:0] Ball_X_Pos, Ball_Y_Pos;
    logic [9:0] counter=0;
    logic [9:0] vertical_motion=-1;
    logic [9:0] horizontal_motion;

    parameter [9:0] Ball_Top_Left_X=80;
    parameter [9:0] Ball_Top_Left_Y=200;
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=439;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    always_ff @ (posedge frame_clk )
begin: Move_Upward
				 if(upstop!=1 && keycode == 8'h75 && press == 1'b1&& Ball_Y_Pos != 0 && downstop==1)	//Up
					begin
						Ball_Y_Pos <= Ball_Y_Pos - 80;
					end
				else if (ported==1)
					begin
					Ball_Y_Pos <= Ball_Top_Left_Y-180;
					Ball_X_Pos <= Ball_Top_Left_X+500;
					end
				else if(leftstop!=1 &&downstop!=1 &&  keycode == 8'h6b && press == 1'b1 )//Left
					begin
						Ball_X_Pos <=Ball_X_Pos - 1'b1;
						Ball_Y_Pos <= Ball_Y_Pos + 2;
					end
				else if(leftstop!=1 &&  keycode == 8'h6b && press == 1'b1)//Left
					begin
						Ball_X_Pos <=Ball_X_Pos - 1'b1;
						Ball_Y_Pos <= Ball_Y_Pos;
					end

				 else if (rightstop!=1 &&downstop!=1 &&  keycode == 8'h74 && press == 1'b1)	//Right
					begin
						Ball_X_Pos <=Ball_X_Pos + 1'b1;
						Ball_Y_Pos <= Ball_Y_Pos + 2;

					end
					else if (rightstop!=1 &&  keycode == 8'h74 && press == 1'b1)	//Right
					begin
						Ball_X_Pos <=Ball_X_Pos + 1'b1;
						Ball_Y_Pos <= Ball_Y_Pos;
					end
				 else if (downstop!=1 && keycode == 8'h72 && press == 1'b1 && Ball_Y_Pos != 400 )	//Down
					begin
						Ball_Y_Pos <= Ball_Y_Pos + 2;
					end
				else if (downstop!=1)
				begin
				Ball_Y_Pos <= Ball_Y_Pos + 2;
				Ball_X_Pos <= Ball_X_Pos;
				end
				else
				begin
				Ball_Y_Pos <= Ball_Y_Pos;
				Ball_X_Pos <= Ball_X_Pos;
				end

end
    assign BallX = Ball_X_Pos;
    assign BallY = Ball_Y_Pos+vertical_motion;

endmodule
