`timescale 1ns/1ns 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:01:59 03/30/2011 
// Design Name: 
// Module Name:    WordMixColumn 
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
module wordmixcolumn(encDec,dataIn,dataOut);
    input encDec;
	 input [31:0] dataIn;
	 output [31:0] dataOut;
	 
	 bytemixcolumn ByteMixColumn_a(.encDec(encDec),.dataIn_a(dataIn[31:24]),.dataIn_b(dataIn[23:16]),
												.dataIn_c(dataIn[15:8]),.dataIn_d(dataIn[7:0]),.dataOut(dataOut[31:24]));
												
	 bytemixcolumn ByteMixColumn_b(.encDec(encDec),.dataIn_a(dataIn[23:16]),.dataIn_b(dataIn[15:8]),
												.dataIn_c(dataIn[7:0]),.dataIn_d(dataIn[31:24]),.dataOut(dataOut[23:16]));
												
	 bytemixcolumn ByteMixColumn_c(.encDec(encDec),.dataIn_a(dataIn[15:8]),.dataIn_b(dataIn[7:0]),
												.dataIn_c(dataIn[31:24]),.dataIn_d(dataIn[23:16]),.dataOut(dataOut[15:8]));
												
	 bytemixcolumn ByteMixColumn_d(.encDec(encDec),.dataIn_a(dataIn[7:0]),.dataIn_b(dataIn[31:24]),
												.dataIn_c(dataIn[23:16]),.dataIn_d(dataIn[15:8]),.dataOut(dataOut[7:0]));							

endmodule
