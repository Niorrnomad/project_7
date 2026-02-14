`timescale 1ns/1ns 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:50:15 04/03/2011 
// Design Name: 
// Module Name:    databuffer_large 
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
module databuffer_large(clk,reset,load,dataIn,dataOut);
    input clk, reset, load; 
    input [127:0] dataIn; 
	 output [127:0] dataOut; 
				databuffer databuffer0    (.clk(clk), .reset(reset), .load(load), .dataIn(dataIn[31:0]), .dataOut(dataOut[31:0])); 
			  databuffer databuffer1    (.clk(clk), .reset(reset), .load(load), .dataIn(dataIn[63:32]), .dataOut(dataOut[63:32])); 
			  databuffer databuffer2    (.clk(clk), .reset(reset), .load(load), .dataIn(dataIn[95:64]), .dataOut(dataOut[95:64])); 
			  databuffer databuffer3    (.clk(clk), .reset(reset), .load(load), .dataIn(dataIn[127:96]), .dataOut(dataOut[127:96]));
       /* always @(posedge reset or posedge clk) 
        begin 
                if (reset) 
                     dataOut = 128'h00000000; 
						else  
                     if (load) 
                             dataOut = dataIn; 
     end 
*/

endmodule
