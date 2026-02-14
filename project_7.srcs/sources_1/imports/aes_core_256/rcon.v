 `timescale 1ns/1ns 
 
module rcon (clk, reset, loadrcon, rcon_out); 
    input clk, reset, loadrcon; 
    output reg [7:0] rcon_out;
	reg [3:0] state_ps,state_ns;
	 parameter [3:0] START = 4'd0;
	 parameter [3:0] S0 =  4'd1;
	parameter [3:0]  S1 = 4'd2;
	parameter [3:0]  S2 = 4'd3;
	parameter [3:0]  S3 = 4'd4;
	parameter [3:0]  S4 = 4'd5;
	parameter [3:0]  S5 = 4'd6;
	parameter [3:0]  S6 = 4'd7;
	parameter [3:0]  S7 = 4'd8;
	parameter [3:0]  S8 = 4'd9;
	parameter [3:0]  S9 = 4'd10;
	 
    always @(posedge clk)// or posedge reset or posedge loadrcon) 
    begin 
	 //if(!clk)
	 begin
        if (reset) 
            state_ps <= START; 
        else if(loadrcon)
            state_ps <= state_ns;
		end
	end 
  
    always @(state_ps or loadrcon) 
	 //always@(state_ps
	//if(!clk)
    begin 
         if (loadrcon) begin 
            case (state_ps) 
                START : state_ns <= S0; 
                S0    : state_ns <= S1; 
                S1    : state_ns <= S2; 
                S2    : state_ns <= S3; 
                S3    : state_ns <= S4; 
                S4    : state_ns <= S5; 
                S5    : state_ns <= S6; 
                S6    : state_ns <= S7; 
                S7    : state_ns <= S8;  
                S8    : state_ns <= S9; 
                S9    : state_ns <= START; 
              default : state_ns<=S0; 
            endcase 
         end 
    end 
  always @(state_ps) 
 begin 
     case (state_ps) 
         START : rcon_out = 8'b00000000; 
         S0    : rcon_out = 8'b00000001; // 01 
         S1    : rcon_out = 8'b00000010; // 02 
         S2    : rcon_out = 8'b00000100; // 04 
         S3    : rcon_out = 8'b00001000; // 08 
         S4    : rcon_out = 8'b00010000; // 10 
         S5    : rcon_out = 8'b00100000; // 20 
         S6    : rcon_out = 8'b01000000; // 40 
         S7    : rcon_out = 8'b10000000; // 80 
         S8    : rcon_out = 8'b00011011; // 1B 
         S9    : rcon_out = 8'b00110110; // 36 
			default : rcon_out = 8'b00000000; 
         endcase 
     end 
 endmodule 