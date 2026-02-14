`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:10:24 05/10/2011
// Design Name:   aes256_core
// Module Name:   C:/Documents and Settings/My computer/Desktop/TOP/nhap/test 1 Wordk2 aes_cores/Wordk2 aes_cores/tb_cores.v
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

module tb_cores;

	// Inputs
	reg clk;
	reg reset;
	reg [255:0] CipherKey;
	reg [127:0] dataIn;
	reg [31:0] Control_reg;

	// Outputs
	wire [127:0] dataOut;
	wire [31:0] Status_reg;

	// Instantiate the Unit Under Test (UUT)
	aes256_core uut (
		.clk(clk), 
		.reset(reset), 
		.CipherKey(CipherKey), 
		.dataIn(dataIn), 
		.dataOut(dataOut), 
		.Control_reg(Control_reg), 
		.Status_reg(Status_reg)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		CipherKey = 0;
		dataIn = 0;
		Control_reg = 32'h0;		
		CipherKey = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f; 
		@(posedge clk);
		reset=0;
		
		@(posedge clk);
		Control_reg = 32'h00000001; //AES_Start + encCode
		@(posedge clk);
		Control_reg = 32'h00000003;//Key Valid + encCode
		dataIn=128'h00112233445566778899aabbccddeeff;		
		@(posedge clk);
		Control_reg = 32'h0000000d;//Data Valid +encCode+continue		
		#300;
		@(posedge clk);
		Control_reg = 32'h00000019;//AES_Start+deCode
		dataIn=128'h8ea2b7ca516745bfeafc49904b496089;
		@(posedge clk);
		Control_reg = 32'h0000001d;//Data Valid + deCode
		#170;
		
		
		//--------------DATA 2--------------------
		@(posedge clk);		
		Control_reg = 32'h00000009;//AES_Start+enCode
		dataIn=128'h3243f6a8885a308d313198a2e0370734;		
		@(posedge clk);
		Control_reg = 32'h0000000d;//Data Valid + ecCode
		#160;
		@(posedge clk);	
		Control_reg = 32'h00000019;//AES_Start+deCode
		dataIn=128'h9a198830ff9a4e39ec1501547d4a6b1b;		
		@(posedge clk);
		Control_reg = 32'h0000001d;//Data Valid + deCode
		#160;		
		
		//-----------------DATA 3---------------------
		@(posedge clk);		
		Control_reg = 32'h00000009;//AES_Start+enCode
		dataIn=128'hd6aa74fdd2af72fadaa678f1d6ab76fe;		
		@(posedge clk);
		Control_reg = 32'h0000000d;//Data Valid + ecCode
		#160;
		@(posedge clk);	
		Control_reg = 32'h00000019;//AES_Start+deCode
		//dataIn=128'h63eac3dd2740102669b21654956d0249;	
		dataIn=128'h96ca8da7923d58666ba6f141b80d00a7;
		@(posedge clk);
		Control_reg = 32'h0000001d;//Data Valid + deCode
		#170;	
		@(posedge clk);
		reset =1 ;
	
	end
 always #5 clk = ~clk;    
endmodule

