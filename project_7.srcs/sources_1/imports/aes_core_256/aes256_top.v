`timescale 1ns/1ns 
 
module aes256_top (clk, reset,  encDec, CipherKey, loadkey, loadrcon, 
                  loadTempKey, firstRound, kld, lowerQuadWord, 
                  addr, we, dataIn,  
                  addRoundKeySelect, loadRKey, dataBufferSelect, loadData, 
                  shiftSubByteSelect, loadSbox, mixColumnSelect, loadMix, dataOut
						); 
 
        input clk, reset,  encDec; 
 
        input [255:0] CipherKey; 
        input [7:0] loadkey; 
        input loadrcon, loadTempKey, firstRound, kld, lowerQuadWord; 
 
        input [3:0] addr; 
        input we; 
 
        input [127:0] dataIn; 
     /*  //----------TEST-----------
		 wire [1:0] addRoundKeySelect; 
        wire dataBufferSelect, loadData, loadRKey, mixColumnSelect, loadMix, 
              shiftSubByteSelect, loadSbox ; 
		//------------------------------*/
		
		  input [1:0] addRoundKeySelect; 
        input dataBufferSelect, loadData, loadRKey, mixColumnSelect, loadMix, shiftSubByteSelect, loadSbox;
        output [127:0] dataOut; 
		  //input  [8:0] control;
		  wire [127:0] expandedKey;
		  wire [127:0] roundKey;
		  
        aes_keyexpand_256 keyexpand  (.clk(clk), .reset(reset),  .CipherKey(CipherKey), .loadkey(loadkey), .loadrcon(loadrcon), 
											.loadTempKey(loadTempKey), .firstRound(firstRound), .kld(kld), .lowerQuadWord(lowerQuadWord), .roundKey(expandedKey)); 
 
        keyram_128 keyram 
                (.clk(clk),.reset(reset), .roundt(expandedKey), .addr(addr), .we(we),.roundk(roundKey)); 
 
        aes_transformation aes_transformation 
                (.clk(clk), .reset(reset), .encDec(encDec), .dataIn(dataIn), .roundKey(roundKey), //sel_addKey,  
                 .addRoundKeySelect(addRoundKeySelect), .loadRKey(loadRKey), .dataBufferSelect(dataBufferSelect),
					  .loadData(loadData), .shiftSubByteSelect(shiftSubByteSelect), .loadSbox(loadSbox), 
					  .mixColumnSelect(mixColumnSelect), .loadMix(loadMix), .dataOut(dataOut)); 
 
 
 
 
	/*	//-----------------TEST---------------
		 assign dataBufferSelect    	= control[8]; 
		 assign loadData            	= control[7]; 
		 assign addRoundKeySelect   	= control[6:5]; 
		 assign loadRKey            	= control[4]; 
		 assign shiftSubByteSelect    = control[3]; 
		 assign loadSbox              = control[2]; 
		 assign mixColumnSelect  		= control[1]; 
		 assign loadMix         		= control[0]; 
//---------------------------------------------*/


endmodule 