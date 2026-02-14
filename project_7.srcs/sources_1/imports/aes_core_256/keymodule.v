`timescale 1ns/1ns 
module keymodule (clk, reset, firstRound, loadkey, w_prev, Key, roundKey);
		 input clk, reset, firstRound, loadkey; 
		 input [31:0] w_prev, Key; 
		 output [31:0] roundKey; 
		 wire [31:0] w_i;
		 wire [31:0] tmp_roundKey;
		 assign w_i = firstRound ? Key : tmp_roundKey ^ w_prev; 
		 reg_32 keyBUF (.clk(clk), .reset(reset),.load(loadkey), .dataIn(w_i), .dataOut(tmp_roundKey)); 
		 assign roundKey=tmp_roundKey;
endmodule
