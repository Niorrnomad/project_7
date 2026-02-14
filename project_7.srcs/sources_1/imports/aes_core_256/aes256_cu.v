		`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:44:06 04/18/2011 
// Design Name: 
// Module Name:    aes256_cu 
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
module aes256_cu (clk, reset, encDec, AES_start, keyValid,dataValid,   
						   continue, busy, keyReq, dataReq, done, AES_done, 
							load_key, loadrcon, loadTempKey, firstRound, kld, 
							addr, we, lowerQuadWord, dataBufferSelect, loadData, 
							mixColumnSelect, loadMix, shiftSubByteSelect, loadSbox,    
							addRoundKeySelect, loadRKey //,DISLAY_STATE
								 );
	input 			clk, reset, encDec, AES_start, keyValid, dataValid, continue; 
	wire 			clk, reset, encDec, AES_start, keyValid, dataValid, continue;
	 
	output 			busy, keyReq, dataReq, done, AES_done; 
	reg 				busy, keyReq, dataReq, done, AES_done;
	 
	  // Control signals for Key Expansion 
	output 			[7:0] load_key; 
	reg 				[7:0] load_key; 

	output 			loadrcon, loadTempKey, firstRound, kld;
	reg 				loadrcon, loadTempKey, firstRound, kld;
	 
	//output 			[8*50:1] DISLAY_STATE;
	reg 				[8*50:1] DISLAY_STATE;
	 
	  // Control signals for TRANSFORMATION 
	output 			[1:0] addRoundKeySelect; 
	reg 				[1:0] addRoundKeySelect;
	 
	output 			dataBufferSelect, loadData, mixColumnSelect, loadMix, shiftSubByteSelect,  loadSbox, loadRKey; 
	reg 				dataBufferSelect, loadData, mixColumnSelect, loadMix, shiftSubByteSelect,  loadSbox, loadRKey; 
	  // Control signals for key RAM 
	output 			[3:0] addr; 

	 
	output we, lowerQuadWord; 
	reg we, lowerQuadWord;	  
		
	reg [5:0] state,next_state;
	reg [3:0] count_ps,count_ns;
	reg [3:0] Nr_ps,Nr_ns;
	reg [7:0] loadkey,loadkey_ns;
	//reg [3:0] keyreq_cnt,keyreq_cnt_ns;
	
	assign 	  addr      	  = count_ps;
	parameter  Nk				  =8;
	parameter  Nr				  =14;	
	parameter [3:0] IDLE 	= 6'd0;
	//=============KEY EXPAND AES 256 =========
	parameter [3:0] KEYREQ 	= 6'd1;				//KEY REQUEST
	parameter [3:0] KES0 	= 6'd2;				//INTINIAL KEY EXPAND
	parameter [3:0] KES1 	= 6'd3;	
	parameter [3:0] KE256_0 = 6'd4;				// KEY EXPAND LOOP ROUNDKEY 3 -15 
	parameter [3:0] KE256_1 = 6'd5;
	
	
	//==============TRANSFORMATION=============
	parameter [3:0] DATAREQ = 6'd6;				//DATA REQUEST
	parameter [3:0] ENCRYPT_0		= 6'd7;		//ENCRYPT
	parameter [3:0] ENCRYPT_1		= 6'd8;
	parameter [3:0] DECRYPT_0		= 6'd9;				//DECRYPT 
	parameter [3:0] DECRYPT_1		= 6'd10;				
	parameter [3:0] TRANFOR_2		= 6'd11;				//END TRANSFORMATION

	
	
	 always @(posedge clk) 
	 begin :state_memory 
			if (reset == 1'b1) begin 
						 state <= IDLE; 
						 count_ps <= 4'd0; 
						 Nr_ps <= 4'd0; 
						 loadkey<= 8'b0;
						// keyreq_cnt<=4'd0;
			end 
			else begin 
						 state <= next_state; 
						 count_ps <= count_ns; 
						 Nr_ps <= Nr_ns;  
						 loadkey<=loadkey_ns;
						// keyreq_cnt<=keyreq_cnt_ns;
			end 
	 end 

	always @(state or busy or keyValid or dataValid or continue or AES_done or encDec or count_ps)
	begin								
		case (state)								
			IDLE       : 	begin						
					 	busy    				= 0;
					  	keyReq   			= 0;
					 	dataReq 				= 0;
					  	lowerQuadWord	 	= 0;
						we 					= 0;
						done   				= 1;	
						AES_done 			= 1;
					
						dataBufferSelect 			= 1;
						loadData        			= 1;
						addRoundKeySelect 		= 2'b00;
						loadRKey          		= 0;
						mixColumnSelect   		= 0;
						loadMix           		= 0;
						shiftSubByteSelect		= 0;
						loadSbox          		= 0;
						firstRound 			= 0;
						load_key 			= 8'h00;
						loadrcon 			= 0;
						loadTempKey			= 0;
						kld   				= 0;										
						Nr_ns = 4'd0;
						//count_ns =4'd0;
						 if(AES_start)
							begin											
								if (continue)
									begin	
											next_state = DATAREQ;
											count_ns = encDec ? 4'd14 : 4'd0 ;
									end
									else begin
												next_state = KEYREQ;
												keyReq	= 1;
												//count_ns =  4'd0 ;
												loadTempKey = 1;
												done = 0;
									end
							end
						else next_state = IDLE;
					end
					
					
					
			//===== KEY EXPANSION - request TRANSFORMATION Key ==== //					
			KEYREQ     :	begin	
							count_ns =  4'd0 ;										
							firstRound 	= 1;
							loadTempKey	= 0;							
							kld   		= 0;
							
							if(keyValid) begin
									loadrcon = 1;
									load_key = 8'hff;
							 	end
							else   begin
									loadrcon = 0;
									load_key = 8'h00;
								end
							keyReq 			= 1;
							busy 				= 1;
							we					= 1;
							lowerQuadWord 		= 0;
							done   			= 0;	
						  	AES_done 		= 0;
						  	next_state = keyValid ? KES0 : KEYREQ;
					end				
		// ====KEY EXPANSION - INITIAL round of key expansion ===== //
			KES0       : 	begin			
							//Signal of expand
							next_state 		= KES1;
							count_ns 		= count_ps + 4'd1;							
							Nr_ns 			= Nr_ps + 4'd1; 
							firstRound 		= 1;
							load_key 		= 8'h00;
							loadrcon 		= 0;
							loadTempKey		= 1;
							kld   			= 0;
							//Signal of handshake
							busy           = 1;  
							keyReq   		= 0;
							dataReq  		= 0;
							lowerQuadWord	= 0;
							we					= 1;
							done   			= 0;
							AES_done 		= 0;

					end			
			KES1       : 	begin																		
							next_state 		=  KE256_0;
							count_ns 		= count_ps + 4'd1;	 
							Nr_ns 			= Nr_ps + 4'd1;
							//Signal of expand
							firstRound 		= 0;
							load_key 		= 8'hff;
							loadrcon 		= 1;
							loadTempKey		= 1;
							kld   			= 0;
							//Signal of handshake
							busy           = 1;  
							keyReq   		= 0;
							dataReq  		= 0;
							lowerQuadWord	= 1;
							we					= 1;
							done   			= 0;
							AES_done 		= 0;
					end

			// ===== KEY EXPANSION - AES256 - LOOP of round key generation =====
			KE256_0    :   begin																			 
							if(Nr_ps != 4'd14)
							begin
							//if(Nr_ps==
								count_ns = count_ps + 4'd1;
								Nr_ns 	= Nr_ps + 4'd1; 
								next_state = KE256_1;
								we=1;
							end
							else begin
							
								next_state 				= DATAREQ;												
								we							= 1;
								Nr_ns 					= 4'd0 ;								
								count_ns 				= 4'd0 ;
								dataBufferSelect 		= 1;
								loadData        		= 1;
								addRoundKeySelect 	= 2'b00;
								dataReq = 1;
							end
							//Signal of expand
							firstRound 		= 0;
							load_key 		= 8'h00;
							loadrcon 		= 0;
							loadTempKey		= 1;
							kld   			= 0;
							//Signal of handshake
							busy           = 1;  
							keyReq   		= 0;
							dataReq  		= 0;
							lowerQuadWord	= 0;
							done   			= 0;
							AES_done 		= 0;
							
					end
																
			KE256_1    :   begin
									next_state =  KE256_0;					
									count_ns = count_ps + 4'd1;	
									Nr_ns 	= Nr_ps + 4'd1;									
											//Signal of expand
										firstRound 		= 0;
										load_key 		= 8'hff;
										loadrcon 		= 1;
										loadTempKey		= 0;
										kld   			= 0;
										//Signal of handshake
										busy           = 1;  
										keyReq   		= 0;
										dataReq  		= 0;
										lowerQuadWord	= 1;
										we					= 1;
										done   			= 0;
										AES_done 		= 0;
								end
			// ==== KEY EXPANSION - FINAL round of key expansion ===
			
			//======================================KEY EXPANSION complete ====================================
			
			
	
			//========================== TRANSFORMATION - request DATA ==== //
			DATAREQ    : 	begin																			//Assert dataReq and wait for dataValid 
										if(dataValid)
										begin												
												next_state =encDec ? DECRYPT_0 : ENCRYPT_0;												
												dataBufferSelect 		= 1;
												loadData        		= 1;
												addRoundKeySelect 	= 2'b00;
												loadRKey          	= 0;
												mixColumnSelect   	= 0;
												loadMix           	= 0;
												shiftSubByteSelect	= 0;
												loadSbox          	= 0;

												//Signal of handshake
																					
												count_ns 				= encDec ? count_ps-4'd1 : count_ps + 4'd1;
										end
										else begin
												dataReq  				= 1;
												next_state 				= DATAREQ;
												count_ns 				= encDec ? 4'd14 : 4'd0 ;
												we=0;
										end
										dataReq= 1;
										busy           		= 1;  
												keyReq   				= 0;
												//dataReq  				= 1;
												lowerQuadWord			= 0;
												we							= 0;
												done   					= 0;
												AES_done 				= 0;
												Nr_ns = Nr_ps + 4'd1;	
								end
				// ====TRANSFORMATION- INITIAL round of ENCRYPT ===== //													 
			ENCRYPT_0         :	begin																
									next_state = ENCRYPT_1;
									Nr_ns = Nr_ps + 4'd1;									
									count_ns 				= count_ps + 4'd1;
									//Signal of trans
									dataBufferSelect 		= 0;
									loadData        		= 1;
									addRoundKeySelect 	= 2'b01;
									loadRKey          	= 1;
									mixColumnSelect   	= 0;
									loadMix           	= 1;
		                     shiftSubByteSelect	= 1;
									loadSbox          	= 1;
										//Signal of handshake
									busy           		= 1;  
									keyReq   				= 0;
									dataReq  				= 0;
									lowerQuadWord			= 0;
									we							= 0;
									done   					= 0;
									AES_done 				= 0;								
								end	
								
			// ===== TRANSFORMATION - AES256 - LOOP of ENCRYPT generation =====
			ENCRYPT_1         :begin 	
							if(Nr_ps==4'd14)
							begin
									next_state =TRANFOR_2;
									addRoundKeySelect = 2'b10;
							end
							else begin
									dataBufferSelect 		= 0;
									loadData        		= 1;
									addRoundKeySelect 	= 2'b01;
									loadRKey          	= 1;
									mixColumnSelect   	= 0;
									loadMix           	= 1;
		                     shiftSubByteSelect	= 1;
									loadSbox          	= 1;
										//Signal of handshake
									busy           		= 1;  
									keyReq   				= 0;
									dataReq  				= 0;
									lowerQuadWord			= 0;
									we							= 0;
									done   					= 0;
									AES_done 				= 0;
									Nr_ns = Nr_ps + 4'd1;
									count_ns = count_ps+4'd1;
									next_state =ENCRYPT_1;
									end
							end
				// ====TRANSFORMATION- INITIAL round of DECRYPT ===== //	
							DECRYPT_0         :	begin															
									next_state =DECRYPT_1;
									Nr_ns = Nr_ps + 4'd1;									
									count_ns 				= count_ps-4'd1;
									//Signal of trans
									dataBufferSelect 		= 0;
									loadData        		= 1;
									addRoundKeySelect 	= 2'b10;
									loadRKey          	= 1;
									mixColumnSelect   	= 0;
									loadMix           	= 1;
		                     shiftSubByteSelect	= 1;
									loadSbox          	= 1;
										//Signal of handshake
									busy           		= 1;  
									keyReq   				= 0;
									dataReq  				= 0;
									lowerQuadWord			= 0;
									we							= 0;
									done   					= 0;
									AES_done 				= 0;
								
								end	
			// ===== TRANSFORMATION - AES256 - LOOP of DECRYPT generation =====					
				DECRYPT_1         : 	begin																			
								if(Nr_ps==4'd14)
								begin
										next_state =TRANFOR_2;
										addRoundKeySelect = 2'b10;
								end
								else begin	
										dataBufferSelect 		= 0;
										loadData        		= 1;
										addRoundKeySelect 	= 2'b10;
										loadRKey          	= 1;
										mixColumnSelect   	= 1;
										loadMix           	= 1;
										shiftSubByteSelect	= 0;
										loadSbox          	= 1;
											//Signal of handshake
										busy           		= 1;  
										keyReq   				= 0;
										dataReq  				= 0;
										lowerQuadWord			= 0;
										we							= 0;
										done   					= 0;
										AES_done 				= 0;
										Nr_ns = Nr_ps + 4'd1;
										count_ns = count_ps-4'd1;
										next_state =DECRYPT_1;
										end
								end
				// ====TRANSFORMATION- FINAL round of TRANSFORMATION ===== //	
				TRANFOR_2         : 	begin
									next_state = IDLE;
									//Signal of trans
									dataBufferSelect 		= 0;
									loadData        		= 1;
									addRoundKeySelect 	= 2'b00;
									loadRKey          	= 1;
									mixColumnSelect   	= 0;
									loadMix           	= 1;
									shiftSubByteSelect	= 1;
									loadSbox          	= 1;
									//Signal of handshake
									busy           		= 1;  
									keyReq   				= 0;
									dataReq  				= 0;
									lowerQuadWord			= 0;
									we							= 0;
									done   					= 0;
									AES_done 				= 0;							
									end		
				endcase
	end

	always @(state) begin
			 case (state)     
					IDLE 				:	DISLAY_STATE = " IDLE"     ; 				
					KEYREQ 			:	DISLAY_STATE = "KEYREQ"     ;
					KES0 				:	DISLAY_STATE = "KEY EXPANDER 256"     ;
					KES1 				:	DISLAY_STATE = "KEY EXPANDER 256"     ;					
					KE256_0 			:	DISLAY_STATE = "KEY EXPANDER 256"     ;
					KE256_1 			:	DISLAY_STATE = "KEY EXPANDER 256"     ;			
					DATAREQ 			:	DISLAY_STATE = "DATAREQ"     ;	
					ENCRYPT_0		:	DISLAY_STATE = "TRANFOR_0"     ;
					ENCRYPT_1		:	DISLAY_STATE = "TRANFOR_1"     ;
					DECRYPT_0		:	DISLAY_STATE = "TRANFOR_0"     ;
					DECRYPT_1		:	DISLAY_STATE = "TRANFOR_1"     ;	
					TRANFOR_2		:	DISLAY_STATE = "TRANFOR_2"     ;	
			 endcase
	end      
endmodule	
