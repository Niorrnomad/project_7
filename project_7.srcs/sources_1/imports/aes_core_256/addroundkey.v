`timescale 1ns/1ns 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:50:02 03/29/2011 
// Design Name: 
// Module Name:    AddRoundkey 
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
module addroundkey(clk,reset,addRoundKeySelect, dataBufferOut, mixColumnOut, sboxOut,roundKey,loadRKey,addKeyOut
    );
	input clk,reset,loadRKey;
	input [1:0] addRoundKeySelect;
	input [127:0] dataBufferOut;
	input [127:0] mixColumnOut;
	input [127:0] sboxOut;
	//input [127:0] dataIn;
	input [127:0] roundKey;
	//reg [127:0] 	addKeyIn_tmp;
	wire  [127:0] addKeyIn;
	reg [127:0] addKey;
	output  [127:0] addKeyOut;
	 
	always@(posedge clk)
	begin
	case (addRoundKeySelect)     
			  2'b00 : addKey = dataBufferOut;     
			  2'b01 : addKey = mixColumnOut;   
			  2'b10 : addKey = sboxOut;      
				default : addKey = 128'hx;     
		endcase  
	end
	 assign	addKeyIn = addKey^roundKey; 
	 //assign addKeyIn=addKeyIn_tmp;
		reg32 rkey0(.reset(reset), .load(loadRKey), .dataIn(addKeyIn[31:0]), .dataOut(addKeyOut[31:0])); 
		reg32 rkey1(.reset(reset), .load(loadRKey), .dataIn(addKeyIn[63:32]), .dataOut(addKeyOut[63:32])); 
		reg32 rkey2(.reset(reset), .load(loadRKey), .dataIn(addKeyIn[95:64]), .dataOut(addKeyOut[95:64])); 
		reg32 rkey3(.reset(reset), .load(loadRKey), .dataIn(addKeyIn[127:96]), .dataOut(addKeyOut[127:96])); 
endmodule
