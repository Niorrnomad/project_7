`timescale 1ns/1ns 
 
module aes_keyexpand_256 (clk, reset,  CipherKey, loadkey, loadrcon, 
                   loadTempKey, firstRound, kld, lowerQuadWord, 
                   roundKey); 
 
        input clk, reset,  loadrcon, loadTempKey, firstRound, 
              kld, lowerQuadWord; 
        input [255:0] CipherKey; 
        input [7:0] loadkey; 
        output [127:0] roundKey; 
		  wire [31:0] w3_sbox,w7_sbox,W7BufferIn,W7BufferOut;
		  wire [31:0] w1,w2,w3,w4,w5,w6,w7,w0;
		  wire [31:0] w3_sub;
		  wire [7:0] outRcon;
		  wire [31:0] w3_i;
		keymodule U_keyModule_0  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[0]), .w_prev(W7BufferOut), .Key(CipherKey[255:224]), .roundKey(w0)); 					 
		keymodule U_keyModule_1  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[1]), .w_prev(w0^W7BufferOut), .Key(CipherKey[223:192]), .roundKey(w1)); 
		keymodule U_keyModule_2  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[2]), .w_prev(w1^w0^W7BufferOut), .Key(CipherKey[191:160]), .roundKey(w2)); 
		keymodule U_keyModule_3  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[3]), .w_prev(w2^w1^w0^W7BufferOut), .Key(CipherKey[159:128]), .roundKey(w3)); 
		keymodule U_keyModule_4	 (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[4]), .w_prev(w3_i), .Key(CipherKey[127:96]), .roundKey(w4)); 
		keymodule U_keyModule_5  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[5]), .w_prev(w4^w3_i), .Key(CipherKey[95:64]), .roundKey(w5)); 
		keymodule U_keyModule_6  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[6]), .w_prev(w5^w4^w3_i), .Key(CipherKey[63:32]), .roundKey(w6)); 
		keymodule U_keyModule_7  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[7]), .w_prev(w6^w5^w4^w3_i), .Key(CipherKey[31:0]), .roundKey(w7));
		//keymodule U_keyModule_0  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[0]), .w_prev(W7BufferOut), .Key(CipherKey/*[255:224]*/), .roundKey(w0)); 					 
		//keymodule U_keyModule_1  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[1]), .w_prev(w0/*^W7BufferOut*/), .Key(CipherKey/*[223:192]*/), .roundKey(w1)); 
		//keymodule U_keyModule_2  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[2]), .w_prev(w1/*^w0^W7BufferOut*/), .Key(CipherKey/*[191:160]*/), .roundKey(w2)); 
		//keymodule U_keyModule_3  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[3]), .w_prev(w2/*^w1^w0^W7BufferOut*/), .Key(CipherKey/*[159:128]*/), .roundKey(w3)); 
		//keymodule U_keyModule_4	 (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[4]), .w_prev(w3_i), .Key(CipherKey/*[127:96]*/), .roundKey(w4)); 
		//keymodule U_keyModule_5  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[5]), .w_prev(w4/*^w3_i*/), .Key(CipherKey/*[95:64]*/), .roundKey(w5)); 
		//keymodule U_keyModule_6  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[6]), .w_prev(w5/*^w4^w3_i*/), .Key(CipherKey/*[63:32]*/), .roundKey(w6)); 
		//keymodule U_keyModule_7  (.clk(clk), .reset(reset), .firstRound(firstRound), .loadkey(loadkey[7]), .w_prev(w6/*^w5^w4^w3_i*/), .Key(CipherKey/*[31:0]*/), .roundKey(w7));
	
	
			sbox u0(	.a(w7[23:16]), .d(w7_sbox[31:24]));
			sbox u1(	.a(w7[15:08]), .d(w7_sbox[23:16]));
			sbox u2(	.a(w7[07:00]), .d(w7_sbox[15:08]));
			sbox u3(	.a(w7[31:24]), .d(w7_sbox[07:00]));	
			assign w3_sub=w3^w2^w1^w0^W7BufferOut;
			sbox u4(	.a(w3_sub[31:24]), .d(w3_sbox[31:24]));
			sbox u5(	.a(w3_sub[23:16]), .d(w3_sbox[23:16]));
			sbox u6(	.a(w3_sub[15:08]), .d(w3_sbox[15:08]));
			sbox u7(	.a(w3_sub[07:00]), .d(w3_sbox[07:00]));
		
		
		
		
     
		rcon U_rcon     (.clk(clk), .reset(reset), .loadrcon(loadrcon), .rcon_out(outRcon)); 
		reg_32 U_W7Buffer (.clk(clk), .reset(reset), .load(loadTempKey), .dataIn(W7BufferIn), .dataOut(W7BufferOut)); 
	   //assign w7_rotate = {w7[23:0], w7[31:24]} ; 
		assign w3_i = kld ? w3 : w3_sbox ; 
		
				
		
		assign W7BufferIn[31:24] =  outRcon ^ w7_sbox[31:24]; 
		assign W7BufferIn[23:0] =  w7_sbox[23:0]; 
		assign roundKey = lowerQuadWord ? {w4, w5, w6, w7} : {w0, w1, w2, w3}; 	
endmodule		 