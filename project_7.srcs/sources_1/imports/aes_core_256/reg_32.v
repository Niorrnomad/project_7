`timescale 1ns/1ns 
 module reg_32 (clk, reset, load, dataIn, dataOut); 
         input clk, reset, load; 
         input [31:0] dataIn; 
         output reg [31:0] dataOut; 
			
         always @(posedge reset or posedge clk) 
         begin 
                 if (reset) 
					                dataOut = 32'h00000000; 
                else if (clk) 
                        if (load) 
                                dataOut = dataIn; 
        end 
endmodule 