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
input wire [511:0] i_data,
input wire [7:0] i_n,
output reg o_done,
output reg [255:0] o_data
    );
	 parameter IDLE=2'b00, INIT=2'b01,COMPRESS=2'b10,DONE=2'b11;
	 reg [31:0] a,b,c,d,e,f,g,h,H0,H1,H2,H3,H4,H5,H6,H7;
	 reg [7:0] blk_cnt;
	 reg [31:0] w [0:63];
	 reg done_round,last_block;
	 reg [6:0] j;
	 reg [6:0] cnt;
	 reg [31:0] k;
	 reg [1:0] state;
	 reg [1:0] next_state;
                function rotr;
                    input [31:0] x;
                    input [4:0] y;
                begin 
                rotr=(x>>y)|(x<<(32-y));
                end 
                endfunction
                function sigma0;
                input [31:0]x;
                begin 
                sigma0=rotr(x,2)^rotr(x,13)^rotr(x,22);
                end
                endfunction
                    function sigma1;
                input [31:0]x;
                begin 
                sigma1=rotr(x,6)^rotr(x,11)^rotr(x,25);
                end
                endfunction
                function o0;
                input [31:0]x;
                begin 
                o0=rotr(x,7)^rotr(x,18)^(x>>3);
                end endfunction
                function o1;
                input [31:0]x;
                begin 
                o1=rotr(x,17)^rotr(x,19)^(x>>10);
                end 
                endfunction
                function ch;
                input [31:0] x,y,z;
                begin 
                ch=(x&y)^(~x&z);
                end endfunction
                function maj;
                input [31:0] x,y,z;
                begin 
                maj=(x&y)^(x&z)^(y&z);
                end 
                endfunction
    	 	wire [31:0] geng1=h+sigma1(e)+ch(e,f,g)+k+w[j];

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
	 IDLE: begin
            if (i_enable || (blk_cnt != 8'd0 && blk_cnt < i_n)) begin
                next_state = INIT;
            end
            else begin
                next_state = IDLE;
            end
        end
		INIT: next_state = (cnt == 7'd63) ? COMPRESS : INIT;
        COMPRESS:if (done_round) begin
                if (blk_cnt == i_n - 1) begin
                next_state=DONE;
                end
                else begin
                next_state=IDLE;
                end
                end
                else begin
                    next_state=COMPRESS; 
                    end
        DONE: next_state=DONE;
        default: next_state=IDLE;
     endcase
     end
     always @(posedge i_clk or negedge i_rst_n) begin
        if(!i_rst_n)begin 
            state <= IDLE;
            j<=0;
            o_done<=0;
            o_data<=0;
            blk_cnt<=0;
            last_block<=0;
            cnt <= 0;
            H0 <= 32'h0; H1 <= 32'h0; H2 <= 32'h0; H3 <= 32'h0;
            H4 <= 32'h0; H5 <= 32'h0; H6 <= 32'h0; H7 <= 32'h0;
            a<=0;b<=0;c<=0;d<=0;e<=0;f<=0;g<=0;h<=0;
        end
        else begin
            state <= next_state;
            case (state)
            IDLE: begin
                o_done<=0;
                done_round<=0;
                if (i_enable|| (blk_cnt != 8'd0 && blk_cnt < i_n))begin
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
                last_block<=(blk_cnt == i_n-1);
                cnt<=0;
                j<=0;
                end
            end
            INIT: begin
        o_done<=0;
        done_round<=0;
        if (cnt < 7'd16) begin
        w[cnt] <= i_data[511 - cnt*32 -: 32];
        end
        else begin
        w[cnt] <= o1(w[cnt-2]) + w[cnt-7] + o0(w[cnt-15]) + w[cnt-16];
        end
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
        end
            end
        COMPRESS: begin
            if (!done_round) begin
    // sửa off-by-one: không cho j vượt 63, chốt done_round ngay sau round 63
    if (j < 7'd63) begin
    a<=geng1+g2;
    b<=a;
    c<=b;
    d<=c;
    e<=d+geng1;
       f<=e;
    g<=f;
    h<=g;
       j<=j+1;
    end else begin
    a<=geng1+g2;
    b<=a;
    c<=b;
    d<=c;
    e<=d+geng1;
       f<=e;
    g<=f;
    h<=g;
       done_round<=1'b1;
    end
            end
            else begin
                H0<=H0+a;
                H1<=H1+b;
                H2<=H2+c;
                H3<=H3+d;
                H4<=H4+e;
                H5<=H5+f;
                H6<=H6+g;
                H7<=H7+h;
                if (!last_block) begin
                blk_cnt <= blk_cnt + 1;
                end
                done_round <= 1'b0;
                j<=6'h00;
            end
        end
        DONE: begin
                o_data<={H0,H1,H2,H3,H4,H5,H6,H7};
                o_done <= 1'b1;
                blk_cnt <= 0;
                end
            endcase
        end
     end
endmodule
