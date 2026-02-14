`timescale 1ns/1ns 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:48:08 04/01/2011 
// Design Name: 
// Module Name:    aes_transformation 
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
module aes_transformation(clk,reset,encDec,roundKey,dataIn,addRoundKeySelect,dataBufferSelect,
									loadData,mixColumnSelect,loadMix,shiftSubByteSelect,loadSbox,loadRKey,dataOut);

 input clk, reset, encDec,loadRKey, dataBufferSelect, 
              loadData, shiftSubByteSelect, loadSbox, mixColumnSelect, loadMix; 
 input [127:0] dataIn; 				//State array
 input [127:0] roundKey; 			//Cipher key
 input [1:0]  addRoundKeySelect; //select dataIn to addRoundKey
  
 output [127:0] dataOut;
 
 wire [127:0] dataBufferIn;
 wire [127:0] dataBufferOut;
 wire [127:0] addKeyOut;
 wire [127:0] sboxIn;
 wire [127:0] sboxOut;
 wire [127:0] mixColumnIn;
 wire [127:0] mixColumnOut;
  
  
  
  				//dataBuffer reg
			  assign dataBufferIn = dataBufferSelect ? dataIn : addKeyOut;  
			  databuffer_large databuffer(.clk(clk), .reset(reset), .load(loadData), .dataIn(dataBufferIn[127:0]), .dataOut(dataBufferOut[127:0]));
			  /*databuffer databuffer0    (.clk(clk), .reset(reset), .load(loadData), .dataIn(dataBufferIn[31:0]), .dataOut(dataBufferOut[31:0])); 
			  databuffer databuffer1    (.clk(clk), .reset(reset), .load(loadData), .dataIn(dataBufferIn[63:32]), .dataOut(dataBufferOut[63:32])); 
			  databuffer databuffer2    (.clk(clk), .reset(reset), .load(loadData), .dataIn(dataBufferIn[95:64]), .dataOut(dataBufferOut[95:64])); 
			  databuffer databuffer3    (.clk(clk), .reset(reset), .load(loadData), .dataIn(dataBufferIn[127:96]), .dataOut(dataBufferOut[127:96]));
			  */
			  
			
			 
			 	  
			  addroundkey addroundkey(.clk(clk),.reset(reset),.addRoundKeySelect(addRoundKeySelect),.dataBufferOut(dataBufferOut),.mixColumnOut(mixColumnOut),
														.sboxOut(sboxOut),.roundKey(roundKey),.loadRKey(loadRKey),.addKeyOut(addKeyOut));
									


			//ShiftSubByte_InvShiftSubByte
			 assign sboxIn = shiftSubByteSelect ? addKeyOut : mixColumnOut; 
			 shiftsub_invshiftsub shiftsub_invshiftsub(.reset(reset), .encDec(encDec), .loadSbox(loadSbox),
																		.dataIn(sboxIn), .sboxOut(sboxOut)); 
		 
		 
			//MixColumn_InvMixColumn
			 assign mixColumnIn = mixColumnSelect ? addKeyOut : sboxOut; 
			 mix_invmix mix_invmix (.reset(reset), .encDec(encDec), .loadMix(loadMix), .dataIn(mixColumnIn), .mixColumnOut(mixColumnOut)); 
			
			//data encrypt or data decrypt
			 assign dataOut = dataBufferOut; 
endmodule
