`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:11:42 04/23/2011
// Design Name:   AES256_DU
// Module Name:   C:/Documents and Settings/My computer/Desktop/DU/t2AES256_DU/t_aes_du.v
// Project Name:  AES256_DU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AES256_DU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_aes256_top;

	// Inputs
	reg clk;
	reg reset;
	reg encDec;
	reg [255:0] CipherKey;
	reg [7:0] loadkey;
	reg loadrcon;
	reg loadTempKey;
	reg firstRound;
	reg kld;
	reg lowerQuadWord;
	reg [3:0] addr;
	reg we;
	reg [127:0] dataIn;
	reg  [8:0] control;
	// Outputs
	wire [127:0] dataOut;

	// Instantiate the Unit Under Test (UUT)
	aes256_top uut (
		.clk(clk), 
		.reset(reset), 
		.encDec(encDec), 
		.CipherKey(CipherKey), 
		.loadkey(loadkey), 
		.loadrcon(loadrcon), 
		.loadTempKey(loadTempKey), 
		.firstRound(firstRound), 
		.kld(kld), 
		.lowerQuadWord(lowerQuadWord), 
		.addr(addr), 
		.we(we), 
		.dataIn(dataIn), 
		.dataOut(dataOut),
		.control(control)
	);

	initial begin
		// Initialize Inputs
			clk = 0;
			reset = 0;
			encDec = 0;
			CipherKey = 256'hx;
			loadkey = 8'hff;
			loadrcon = 1;
			loadTempKey = 0;
			firstRound = 1;
			kld = 0;
			lowerQuadWord = 0;
			addr = 3'bx;
			we = 1;
		//	dataIn=128'h3243f6a8885a308d313198a2e0370734;
			dataIn=128'h00112233445566778899aabbccddeeff;
			control=9'bx;
			
			//===============================================KEY EXPAND=====================================
			
			@(posedge clk);
			//CipherKey = 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4;
			CipherKey = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f; 
			loadrcon=1;
			loadkey=8'hff;		
			loadTempKey = 1; 
			
			@(posedge clk);		
			firstRound=0;
			loadrcon=0;
			loadkey=8'h00;
			addr=4'd0;
			
			@(posedge clk);
			addr=4'd1;
			loadTempKey = 0;
			loadkey=8'hff;
			loadrcon=1;	
			lowerQuadWord=1;
			
			@(posedge clk);		
			addr=4'd2;	
			loadkey=8'h00;
			lowerQuadWord=0;
			loadTempKey = 1;
			loadrcon=0;
			
			@(posedge clk);	
			lowerQuadWord=1;
			addr=4'd3;
			loadkey=8'hff;
			loadTempKey = 0;
			loadrcon=1;
			
			@(posedge clk);
			lowerQuadWord=0;
			loadTempKey = 1;	
			addr=4'd4;
			loadrcon=0;
			loadkey=8'h00;
				
			@(posedge clk);		
			lowerQuadWord=1;
			loadkey=8'hff;
			loadTempKey = 0;
			addr=4'd5;
			loadrcon=1;
			
			@(posedge clk);
			lowerQuadWord=0;
			loadTempKey = 1;	
			loadrcon=0;
			loadkey=8'h00;
			addr=4'd6;
				
			@(posedge clk);
			lowerQuadWord=1;
			loadkey=8'hff;
			loadTempKey = 0;
			loadrcon=1;
			addr=4'd7;

			@(posedge clk);
			lowerQuadWord=0;
			loadTempKey = 1;	
			loadrcon=0;
			loadkey=8'h00;
			addr=4'd8;

			@(posedge clk);	
			lowerQuadWord=1;
			loadkey=8'hff;
			loadTempKey = 0;
			loadrcon=1;
			addr=4'd9;

			@(posedge clk);
			lowerQuadWord=0;
			loadTempKey = 1;	
			loadrcon=0;
			loadkey=8'h00;
			addr=4'd10;

				
			@(posedge clk);		
			lowerQuadWord=1;
			loadkey=8'hff;
			loadTempKey = 0;
			loadrcon=1;
			addr=4'd11;

		  @(posedge clk);
		  lowerQuadWord=0;
		  loadTempKey = 1;
		  loadrcon=0;
		  loadkey=8'h00;
		  addr=4'd12;

		 @(posedge clk);                
		 lowerQuadWord=1;
		 loadkey=8'hff;
		 loadTempKey = 0;
		 loadrcon=1;
		 addr=4'd13;

		 @(posedge clk);
		 lowerQuadWord=0;
		 loadTempKey = 1;
		 loadrcon=0;
		 loadkey=8'h00;
		 addr=4'd14;

		 @(posedge clk);
		 lowerQuadWord=1;
		 loadkey=8'hff;
		 loadTempKey = 0;
		 loadrcon=1;
		 addr=4'dx;
		 
		 @(posedge clk);
		 lowerQuadWord=0;
		 loadTempKey = 1;
		 loadrcon=0;
		 loadkey=8'h00;

		 @(posedge clk);                
		 lowerQuadWord=1;
		 loadkey=8'hff;
		 loadTempKey = 0;
		 loadrcon=1;
		 
		 @(posedge clk);
		 lowerQuadWord=0;
		 loadTempKey = 1;
		 loadrcon=0;
		 loadkey=8'h00;

		 @(posedge clk);           
		 lowerQuadWord=1;
		 loadkey=8'hff;
		 loadTempKey = 0;
		 loadrcon=1;
		 
		 @(posedge clk);
		 lowerQuadWord=0;
		 loadTempKey = 1;
		 loadrcon=0;
		 loadkey=8'h00;
		#120;
//================================================	Thuc hien Encrypt ==================================================
		
			@(posedge clk);
			control = 9'b11_00_0_00_00;								//load dataIn vao databuffer
			we=0;
			
			@(posedge clk);
			control = 9'b11_00_0_00_00;								//Tin hieu thuc hien addroundkey																			
			addr=4'd0;	
			
			@(posedge clk);
			control = 9'b01_01_1_11_01;								//round1
																				//Tin hieu thuc hien shiftsub-->mixcolumn-->addroundkey
			addr=4'd1;
			
			
			@(posedge clk);
			control = 9'b01_01_1_11_01;								//round2
			addr=4'd2;	
			
			@(posedge clk);
			control = 9'b01_01_1_11_01;								//round3
			addr=4'd3;
			
			@(posedge clk);
			control = 9'b01_01_1_11_01;								//round4
			addr=4'd4;
			
			@(posedge clk);	
			control = 9'b01_01_1_11_01;								//round5
			addr=4'd5;
			
			@(posedge clk);		
			control = 9'b01_01_1_11_01;								//round6
			addr=4'd6;
			
			@(posedge clk);		
			control = 9'b01_01_1_11_01;								//round7
			addr=4'd7;
			
			@(posedge clk);		
			control = 9'b01_01_1_11_01;								//round8
			addr=4'd8;
			
			@(posedge clk);		
			control = 9'b01_01_1_11_01;								//round9
			addr=4'd9;	
			
			@(posedge clk);		
			control = 9'b01_01_1_11_01;								//round10			
			addr=4'd10;													
			
			@(posedge clk);						
			control = 9'b01_01_1_11_01;							//round11			
			addr=4'd11;
			@(posedge clk);						
			control = 9'b01_01_1_11_01;								//round12			
			addr=4'd12;
			@(posedge clk);						
			control = 9'b01_01_1_11_01;								//round13			
			addr=4'd13;
			@(posedge clk);						
			control = 9'b01_10_1_11_00;								//round14		
																				//tin hieu chon thuc hien shiftsub-->addroundkey	
			addr=4'd14;
			
			@(posedge clk);						
			control = 9'b01_10_1_00_00;							//round15			
			//addr=4'd15;
			@(posedge clk);						
			control = 9'b00_00_0_00_00;
			
			
			//=============================Thuc Hien Decrypt==========================================
		
			@(posedge clk);			
			reset=1;
			
			@(posedge clk);
			encDec=1;
			dataIn=128'h8ea2b7ca516745bfeafc49904b496089;
			reset=0;
			
			@(posedge clk);
			control = 9'b11_00_0_00_00;							//load dataIn vao databuffer
			
			@(posedge clk);
			control = 9'b11_00_0_00_00;							//tin hieu chon thuc hien addroundkey		
			addr=4'd14;	
			
			@(posedge clk);						
			control = 9'b01_10_1_11_10;							//round1  tin hieu chon thuc hien shiftsub-->addroundkey											
			addr=4'd13;													//roundkey de thuc hien addroundkey
			
		
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round2  tin hieu chon thuc hien mixcolumn-->shiftsub-->addroundkey
			addr=4'd12;
	
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round3  "   "
			addr=4'd11;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round4
			addr=4'd10;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round5
			addr=4'd9;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round6
			addr=4'd8;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round7
			addr=4'd7;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round8
			addr=4'd6;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round9
			addr=4'd5;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round10
			addr=4'd4;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round11
			addr=4'd3;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round12
			addr=4'd2;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round13
			addr=4'd1;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round14
			addr=4'd0;
			
			@(posedge clk);		
			control = 9'b01_10_1_01_11;							//round15
			addr=4'd0;
			
			@(posedge clk);		
			control = 9'b00_00_0_00_00;	

	
	end
 always #5 clk=~clk;     
endmodule

