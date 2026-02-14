`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:13:00 04/24/2011
// Design Name:   aes256_core
// Module Name:   C:/Documents and Settings/My computer/Desktop/TOP/Copy of aes_cores/t_cores.v
// Project Name:  aes_cores
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: aes256_core
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_cores;

	// Inputs
	reg clk;
	reg reset;
	reg encDec;
	reg AES_start;
	reg keyValid;
	reg dataValid;
	reg continue;
	reg [255:0] CipherKey;
	reg [127:0] dataIn;

	// Outputs
	wire busy;
	wire keyReq;
	wire dataReq;
	wire done;
	wire AES_done;
	wire [127:0] dataOut;

	// Instantiate the Unit Under Test (UUT)
	aes256_core uut (
		.clk(clk), 
		.reset(reset), 
		.encDec(encDec), 
		.AES_start(AES_start), 
		.keyValid(keyValid), 
		.dataValid(dataValid), 
		.continue(continue), 
		.CipherKey(CipherKey), 
		.dataIn(dataIn), 
		.busy(busy), 
		.keyReq(keyReq), 
		.dataReq(dataReq), 
		.done(done), 
		.AES_done(AES_done), 
		.dataOut(dataOut)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		encDec = 0;
		AES_start = 0;
		keyValid = 0;
		dataValid=0;
		dataIn=128'h00112233445566778899aabbccddeeff;
	
		continue = 0;
		@(posedge clk);
		reset=0;
		@(posedge clk); 
		AES_start = 1;
		CipherKey = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f; 
		#30;
		@(posedge clk);
		keyValid=1;
		//#250;
		@(posedge clk);
		dataValid=1;
		continue = 1;
		#300;
		dataValid = 0;
		encDec=1;
		dataIn=128'h8ea2b7ca516745bfeafc49904b496089;
		@(posedge clk);
		dataValid = 1;
		
		
	end
always #5 clk = ~clk;
endmodule

