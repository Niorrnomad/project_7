`timescale 1ns/1ns //////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:10:18 03/30/2011 
// Design Name: 
// Module Name:    ByteMixColumn 
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

module bytemixcolumn (encDec, dataIn_a, dataIn_b, dataIn_c, dataIn_d, dataOut);
		 input encDec; 
		 input [7:0] dataIn_a, dataIn_b, dataIn_c, dataIn_d; 
		 output reg [7:0] dataOut; 
		 wire [7:0] w1,w2,w3,w4,w5,w6,w7,w8,encrypt,decrypt;	
		  
		 assign w1 = dataIn_a^dataIn_b;  				 //w1=a^b
		 assign w2 = dataIn_a^dataIn_c; 				// w2=a^c;
		 assign w3 = dataIn_c^dataIn_d; 				// w3=c^d;
		 xtime xtimew4 (.dataIn(w1), .dataOut(w4));   // w4 = 2*w1
		 xtime xtimew5 (.dataIn(w3), .dataOut(w5));   // w5 = 2*w3 		
		 assign w6 = w2^w4^w5;        								//w6=w2^w4^w5
		 xtime xtimew7 (.dataIn(w6), .dataOut(w7));    // w7 = 2*w6 
		 xtime xtimew8 (.dataIn(w7), .dataOut(w8));    // w8 = 2*w7 			
		 assign encrypt = dataIn_b^w3^w4;    // encrypt = b^w3^w4 
		 assign decrypt = encrypt^w8;  
		 
	always @(encDec or encrypt or decrypt) 
		 begin 
			  if (encDec == 1'b0) 
					dataOut <= encrypt;  
			  else     
					dataOut <= decrypt;  
		end  
endmodule 