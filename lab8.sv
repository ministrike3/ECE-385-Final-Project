//Top Level
// Assign the inputs and outputs of various modules to each other
// and implement the overall module logic



module  lab8 		( input         CLOCK_50,
                  input[3:0]    KEY, //bit 0 is set up as Reset
							    output [6:0]  HEX0, HEX1,
							    input PS2_CLK, PS2_DAT,
                  output [7:0]  VGA_R,					//VGA Red
                                VGA_G,					//VGA Green
												        VGA_B,					//VGA Blue
// VGA controls
							    output        VGA_CLK,				//VGA Clock
							                  VGA_SYNC_N,			//VGA Sync signal
												        VGA_BLANK_N,		//VGA Blank signal
												        VGA_VS,					//VGA virtical sync signal
												        VGA_HS				  //VGA horizontal sync signal
											);

   logic Reset_h, vssig, Clk;
   logic [9:0] drawxsig, drawysig, ballxsig, ballysig;
	 logic [7:0] keycode;
 	 logic [0:39][0:39][0:5] coin_text1234;
	 logic [0:79][0:39][0:5] hero_text1234;
	 logic [0:39][0:39][0:5] enemy_text1234;
	 logic [0:39][0:39][0:5] wall_text1234;
	 logic [0:39][0:39][0:5] pow_text1234;
	 logic [0:39][0:39][0:5] pow_coin_text1234;
	 logic [0:39][0:39][0:5] grade_text1234;
	 logic [0:11][0:39][0:1] frameset1234;
	 logic [0:46][0:253][0:3] gameover_text1234;
	 logic [0:37][0:277][0:5] game_text1234;
	 logic [0:11][0:143][0:1] diff1_text1234;
	 logic [0:11][0:143][0:1] diff2_text1234;
	 logic [0:11][0:143][0:1] diff3_text1234;
	 logic [0:11][0:143][0:1] diff4_text1234;
	 logic [0:11][0:143][0:1] ending1_text1234;
	 logic [0:11][0:143][0:1] ending2_text1234;
	 logic [0:11][0:143][0:1] ending3_text1234;
	 logic [0:11][0:143][0:1] ending4_text1234;

	 logic [0:5] value1234;
	 logic downstop1234;
	 logic rightstop1234;
	 logic upstop1234;
	 logic leftstop1234;
	 logic startscreen1234;
	 logic ported1234;
	 //logic rightgameend;
	 logic power;
	 assign Clk = CLOCK_50;
    assign {Reset_h}=~ (KEY[0]);
	 assign VGA_VS=vssig;


    vga_controller vgasync_instance(.Clk(Clk),
												.Reset(Reset_h),
												.hs(VGA_HS),
												.vs(vssig),
												.pixel_clk(VGA_CLK),
												.blank(VGA_BLANK_N),
												.sync(VGA_SYNC_N),
												.DrawX(drawxsig),
												.DrawY(drawysig)) ;

					 ball ball_instance(	.Reset(Reset_h),
												.keycode(keycode),
												.frame_clk(vssig),
												.BallX(ballxsig),
												.BallY(ballysig),
												.press(press),
												.downstop(downstop1234),
												.rightstop(rightstop1234),
												.leftstop(leftstop1234),
												.upstop(upstop1234),
												.startscreen(startscreen1234),
												.ported(ported1234)
												);

		 frame_decider frame_instance(.clk(Clk),
												.enemy_text(enemy_text1234),
												.wall_text(wall_text1234),
												.coin_text(coin_text1234),
												.BallX(ballxsig),
												.BallY(ballysig),
												.DrawX(drawxsig),
												.DrawY(drawysig),
												.value(value1234),
												.downstop(downstop1234),
												.rightstop(rightstop1234),
												.leftstop(leftstop1234),
												.upstop(upstop1234),
												.press(press),
												.frameset(frameset1234),
												.gameover_text(gameover_text1234),
												.game_text(game_text1234),
												.grade_text(grade_text1234),
												.pow_text(pow_text1234),
												.pow_coin_text(pow_coin_text1234),
												.ending_text(ending_text1234),
												.startscreen(startscreen1234),
												.ported(ported1234),
												.diff1_text(diff1_text1234),
												.diff2_text(diff2_text1234),
												.diff3_text(diff3_text1234),
												.diff4_text(diff4_text1234),
												.ending1_text(ending1_text1234),
												.ending2_text(ending2_text1234),
												.ending3_text(ending3_text1234),
												.ending4_text(ending4_text1234)
												);

		 color_mapper color_instance(	.value(value1234),
												.Red(VGA_R),
												.Green(VGA_G),
												.Blue(VGA_B));

					 sprite_table image(	.clk(Clk),
												.coin_text(coin_text1234),
												.enemy_text(enemy_text1234),
												.wall_text(wall_text1234),
												.frameset(frameset1234),
												.gameover_text(gameover_text1234),
												.grade_text(grade_text1234),
												.pow_text(pow_text1234),
												.pow_coin_text(pow_coin_text1234),
												.game_text(game_text1234),
												.diff1_text(diff1_text1234),
												.diff2_text(diff2_text1234),
												.diff3_text(diff3_text1234),
												.diff4_text(diff4_text1234),
												.ending1_text(ending1_text1234),
												.ending2_text(ending2_text1234),
												.ending3_text(ending3_text1234),
												.ending4_text(ending4_text1234)
												);



	 keyboard keyboard(.Clk(Clk), .psClk(PS2_CLK), .psData(PS2_DAT), .reset(Reset_h),.keyCode(keycode),.press(press));
	 HexDriver hex_inst_0 (keycode[3:0], HEX0);
	 HexDriver hex_inst_1 (keycode[7:4], HEX1);

endmodule
