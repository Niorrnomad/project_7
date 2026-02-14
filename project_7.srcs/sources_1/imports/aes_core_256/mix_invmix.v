`timescale 1ns/1ns 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:43 03/30/2011 
// Design Name: 
// Module Name:    Mix_invMix 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mix_invmix(reset,encDec,dataIn,loadMix,mixColumnOut );
	input reset,encDec,loadMix;
	input [127:0] dataIn;
	wire [127:0] mixColumnIn;
	wire [127:0] mixColumnIn_Rmix;
	output [127:0] mixColumnOut;

	assign mixColumnIn=dataIn;
	
 wordmixcolumn WordMixColumn_a  (.encDec(encDec), .dataIn(mixColumnIn[127:96]), .dataOut(mixColumnIn_Rmix[127:96])); 
 wordmixcolumn WordMixColumn_b  (.encDec(encDec), .dataIn(mixColumnIn[95:64]),.dataOut(mixColumnIn_Rmix[95:64])); 
 wordmixcolumn WordMixColumn_c  (.encDec(encDec), .dataIn(mixColumnIn[63:32]),.dataOut(mixColumnIn_Rmix[63:32])); 
 wordmixcolumn WordMixColumn_d  (.encDec(encDec), .dataIn(mixColumnIn[31:0]), .dataOut(mixColumnIn_Rmix[31:0])); 	
	
reg32 rmix0(.reset(reset), .load(loadMix), .dataIn(mixColumnIn_Rmix[31:0]), .dataOut(mixColumnOut[31:0])); 
reg32 rmix1(.reset(reset), .load(loadMix), .dataIn(mixColumnIn_Rmix[63:32]), .dataOut(mixColumnOut[63:32])); 
reg32 rmix2(.reset(reset), .load(loadMix), .dataIn(mixColumnIn_Rmix[95:64]), .dataOut(mixColumnOut[95:64])); 
reg32 rmix3(.reset(reset), .load(loadMix), .dataIn(mixColumnIn_Rmix[127:96]), .dataOut(mixColumnOut[127:96])); 

endmodule
