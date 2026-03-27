//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:39:39 08/25/2025 
// Design Name: 
// Module Name:    sha256 
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
module sha256(
input wire i_clk,i_rst_n,i_enable,
input wire [31:0] i_data,
input wire [7:0] i_n,
input wire [8:0] i_miss,
output reg o_done,
output reg [31:0] o_data,
output reg [2:0]o_read
    );
	 parameter IDLE=3'b000, GDATA=3'b001, PADDED=3'b010, INIT=3'b011, COMPRESS=3'b100, FINISH=3'b101,OUTPUT=3'b110;
	 reg [31:0] a,b,c,d,e,f,g,h,H0,H1,H2,H3,H4,H5,H6,H7;
	 reg [7:0] blk_cnt;
	 reg [31:0] w [0:63];
	 reg done_round,last_block;
	 reg [7:0] j; 
	 reg [7:0] cnt;
     reg [511:0] block;
	 reg [31:0] k;
	 reg [2:0] state;
	 reg [2:0] next_state;
	 reg [7:0] r_i_n;
     reg [7:0] okpad;
	 reg nblock;
     reg [4:0] pos;
	 reg [63:0] msg_bits;
     reg [1:0] padm;
	 reg ct1,ct2;
	 reg [8:0] i;
	 wire [511:0] upper_mask=(~512'h0)<<i_miss;
	 reg [31:0] out; 
	 always @(posedge i_clk) begin
	 ct1<=done_round;
	 end
	 always @(posedge i_clk) begin
	 if(512-i_miss<448)nblock<=0;
	 else nblock<=1;
	 end
	 reg [80:0] state_str;  

	always @(*) begin
	  case(state)
		 3'd0: state_str = "IDLE    ";
		 3'd1: state_str = "GDATA    ";
		 3'd2: state_str = "PADDING";
		 3'd3: state_str = "INIT  ";
		 3'd4: state_str = "COMPRESS";
		 3'd5: state_str = "FINISH";
		 3'd6:state_str="READ";
		 default: state_str = "UNKNOWN ";
	  endcase
	end
                function [31:0] rotr;
                    input [31:0] x;
                    input [4:0] y;
                begin 
                rotr=(x>>y)|(x<<(32-y));
                end 
                endfunction
                function [31:0] sigma0;
                input [31:0]x;
                begin 
                sigma0=rotr(x,2)^rotr(x,13)^rotr(x,22);
                end
                endfunction
                    function [31:0] sigma1;
                input [31:0]x;
                begin 
                sigma1=rotr(x,6)^rotr(x,11)^rotr(x,25);
                end
                endfunction
                function [31:0] o0;
                input [31:0]x;
                begin 
                o0=rotr(x,7)^rotr(x,18)^(x>>3);
                end endfunction
                function [31:0] o1;
                input [31:0]x;
                begin 
                o1=rotr(x,17)^rotr(x,19)^(x>>10);
                end 
                endfunction
                function [31:0] ch;
                input [31:0] x,y,z;
                begin 
                ch=(x&y)^(~x&z);
                end endfunction
                function [31:0] maj;
                input [31:0] x,y,z;
                begin 
                maj=(x&y)^(x&z)^(y&z);
                end 
                endfunction
    	 	wire [31:0] geng1=h+sigma1(e)+ch(e,f,g)+k+w[j];
            
			always @(*) begin
					case (o_read)
					3'd0: out = H0;
					3'd1: out = H1;
					3'd2: out = H2;
					3'd3: out = H3;
					3'd4: out = H4;
					3'd5: out = H5;
					3'd6: out = H6;
					3'd7: out = H7;
					endcase
				end
always @(*) begin
        case (j)
            6'd0:  k = 32'h428a2f98;
            6'd1:  k = 32'h71374491;
            6'd2:  k = 32'hb5c0fbcf;
            6'd3:  k = 32'he9b5dba5;
            6'd4:  k = 32'h3956c25b;
            6'd5:  k = 32'h59f111f1;
            6'd6:  k = 32'h923f82a4;
            6'd7:  k = 32'hab1c5ed5;
            6'd8:  k = 32'hd807aa98;
            6'd9:  k = 32'h12835b01;
            6'd10: k = 32'h243185be;
            6'd11: k = 32'h550c7dc3;
            6'd12: k = 32'h72be5d74;
            6'd13: k = 32'h80deb1fe;
            6'd14: k = 32'h9bdc06a7;
            6'd15: k = 32'hc19bf174;
            6'd16: k = 32'he49b69c1;
            6'd17: k = 32'hefbe4786;
            6'd18: k = 32'h0fc19dc6;
            6'd19: k = 32'h240ca1cc;
            6'd20: k = 32'h2de92c6f;
            6'd21: k = 32'h4a7484aa;
            6'd22: k = 32'h5cb0a9dc;
            6'd23: k = 32'h76f988da;
            6'd24: k = 32'h983e5152;
            6'd25: k = 32'ha831c66d;
            6'd26: k = 32'hb00327c8;
            6'd27: k = 32'hbf597fc7;
            6'd28: k = 32'hc6e00bf3;
            6'd29: k = 32'hd5a79147;
            6'd30: k = 32'h06ca6351;
            6'd31: k = 32'h14292967;
            6'd32: k = 32'h27b70a85;
            6'd33: k = 32'h2e1b2138;
            6'd34: k = 32'h4d2c6dfc;
            6'd35: k = 32'h53380d13;
            6'd36: k = 32'h650a7354;
            6'd37: k = 32'h766a0abb;
            6'd38: k = 32'h81c2c92e;
            6'd39: k = 32'h92722c85;
            6'd40: k = 32'ha2bfe8a1;
            6'd41: k = 32'ha81a664b;
            6'd42: k = 32'hc24b8b70;
            6'd43: k = 32'hc76c51a3;
            6'd44: k = 32'hd192e819;
            6'd45: k = 32'hd6990624;
            6'd46: k = 32'hf40e3585;
            6'd47: k = 32'h106aa070;
            6'd48: k = 32'h19a4c116;
            6'd49: k = 32'h1e376c08;
            6'd50: k = 32'h2748774c;
            6'd51: k = 32'h34b0bcb5;
            6'd52: k = 32'h391c0cb3;
            6'd53: k = 32'h4ed8aa4a;
            6'd54: k = 32'h5b9cca4f;
            6'd55: k = 32'h682e6ff3;
            6'd56: k = 32'h748f82ee;
            6'd57: k = 32'h78a5636f;
            6'd58: k = 32'h84c87814;
            6'd59: k = 32'h8cc70208;
            6'd60: k = 32'h90befffa;
            6'd61: k = 32'ha4506ceb;
            6'd62: k = 32'hbef9a3f7;
            6'd63: k = 32'hc67178f2;
            default: k = 32'h0;
        endcase
    end
	 wire [31:0] g2=sigma0(a)+maj(a,b,c);
	 always @(*) begin  
	 case(state)
		    IDLE:     next_state = (i_enable || (blk_cnt !=0 && blk_cnt < i_n)) ? GDATA : IDLE;
            GDATA:    next_state = (pos==15) ? (last_block && i_miss !=0 ? PADDED : INIT) : GDATA;
            PADDED:   next_state = INIT;
	        INIT: next_state=(cnt==7'd63)?COMPRESS:INIT;
            COMPRESS:if (done_round)begin
                if (blk_cnt == i_n- 1)
					 next_state=FINISH;
                else next_state=IDLE;
                end
                else next_state=COMPRESS; 
            OUTPUT: next_state=OUTPUT;
        default: next_state=IDLE;
     endcase
     end
     always @(posedge i_clk or negedge i_rst_n) begin
        if(!i_rst_n)begin 
            state <= IDLE;
            o_done<=0;
				o_read<=0;
            o_data<=0;
            blk_cnt<=0;
            last_block<=0;
			cnt<=0;j<=0;
            pos <= 4'd0;
			block<=512'h0;
			r_i_n<=0;
            msg_bits<=0;
            done_round<=0;
            block <= 512'd0;
            H0<=0; H1<=0; H2<=0; H3<=0;
            H4<=0; H5<=0; H6<=0; H7<=0;
            a<=0;b<=0;c<=0;d<=0;e<=0;f<=0;g<=0;h<=0;
        end
        else begin
            state<=next_state;
            case (state)
            IDLE: begin
                okpad<=(512-i_miss)/32;
                o_done<=0;
                done_round<=0;
					 o_read<=0;
				r_i_n<=i_n;
                pos <= 4'd0;
                msg_bits<=(i_n*512-i_miss);
                padm <= 2'd0;
                if (i_enable||(blk_cnt != 8'd0 && blk_cnt <r_i_n))begin
                if (blk_cnt == 0) begin
                H0 <=32'h6a09e667;
                H1<=32'hbb67ae85;
                H2<=32'h3c6ef372;
                H3<=32'ha54ff53a;
                H4<=32'h510e527f;
                H5<=32'h9b05688c;
                H6<=32'h1f83d9ab;
                H7<=32'h5be0cd19;
                end
                last_block<=(blk_cnt ==r_i_n-1);
                end
            end
            GDATA: begin
                block[511 - pos*32 -: 32]<=i_data; 
                pos<=pos+1;
            end
            PADDED: begin  
                    if (padm==0) begin
                        if (i_miss==0) begin
                            block<=(512'h1 << 511) | msg_bits;
                            padm<=2'd3;
                            state<=INIT;
                        end else begin
                            if (512 - i_miss < 448) begin
                                block <= (block&upper_mask)|(512'h1<<(i_miss-1))|msg_bits;
                                padm <= 2'd3;
                                state <= INIT;
                            end else begin 
                                block<=(block&upper_mask)|(512'h1<<(i_miss-1));
                                padm<=2'd1;
                                state<=INIT;
                            end
                        end
                    end else if(padm==2'd1)begin  
                        block<=msg_bits;
                        padm<=2'd3;
                        state<=INIT;
                    end
                end
            INIT: begin
                o_done<=0;
                done_round<=0;
                if(cnt<16)begin
                    w[cnt] <= block[511 - cnt*32 -: 32];
                end
                else w[cnt] <= o1(w[cnt-2]) + w[cnt-7] + o0(w[cnt-15]) +w[cnt-16];
                cnt<=cnt+1;
                if (cnt==7'd63) begin
                    a <=H0;
                    b <=H1;
                    c <=H2;
                    d<=H3;
                    e<=H4;
                    f<=H5;
                    g<=H6;
                    h<=H7;
		            cnt<=0;
                end
            end
            COMPRESS: begin
                if (!done_round) begin
                    if (j <= 7'd63) begin
                        h<=g;
	                    g<=f;
	                    f<=e;
	                    e<=d+geng1;
	                    d<=c;
	                    c<=b;
	                    b<=a;
	                    a<=geng1+g2;
	                    j<=j+1;
                    end 
                    else begin
                    done_round<=1'b1; j<=0;
                    cnt<=0;
                    end
                end
                else begin
                    H7<=H7+h;
                    H6<=H6+g;
                    H5<=H5+f;
                    H4<=H4+e;
                    H3<=H3+d;
                    H2<=H2+c;
                    H1<=H1+b;
                    H0<=H0+a;                
				    if (!last_block) begin
                        blk_cnt <= blk_cnt + 1;
                    end
                    	 if(blk_cnt==i_n-1) last_block<=1;
	 else last_block<=0;
                    done_round <= 1'b0;
                end
            end
            FINISH: begin
                block <= 512'd0;
                 if (padm == 2'd1) begin
                        state <=PADDED;
                    end else if (padm == 2'd3) begin
                        state <= OUTPUT;
                        o_done <= 1'b1;
                        padm <= 2'd0;
                    end else if (last_block) begin
                        last_block<= 1'b0;
                        state <= PADDED;
                    end else begin
                        pos<=4'd0;
                        state<=GDATA;
                    end
            end
            OUTPUT: begin
				if(o_read<=7)begin
						o_data<=out; 
						o_read<=o_read+1;
					end
					else begin
                o_done <= 1'b1;
                blk_cnt <= 0;
					 j<=0;cnt<=0;
					 end
            end
            endcase
        end
     end
endmodule