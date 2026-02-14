`timescale 1ns/1ns 
//////////////////////////////////////////////////////////////////////////////////
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
module databuffer (clk, reset, load, dataIn, dataOut); 
        input clk, reset, load; 
        input [31:0] dataIn; 
        output reg [31:0] dataOut; 
        always @(posedge reset or posedge clk) 
        begin 
                if (reset) 
                     dataOut = 32'h00000000; 
						else  
                     if (load) 
                             dataOut = dataIn; 
     end 
endmodule
