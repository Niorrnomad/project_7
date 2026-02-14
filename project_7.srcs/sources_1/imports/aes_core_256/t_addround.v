`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:13:49 05/08/2011
// Design Name:   addroundkey
// Module Name:   C:/Users/DELL/Desktop/7.5/OK expand/Copy of Wordk2 aes_cores/t_addround.v
// Project Name:  aes_cores
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: addroundkey
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_addround;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] addRoundKeySelect;
	reg [127:0] dataBufferOut;
	reg [127:0] mixColumnOut;
	reg [127:0] sboxOut;
	reg [127:0] roundKey;
	reg loadRKey;

	// Outputs
	wire [127:0] addKeyOut;

	// Instantiate the Unit Under Test (UUT)
	addroundkey uut (
		.clk(clk), 
		.reset(reset), 
		.addRoundKeySelect(addRoundKeySelect), 
		.dataBufferOut(dataBufferOut), 
		.mixColumnOut(mixColumnOut), 
		.sboxOut(sboxOut), 
		.roundKey(roundKey), 
		.loadRKey(loadRKey), 
		.addKeyOut(addKeyOut)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		addRoundKeySelect = 2'hx;
		dataBufferOut = 128'h00112233445566778899aabbccddeeff;
		mixColumnOut = 128'h00112233445566778899aabbccddeeff;
		sboxOut = 0;
		roundKey = 0;
		loadRKey = 0;
		@(posedge clk);
		addRoundKeySelect = 2'h01;
		// Wait 100 ns for global reset to finish

        
		// Add stimulus here
	
	end
   always #5 clk = ~clk;   
endmodule

