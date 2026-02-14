`timescale 1ns/1ns 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:44:00 03/29/2011 
// Design Name: 
// Module Name:    ShiftSubByte 
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
 
module shiftsub_invshiftsub(reset, encDec, loadSbox, dataIn, sboxOut); 
 
    input reset; 
    input encDec; 
    input loadSbox; 
    input [127:0] dataIn; 
    output [127:0] sboxOut; 
	 wire [127:0] in_Sbox;
	 wire [127:0] out_Sbox;
	 wire [127:0] shiftRows;
  		
				assign		shiftRows = encDec ?  { dataIn[95:0], dataIn[127:96] } : { dataIn[31:0], dataIn[127:32] }; 
				assign	  in_Sbox[7:0] = shiftRows[7:0]; 
				assign	  in_Sbox[15:8] = encDec ? shiftRows[111:104] : shiftRows[47:40]; 
				assign    in_Sbox[23:16] = shiftRows[87:80]; 
				assign    in_Sbox[31:24] = encDec ? shiftRows[63:56] : shiftRows[127:120]; 
				assign    in_Sbox[39:32] = shiftRows[39:32]; 
				assign	  in_Sbox[47:40] = encDec ? shiftRows[15:8] : shiftRows[79:72]; 
				assign	  in_Sbox[55:48] = shiftRows[119:112]; 
				assign	  in_Sbox[63:56] = encDec ? shiftRows[95:88] : shiftRows[31:24]; 
				assign	  in_Sbox[71:64] = shiftRows[71:64]; 
				assign	  in_Sbox[79:72] = encDec ? shiftRows[47:40] : shiftRows[111:104]; 
				assign	  in_Sbox[87:80] = shiftRows[23:16]; 
				assign	  in_Sbox[95:88] = encDec ? shiftRows[127:120] : shiftRows[63:56]; 
				assign	  in_Sbox[103:96] = shiftRows[103:96]; 
				assign	  in_Sbox[111:104] = encDec ? shiftRows[79:72] : shiftRows[15:8]; 
				assign	  in_Sbox[119:112] = shiftRows[55:48]; 
				assign	  in_Sbox[127:120] = encDec ? shiftRows[31:24] : shiftRows[95:88]; 
	
		
	 subword subword0 (encDec, in_Sbox[127:96], out_Sbox[127:96]);
	 subword subword1 (encDec, in_Sbox[95:64],  out_Sbox[95:64]); 
	 subword subword2 (encDec, in_Sbox[63:32],  out_Sbox[63:32]); 
	 subword subword3 (encDec, in_Sbox[31:0],   out_Sbox[31:0]); 
	 reg32 rsbox1 (.reset(reset), .load(loadSbox), .dataIn(out_Sbox[127:96]), .dataOut(sboxOut[127:96]));
	 reg32 rsbox2 ( .reset(reset), .load(loadSbox), .dataIn(out_Sbox[95:64]),  .dataOut(sboxOut[95:64])); 
	 reg32 rsbox3 ( .reset(reset), .load(loadSbox), .dataIn(out_Sbox[63:32]),  .dataOut(sboxOut[63:32]));
	 reg32 rsbox4 (.reset(reset), .load(loadSbox), .dataIn(out_Sbox[31:0]),   .dataOut(sboxOut[31:0]));  

endmodule
