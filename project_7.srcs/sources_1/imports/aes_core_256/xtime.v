`timescale 1ns/1ns 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:17:41 03/30/2011 
// Design Name: 
// Module Name:    xtime 
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

module xtime (dataIn, dataOut); 
	input [7:0] dataIn; 
     output [7:0] dataOut; 
	  reg [7:0] data_tmp;
     assign b7 = dataIn[7]; 
 
    always @(b7 or dataIn) 
    begin 
        case (b7) 
            1'b1 : begin 
                       data_tmp[7:1] <= dataIn[6:0] ^ 7'b0001101; 
                       data_tmp[0] <= 1'b1; 
                   end           
 
            1'b0 : begin 
                       data_tmp[7:1] <= dataIn[6:0]; 
                       data_tmp[0] <= 1'b0; 
                   end           
 
            default : data_tmp <= 8'h0; 
        endcase  
    end  
  
    assign dataOut = data_tmp;          
endmodule 
