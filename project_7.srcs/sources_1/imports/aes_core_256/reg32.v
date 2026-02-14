`timescale 1ns/1ns //////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:42:09 03/30/2011 
// Design Name: 
// Module Name:    reg_32 
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
module reg32 (reset, load, dataIn, dataOut); 
        input reset, load; 
        input [31:0] dataIn; 
        output  reg[31:0] dataOut; 
		  reg [31:0] dataOut_tmp;
        always @(dataIn or reset or load) 
        begin 
					if(reset)
						dataOut=32'h0;
						else if(load)
							dataOut=dataIn;
							else dataOut=32'h0;
							//else dataOut=31'hx;
			end
endmodule		 
