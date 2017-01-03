// For Frame Decider, I have included comments at the top, but also spread
// throughout the project so that this moduleWhich is pretty much 70-90%
//of our project makes some semblence of sense
// I wanted to clean it up, organize it, and split it up into its own well
// organized modules (like the hero-decider and scorecounter modules)
// but had a medical emergency days before the deadline


module  frame_decider ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
								input clk,
								input press,
								input logic [0:39][0:39][0:5] coin_text,
								input logic [0:39][0:39][0:5] enemy_text,
								input logic [0:39][0:39][0:5] wall_text,
								input logic [0:39][0:39][0:5] pow_text,
								input logic [0:39][0:39][0:5] pow_coin_text,
								input logic [0:39][0:39][0:5] grade_text,
								input logic [0:11][0:39][0:1] frameset,
								input logic [0:37][0:277][0:1] game_text,
								input logic [0:47][0:143][0:1] difficulty_text,
								input logic [0:51][0:145][0:1] ending_text,
								input logic [0:46][0:253][0:1] gameover_text,
								input logic [0:11][0:143][0:1] diff1_text,
								input logic [0:11][0:143][0:1] diff2_text,
								input logic [0:11][0:143][0:1] diff3_text,
								input logic [0:11][0:143][0:1] diff4_text,
								input logic [0:11][0:143][0:1] ending1_text,
								input logic [0:11][0:143][0:1] ending2_text,
								input logic [0:11][0:143][0:1] ending3_text,
								output logic [0:11][0:143][0:1] ending4_text,
								output [0:5] value,
								output downstop,rightstop,leftstop,upstop, startscreen, ported
							  );


		logic[9:0] hero_x;
		logic[9:0] hero_y;
		logic[9:0] hero_size_x = 10'd40;
		logic[9:0] hero_size_y = 10'd80;
		logic[9:0] portal_x = 100;
		logic[9:0] portal_y=400;
		logic[5:0] portal_exists;
		assign hero_x=BallX;
		assign hero_y=BallY;
		logic[9:0] DrawX1234;
		logic[9:0] DrawY1234;
		assign DrawX1234=DrawX;
		assign Drawy1234=DrawY;
// All of these next logic assignments do one of 2 things
// the ones that assign an x and y create a location on the screen for the top
// left corner of that object
// the ones that are called xxx_exists and don't assign a value
// are given a value later on in the module
// and they essentially say that "yes the xxx exists on this pixel"
// or no, the xxx does not exist on this pixel
		logic[9:0] coin1_x = 160;
		logic[9:0] coin1_y = 300;
		logic[5:0] coin1_exists;
		logic[9:0] coin2_x = 200;
		logic[9:0] coin2_y = 300;
		logic[5:0] coin2_exists;
		logic[9:0] coin3_x = 100;
		logic[9:0] coin3_y = 300;
		logic[5:0] coin3_exists;
		logic[9:0] coin4_x = 400;
		logic[9:0] coin4_y = 300;
		logic[5:0] coin4_exists;
		logic[9:0] coin7_x = 500;
		logic[9:0] coin7_y = 300;
		logic[5:0] coin7_exists;
		logic[9:0] coin6_x = 600;
		logic[9:0] coin6_y = 300;
		logic[5:0] coin6_exists;
		logic[9:0] coin8_x = 700;
		logic[9:0] coin8_y = 300;
		logic[5:0] coin8_exists;
		logic[9:0] coin9_x = 800;
		logic[9:0] coin9_y = 300;
		logic[5:0] coin9_exists;
		logic [0:39][0:39][0:5] coin_text1234;
		logic[9:0] gameover_x = 150;
		logic[9:0] gameover_y = 10;
		logic[9:0] game_x = 150;
		logic[9:0] game_y = 10;
		logic[9:0] diff1_x = 160;
		logic[9:0] diff1_y = 60;
		logic[9:0] diff2_x = 160;
		logic[9:0] diff2_y = 75;
		logic[9:0] diff3_x = 160;
		logic[9:0] diff3_y = 90;
		logic[9:0] diff4_x = 160;
		logic[9:0] diff4_y = 105;
		logic[9:0] ending1_x = 160;
		logic[9:0] ending1_y = 60;
		logic[9:0] ending2_x = 160;
		logic[9:0] ending2_y = 75;
		logic[9:0] ending3_x = 160;
		logic[9:0] ending3_y = 90;
		logic[9:0] ending4_x = 160;
		logic[9:0] ending4_y = 105;

		// although i call it coin size, all block on the screen are of a 40x40 size
		logic[9:0] coin_size_x = 10'd40;
		logic[9:0] coin_size_y = 10'd40;
		logic[5:0] hero_exists;
		logic[9:0] grade_x = 980;
		logic[9:0] grade_y = 280;
		logic[5:0] grade_exists;
		//These signals turn to one when the player hits the coin
		logic collision1=0;
		logic collision2=0;
		logic collision3=0;
		logic collision4=0;
		logic collision6=0;
		logic collision7=0;
		logic collision8=0;
		logic collision9=0;
		logic collision10=0;
		//This is for the red coin, the one that changes the color of the player
		// when the player hits the red coin, both hitpower and power become one
		// and this singal is sent to hero decider
		logic [9:0] powerup_x = 240;
		logic[9:0] powerup_y = 300;
		logic hitpower = 0;
		logic power = 0;
		logic[5:0] powerup_exists;
		//These are triggered when the player hits the coins, giving them extra
		//points
		logic scoreincrement1=0;
		logic scoreincrement2=0;
		logic scoreincrement3=0;
		logic scoreincrement4=0;
		logic scoreincrement5=0;
		logic scoreincrement6=0;
		logic scoreincrement7=0;
		logic scoreincrement8=0;
		logic scoreincrement9=0;
		logic scoreincrement10=0;

		logic [12:0] xblock;
		logic [12:0] yblock;
		logic [12:0] block;
		logic [12:0] whereinblockx;
		logic [12:0] whereinblocky;
		logic [12:0] initialx=0;
		logic [12:0] ballxold;
		logic begin1234=1;
		logic over=0;
		logic rightgameend=0;
		logic [0:39][0:39][0:5] score1_text;
		logic[9:0] score1_x = 560;
		logic[9:0] score1_y = 0;
		logic[5:0] score1_exists;
		logic [0:39][0:39][0:5] score2_text;
		logic [0:79][0:39][0:5] hero_text;
		logic[9:0] score2_x = 600;
		logic[9:0] score2_y = 0;
		logic[5:0] score2_exists;

 hero_sprite_decider hero(.clk(clk),.hero_text(hero_text),.power(power));
//This Checks if its the beginning Screen or Not
always_ff@(posedge clk)
begin
	if ((begin1234==1)&&(press==0))
	begin
	begin1234=1;
	end

	else
	begin1234=0;

end

// FIGURE OUT BLOCKs or the left or right scrolling amount
always_ff@(posedge clk)
begin
initialx=initialx+(BallX-ballxold);
ballxold=BallX;
end

// FIGURE OUT BLOCKs or what walls  or where walls need to print
always_comb
begin:blockfinder
xblock=int'(((DrawX+initialx)/40));
yblock=int'((DrawY/40));
block=frameset[yblock][xblock];
end
// This plots out the exact pixel that should be printed from the wall sprite
always_comb
begin:printfigurer
whereinblockx=(DrawX+initialx)-40*xblock;
whereinblocky=DrawY-40*yblock;
end

//Where/what hero part am i printing
always_comb
    begin:hero_on_proc

        if((((DrawX+initialx) >= hero_x) && ((DrawX+initialx) <= hero_x +hero_size_x)
    && (DrawY >= hero_y) &&(DrawY <= hero_y +hero_size_y))&&(hero_text[DrawY-hero_y][(DrawX+initialx)-hero_x]!=0))
				begin
				hero_exists = hero_text[DrawY-hero_y][(DrawX+initialx)-hero_x];
				end
		else
		begin
				hero_exists = 6'b111111;
				end
	end

// THIS NEXT STUFF IS THE First Coin
	always_comb
    begin:coin1_on_proc

        if(((DrawX+initialx >= coin1_x) && (DrawX+initialx <= coin1_x +coin_size_x)
    && (DrawY >= coin1_y) &&(DrawY <= coin1_y +coin_size_y))&&(coin_text[DrawY-coin1_y][DrawX+initialx-coin1_x]!=0))
				coin1_exists = coin_text[DrawY-coin1_y][DrawX+initialx-coin1_x];
		else
				coin1_exists = 6'b111111;
	end
//Coin Collision Checker
always_ff@(posedge clk)
begin
	if ((coin1_exists != 6'b111111)&&(hero_exists != 6'b111111)&&(collision1==0)&&(hero_exists != 6'b000000)&&(coin1_exists != 6'b000000))
	begin
	collision1<=1;
	scoreincrement1=1;
	end

	else
	begin
	collision1<=collision1;
	scoreincrement1=scoreincrement1;
	end
end

// THIS NEXT STUFF IS THE 2nd Coin
	always_comb
    begin:coin2_on_proc

        if(((DrawX+initialx >= coin2_x) && (DrawX+initialx <= coin2_x +coin_size_x)
    && (DrawY >= coin2_y) &&(DrawY <= coin2_y +coin_size_y))&&(coin_text[DrawY-coin2_y][DrawX+initialx-coin2_x]!=0))
				coin2_exists = coin_text[DrawY-coin2_y][DrawX+initialx-coin2_x];
		else
				coin2_exists = 6'b111111;
	end
//Coin Collision Checker
always_ff@(posedge clk)
begin
	if ((coin2_exists != 6'b111111)&&(hero_exists != 6'b111111)&&(collision2==0)&&(hero_exists != 6'b000000)&&(coin2_exists != 6'b000000))
	begin
	collision2<=1;
	scoreincrement2=1;
	end

	else
	begin
	collision2<=collision2;
	scoreincrement2=scoreincrement2;
	end
end

// THIS NEXT STUFF IS THE 3rd Coin
	always_comb
    begin:coin3_on_proc

        if(((DrawX+initialx >= coin3_x) && (DrawX+initialx <= coin3_x +coin_size_x)
    && (DrawY >= coin3_y) &&(DrawY <= coin3_y +coin_size_y))&&(coin_text[DrawY-coin3_y][DrawX+initialx-coin3_x]!=0))
				coin3_exists = coin_text[DrawY-coin3_y][DrawX+initialx-coin3_x];
		else
				coin3_exists = 6'b111111;
	end
//Coin Collision Checker
always_ff@(posedge clk)
begin
	if ((coin3_exists != 6'b111111)&&(hero_exists != 6'b111111)&&(collision3==0)&&(hero_exists != 6'b000000)&&(coin3_exists != 6'b000000))
	begin
	collision3<=1;
	scoreincrement3=1;
	end

	else
	begin
	collision3<=collision3;
	scoreincrement3=scoreincrement3;
	end
end

// THIS NEXT STUFF IS THE 4th Coin
	always_comb
    begin:coin4_on_proc

        if(((DrawX+initialx >= coin4_x) && (DrawX+initialx <= coin4_x +coin_size_x)
    && (DrawY >= coin4_y) &&(DrawY <= coin4_y +coin_size_y))&&(coin_text[DrawY-coin4_y][DrawX+initialx-coin4_x]!=0))
				coin4_exists = coin_text[DrawY-coin4_y][DrawX+initialx-coin4_x];
		else
				coin4_exists = 6'b111111;
	end
//Coin Collision Checker
always_ff@(posedge clk)
begin
	if ((coin4_exists != 6'b111111)&&(hero_exists != 6'b111111)&&(collision4==0)&&(hero_exists != 6'b000000)&&(coin4_exists != 6'b000000))
	begin
	collision4<=1;
	scoreincrement4=1;
	end

	else
	begin
	collision4<=collision4;
	scoreincrement4=scoreincrement4;
	end
end


// THIS NEXT STUFF IS THE 6th Coin
	always_comb
    begin:coin6_on_proc

        if(((DrawX+initialx >= coin6_x) && (DrawX+initialx <= coin6_x +coin_size_x)
    && (DrawY >= coin6_y) &&(DrawY <= coin6_y +coin_size_y))&&(coin_text[DrawY-coin6_y][DrawX+initialx-coin6_x]!=0))
				coin6_exists = coin_text[DrawY-coin6_y][DrawX+initialx-coin6_x];
		else
				coin6_exists = 6'b111111;
	end
//Coin Collision Checker
always_ff@(posedge clk)
begin
	if ((coin6_exists != 6'b111111)&&(hero_exists != 6'b111111)&&(collision6==0)&&(hero_exists != 6'b000000)&&(coin6_exists != 6'b000000))
	begin
	collision6<=1;
	scoreincrement6=1;
	end

	else
	begin
	collision6<=collision6;
	scoreincrement6=scoreincrement6;
	end
end

// THIS NEXT STUFF IS THE 7th Coin
	always_comb
    begin:coin7_on_proc

        if(((DrawX+initialx >= coin7_x) && (DrawX+initialx <= coin7_x +coin_size_x)
    && (DrawY >= coin7_y) &&(DrawY <= coin7_y +coin_size_y))&&(coin_text[DrawY-coin7_y][DrawX+initialx-coin7_x]!=0))
				coin7_exists = coin_text[DrawY-coin7_y][DrawX+initialx-coin7_x];
		else
				coin7_exists = 6'b111111;
	end
//Coin Collision Checker
always_ff@(posedge clk)
begin
	if ((coin7_exists != 6'b111111)&&(hero_exists != 6'b111111)&&(collision7==0)&&(hero_exists != 6'b000000)&&(coin7_exists != 6'b000000))
	begin
	collision7<=1;
	scoreincrement7=1;
	end

	else
	begin
	collision7<=collision7;
	scoreincrement7=scoreincrement7;
	end
end

// THIS NEXT STUFF IS THE 8th Coin
	always_comb
    begin:coin8_on_proc

        if(((DrawX+initialx >= coin8_x) && (DrawX+initialx <= coin8_x +coin_size_x)
    && (DrawY >= coin8_y) &&(DrawY <= coin8_y +coin_size_y))&&(coin_text[DrawY-coin8_y][DrawX+initialx-coin8_x]!=0))
				coin8_exists = coin_text[DrawY-coin8_y][DrawX+initialx-coin8_x];
		else
				coin8_exists = 6'b111111;
	end
//Coin Collision Checker
always_ff@(posedge clk)
begin
	if ((coin8_exists != 6'b111111)&&(hero_exists != 6'b111111)&&(collision8==0)&&(hero_exists != 6'b000000)&&(coin8_exists != 6'b000000))
	begin
	collision8<=1;
	scoreincrement8=1;
	end

	else
	begin
	collision8<=collision8;
	scoreincrement8=scoreincrement8;
	end
end

// THIS NEXT STUFF IS THE 9th Coin
	always_comb
    begin:coin9_on_proc

        if(((DrawX+initialx >= coin9_x) && (DrawX+initialx <= coin9_x +coin_size_x)
    && (DrawY >= coin9_y) &&(DrawY <= coin9_y +coin_size_y))&&(coin_text[DrawY-coin9_y][DrawX+initialx-coin9_x]!=0))
				coin9_exists = coin_text[DrawY-coin9_y][DrawX+initialx-coin9_x];
		else
				coin9_exists = 6'b111111;
	end
//Coin Collision Checker
always_ff@(posedge clk)
begin
	if ((coin9_exists != 6'b111111)&&(hero_exists != 6'b111111)&&(collision9==0)&&(hero_exists != 6'b000000)&&(coin9_exists != 6'b000000))
	begin
	collision9<=1;
	scoreincrement9=1;
	end

	else
	begin
	collision9<=collision9;
	scoreincrement9=scoreincrement9;
	end
end


scorecounter scorecounter(.scoreincrement1(scoreincrement1),.scoreincrement2(scoreincrement2),.scoreincrement3(scoreincrement3),.scoreincrement4(scoreincrement4),.scoreincrement5(scoreincrement5),.scoreincrement6(scoreincrement6),.scoreincrement7(scoreincrement7),.scoreincrement8(scoreincrement8),.scoreincrement9(scoreincrement9),.score1_text(score1_text),.score2_text(score2_text),.clk(clk));

// Draw The first score counter digit
	always_comb
    begin:score1_on_proc

        if(((DrawX >= score1_x) && (DrawX <= score1_x +coin_size_x)
    && (DrawY >= score1_y) &&(DrawY <= score1_y +coin_size_y))&&(score1_text[DrawY-score1_y][DrawX-score1_x]!=0))
				score1_exists = score1_text[DrawY-score1_y][DrawX-score1_x];
		else
				score1_exists = 6'b111111;
	end
		always_comb
// Draw the second score counter digit
    begin:score2_on_proc

        if(((DrawX >= score2_x) && (DrawX <= score2_x +coin_size_x)
    && (DrawY >= score2_y) &&(DrawY <= score2_y +coin_size_y))&&(score2_text[DrawY-score2_y][DrawX-score2_x]!=0))
				score2_exists = score2_text[DrawY-score2_y][DrawX-score2_x];
		else
				score2_exists = 6'b111111;
	end

// THIS NEXT STUFF IS THE Powerup
	always_comb
    begin:power_on_proc

        if(((DrawX+initialx >= powerup_x) && (DrawX+initialx <= powerup_x +coin_size_x)
    && (DrawY >= powerup_y) &&(DrawY <= powerup_y +coin_size_y))&&(pow_coin_text[DrawY-powerup_y][DrawX+initialx-powerup_x]!=0))
				powerup_exists = pow_coin_text[DrawY-powerup_y][DrawX+initialx-powerup_x];
		else
				powerup_exists = 6'b111111;
	end
//Powerup Collision Checker
always_ff@(posedge clk)
begin
	if ((powerup_exists != 6'b111111)&&(hero_exists != 6'b111111)&&(hitpower==0)&&(hero_exists != 6'b000000)&&(powerup_exists != 6'b000000))
	begin
	hitpower<=1;
	power=1;
	scoreincrement5=1;
	end

	else
	begin
	hitpower<=hitpower;
	power=power;
	scoreincrement5=scoreincrement5;
	end
end

// THIS NEXT STUFF IS THE Final Hit
	always_comb
    begin:grade_on_proc

        if(((DrawX+initialx >= grade_x) && (DrawX+initialx <= grade_x +coin_size_x)
    && (DrawY >= grade_y) &&(DrawY <= grade_y +coin_size_y))&&(grade_text[DrawY-grade_y][DrawX+initialx-grade_x]!=0)&&(grade_x-initialx<=640))
				grade_exists = grade_text[DrawY-grade_y][DrawX+initialx-grade_x];
		else
				grade_exists = 6'b111111;
	end
//Coin Collision Checker
always_ff@(posedge clk)
begin
	if ((grade_exists != 6'b111111)&&(hero_exists != 6'b111111)&&(rightgameend==0)&&(hero_exists != 6'b000000)&&(grade_exists != 6'b000000))
	begin
	rightgameend=1;
	end

	else
	begin
	rightgameend=rightgameend;
	end
end

// These things limit the movement of the character given other conditions like a wall or the game ending


always_ff@(posedge clk)
begin
if ((begin1234!=1))
begin
downstop= (frameset[(int'((hero_y)/40))+2][(int'((hero_x)/40))])||(frameset[(int'((hero_y)/40))+2][(int'((hero_x)/40))+1]);


leftstop=(frameset[(int'((hero_y)/40))+1][(int'((hero_x+1)/40))]);


rightstop=(frameset[(int'((hero_y)/40))+1][(int'((hero_x)/40))+1]);

end
end


// This decides value, which is sent to color mapper and becomes a color
always_comb
begin:valuedecider
if ((begin1234==1)&& (DrawX>= game_x) && (DrawX <= game_x + 278)
    && (DrawY >= game_y) &&(DrawY <= game_y +38)&&(game_text[DrawY-game_y][DrawX-game_x]!=0))
value=game_text[DrawY-game_y][DrawX-game_x];

else if ((begin1234==1)&& (DrawX>= diff1_x) && (DrawX <= diff1_x + 144)
    && (DrawY >= diff1_y) &&(DrawY <= diff1_y+12)&&(diff1_text[DrawY-diff1_x][DrawX-(diff1_x)]!=0))
value=diff1_text[DrawY-diff1_y][DrawX-(diff1_x)];

else if ((begin1234==1)&& (DrawX>= diff2_x) && (DrawX <= diff2_x + 144)
    && (DrawY >= diff2_y) &&(DrawY <= diff2_y+12)&&(diff2_text[DrawY-diff2_x][DrawX-(diff2_x)]!=0))
value=diff2_text[DrawY-diff2_y][DrawX-(diff2_x)];

else if ((begin1234==1)&& (DrawX>= diff3_x) && (DrawX <= diff3_x + 144)
    && (DrawY >= diff3_y) &&(DrawY <= diff3_y+12)&&(diff1_text[DrawY-diff3_x][DrawX-(diff3_x)]!=0))
value=diff3_text[DrawY-diff3_y][DrawX-(diff3_x)];

else if ((begin1234==1)&& (DrawX>= diff4_x) && (DrawX <= diff4_x + 144)
    && (DrawY >= diff4_y) &&(DrawY <= diff4_y+12)&&(diff4_text[DrawY-diff4_x][DrawX-(diff4_x)]!=0))
value=diff4_text[DrawY-diff4_y][DrawX-(diff4_x)];


else if (begin1234==1)
value=6'b001000;

else if ((rightgameend==1)&& (DrawX>= gameover_x) && (DrawX <= gameover_x + 254)
    && (DrawY >= gameover_y) &&(DrawY <= gameover_y +47)&&(gameover_text[DrawY-gameover_y][DrawX-gameover_x]!=0))
value=gameover_text[DrawY-gameover_y][DrawX-gameover_x];

else if ((rightgameend==1)&& (DrawX>= diff1_x) && (DrawX <= diff1_x + 144)
    && (DrawY >= diff1_y) &&(DrawY <= diff1_y+12)&&(ending1_text[DrawY-ending1_x][DrawX-(ending1_x)]!=0))
value=ending1_text[DrawY-diff1_y][DrawX-(diff1_x)];

else if ((rightgameend==1)&& (DrawX>= diff2_x) && (DrawX <= diff2_x + 144)
    && (DrawY >= diff2_y) &&(DrawY <= diff2_y+12)&&(ending2_text[DrawY-ending2_x][DrawX-(ending2_x)]!=0))
value=ending2_text[DrawY-diff2_y][DrawX-(diff2_x)];

else if ((rightgameend==1)&& (DrawX>= diff3_x) && (DrawX <= diff3_x + 144)
    && (DrawY >= diff3_y) &&(DrawY <= diff3_y+12)&&(ending3_text[DrawY-ending3_x][DrawX-(ending3_x)]!=0))
value=ending3_text[DrawY-diff3_y][DrawX-(diff3_x)];
else if ((rightgameend==1)&& (DrawX>= diff4_x) && (DrawX <= diff4_x + 144)
    && (DrawY >= diff4_y) &&(DrawY <= diff4_y+12)&&(ending4_text[DrawY-ending4_x][DrawX-(ending4_x)]!=0))
value=ending4_text[DrawY-diff4_y][DrawX-(diff4_x)];

else if (rightgameend==1)
value=6'b001000;

else if ( (score1_exists !=6'b111111)&& ((score1_exists !=6'b000000)))
begin
		value = score1_exists;
end
else if ( (score2_exists !=6'b111111)&& ((score2_exists !=6'b000000)))
begin
		value = score2_exists;
end

else if((block==1))
begin
value=wall_text[whereinblocky][whereinblockx];
end

else if ( (hero_exists !=6'b111111)&& ((hero_exists !=6'b000000)))
begin
		value = hero_exists;
end

else if ( (powerup_exists !=6'b111111)&& (powerup_exists !=6'b000000)&&(hitpower!=1))
begin
		value = powerup_exists;
end

else if ( (coin1_exists !=6'b111111)&& ((coin1_exists !=6'b000000))&&(collision1!=1))
begin
		value = coin1_exists;
end

else if ( (coin2_exists !=6'b111111)&& ((coin2_exists !=6'b000000))&&(collision2!=1))
begin
		value = coin2_exists;
end
else if ( (coin3_exists !=6'b111111)&& ((coin3_exists !=6'b000000))&&(collision3!=1))
begin
		value = coin3_exists;
end
else if ( (coin4_exists !=6'b111111)&& ((coin4_exists !=6'b000000))&&(collision4!=1))
begin
		value = coin4_exists;
end
else if ( (coin6_exists !=6'b111111)&& ((coin6_exists !=6'b000000))&&(collision6!=1))
begin
		value = coin6_exists;
end
else if ( (coin7_exists !=6'b111111)&& ((coin7_exists !=6'b000000))&&(collision7!=1))
begin
		value = coin7_exists;
end
else if ( (coin8_exists !=6'b111111)&& ((coin8_exists !=6'b000000))&&(collision8!=1))
begin
		value = coin8_exists;
end

else if ( (coin9_exists !=6'b111111)&& ((coin9_exists !=6'b000000))&&(collision9!=1))
begin
		value = coin9_exists;
end

else if ( (grade_exists !=6'b111111)&& ((grade_exists !=6'b000000)))
begin
		value = grade_exists;
end

else
begin
value=6'b000000;
end
end

endmodule
