 `timescale 1ns/1ns 
  
 module aes256_core (clk, reset,CipherKey, dataIn, dataOut,Control_reg,Status_reg);
  input				clk, reset;
  wire encDec, AES_start, keyValid, dataValid,continue; 
  input 	[255:0] 	CipherKey; 
  input 	[127:0] 	dataIn; 
  wire 			busy, keyReq, dataReq, done, AES_done; 
  output [127:0] 	dataOut; 
  wire 	[7:0] 	load_key; 
  wire 				loadrcon, loadTempKey, firstRound, kld, lowerQuadWord; 
  wire 	[1:0] 	addRoundKeySelect; 
  wire				dataBufferSelect, loadData, loadRKey, mixColumnSelect, loadMix, shiftSubByteSelect, loadSbox ; 
  wire 	[3:0] 	addr; 
  wire 				we; 
  wire [255:0] CipherKey1;
  wire [127:0] dataIn1;
  input [31:0] Control_reg;
  output [31:0] Status_reg;
  
    //------------------------------ Define the internal registers ---------------------
			reg    [31:0]  KEY_IN_REG_0;
			reg    [31:0]  KEY_IN_REG_1;
			reg    [31:0]  KEY_IN_REG_2;
			reg    [31:0]  KEY_IN_REG_3; 
			reg    [31:0]  KEY_IN_REG_4;
			reg    [31:0]  KEY_IN_REG_5;
			reg    [31:0]  KEY_IN_REG_6;
			reg    [31:0]  KEY_IN_REG_7; 
			
			reg    [31:0]  DATA_IN_REG_0;
			reg    [31:0]  DATA_IN_REG_1;
			reg    [31:0]  DATA_IN_REG_2;
			reg    [31:0]  DATA_IN_REG_3;
			
			reg    [31:0]  DATA_OUT_REG_0;     
			reg    [31:0]  DATA_OUT_REG_1;
			reg    [31:0]  DATA_OUT_REG_2;
			reg    [31:0]  DATA_OUT_REG_3;
			
			always @(dataReq or keyReq or done) begin
			/*if (reset) begin
              /*  KEY_IN_REG_0  <=  #1  32'h00000000;
                KEY_IN_REG_1  <=  #1  32'h00000000;
                KEY_IN_REG_2  <=  #1   32'h00000000;
                KEY_IN_REG_3  <=  #1  32'h00000000;
					 KEY_IN_REG_4  <=  #1 32'h00000000;
                KEY_IN_REG_5  <=  #1  32'h00000000;
                KEY_IN_REG_6  <=  #1  32'h00000000;
                KEY_IN_REG_7  <=  #1  32'h00000000;
                DATA_IN_REG_0 <=  #1  32'h00000000;
                DATA_IN_REG_1 <=  #1  32'h00000000;
                DATA_IN_REG_2 <=  #1  32'h00000000;
                DATA_IN_REG_3 <=  #1  32'h00000000;   
				 DATA_OUT_REG_0 <=  #1  32'h00000000;     
					 DATA_OUT_REG_1 <=  #1  32'h00000000; 
					 DATA_OUT_REG_2 <=   #1 32'h00000000; 
					 DATA_OUT_REG_3 <=   #1 32'h00000000; 			 
					 
					end*/
        /* else  if(keyReq)  
					begin
					 KEY_IN_REG_0  <=  #1 CipherKey[255:224];
                KEY_IN_REG_1  <=  #1 CipherKey[223:192];
                KEY_IN_REG_2  <=  #1 CipherKey[192:160];
                KEY_IN_REG_3  <=  #1 CipherKey[159:128];
					 KEY_IN_REG_4  <=  #1 CipherKey[127:96];
                KEY_IN_REG_5  <=  #1 CipherKey[95:64];
                KEY_IN_REG_6  <=  #1 CipherKey[63:32];
                KEY_IN_REG_7  <=  #1 CipherKey[31:0];
					end*/
					  if(dataReq) begin
					 DATA_IN_REG_0 <=  #1  dataIn[127:96];
                DATA_IN_REG_1 <=  #1  dataIn[95:64];
                DATA_IN_REG_2 <=  #1  dataIn[63:32];
                DATA_IN_REG_3 <=  #1  dataIn[31:0];  
					end
					 else if(done)
					 begin
							 DATA_OUT_REG_0 <=    #1   dataOut[127:96]; 
							 DATA_OUT_REG_1 <=    #1  dataOut[95:64];
							 DATA_OUT_REG_2 <=    #1  dataOut[63:32];
							 DATA_OUT_REG_3 <=    #1  dataOut[31:0];  	
				/*	end
					else 
					begin
							 DATA_OUT_REG_0 <=  #1   32'h00000000;    
							 DATA_OUT_REG_1 <=   #1   32'h00000000;   
							 DATA_OUT_REG_2 <=   #1  32'h00000000;   
							 
							 DATA_OUT_REG_3 <=   #1   32'h00000000;   	*/
							 
					end
			end
			always@(posedge clk)
			begin
				if (reset) begin
                KEY_IN_REG_0  <=  #1  32'h00000000;
                KEY_IN_REG_1  <=  #1  32'h00000000;
                KEY_IN_REG_2  <=  #1   32'h00000000;
                KEY_IN_REG_3  <=  #1  32'h00000000;
					 KEY_IN_REG_4  <=  #1 32'h00000000;
                KEY_IN_REG_5  <=  #1  32'h00000000;
                KEY_IN_REG_6  <=  #1  32'h00000000;
                KEY_IN_REG_7  <=  #1  32'h00000000;
					// DATA_IN_REG_0 <=  #1  32'h00000000;
               // DATA_IN_REG_1 <=  #1  32'h00000000;
                //DATA_IN_REG_2 <=  #1  32'h00000000;
                //DATA_IN_REG_3 <=  #1  32'h00000000;   
					/* DATA_OUT_REG_0 <=  #1  32'h00000000;     
					 DATA_OUT_REG_1 <=  #1  32'h00000000; 
					 DATA_OUT_REG_2 <=   #1 32'h00000000; 
					 DATA_OUT_REG_3 <=   #1 32'h00000000; */		
					 end
				 else  if(keyReq)  
					begin
					 KEY_IN_REG_0  <=  #1 CipherKey[255:224];
                KEY_IN_REG_1  <=  #1 CipherKey[223:192];
                KEY_IN_REG_2  <=  #1 CipherKey[192:160];
                KEY_IN_REG_3  <=  #1 CipherKey[159:128];
					 KEY_IN_REG_4  <=  #1 CipherKey[127:96];
                KEY_IN_REG_5  <=  #1 CipherKey[95:64];
                KEY_IN_REG_6  <=  #1 CipherKey[63:32];
                KEY_IN_REG_7  <=  #1 CipherKey[31:0];
					end
				end
				assign CipherKey1    = {KEY_IN_REG_0, KEY_IN_REG_0,KEY_IN_REG_2,KEY_IN_REG_3,KEY_IN_REG_4, KEY_IN_REG_5,KEY_IN_REG_6,KEY_IN_REG_7};   
			assign dataIn1 = {DATA_IN_REG_0,DATA_IN_REG_1,DATA_IN_REG_2,DATA_IN_REG_3};
  
  aes256_cu controller 
          (.clk(clk), .reset(reset),  .encDec(encDec), .AES_start(AES_start), .keyValid(keyValid), .dataValid(dataValid), 
           .continue(continue), .busy(busy), .keyReq(keyReq), .dataReq(dataReq), .done(done), .AES_done(AES_done), .load_key(load_key), 
           .loadrcon(loadrcon), .loadTempKey(loadTempKey), .firstRound(firstRound), .kld(kld), .addr(addr), .we(we),       
			  .lowerQuadWord(lowerQuadWord), .dataBufferSelect(dataBufferSelect), .loadData(loadData), .mixColumnSelect(mixColumnSelect), .loadMix(loadMix),
			    .shiftSubByteSelect(shiftSubByteSelect), .loadSbox(loadSbox),  .addRoundKeySelect(addRoundKeySelect), .loadRKey(loadRKey)); 
	aes256_top top
        (.clk(clk), .reset(reset),  .encDec(encDec), .CipherKey(CipherKey), .loadkey(load_key), .loadrcon(loadrcon), 
         .loadTempKey(loadTempKey), .firstRound(firstRound), .kld(kld), .lowerQuadWord(lowerQuadWord), .addr(addr), 
         .we(we), .dataIn(dataIn),  .addRoundKeySelect(addRoundKeySelect), .loadRKey(loadRKey), 
         .dataBufferSelect(dataBufferSelect), .loadData(loadData), .shiftSubByteSelect(shiftSubByteSelect), .loadSbox(loadSbox), 
			.mixColumnSelect(mixColumnSelect),  .loadMix(loadMix), .dataOut(dataOut)); 
	assign encDec 		= Control_reg[4];
	assign AES_start 	= Control_reg[0];
	assign keyValid 	= Control_reg[1];
	assign dataValid 	= Control_reg[2];
	assign continue 	= Control_reg[3];
	assign Status_reg [31:5] = 27'b000000000000000000000000000;
	assign Status_reg [4] = AES_done;
	assign Status_reg [3] = done;
	assign Status_reg [2] = busy;
	assign Status_reg [1] = dataReq;
	assign Status_reg [0] = keyReq;
	
endmodule
