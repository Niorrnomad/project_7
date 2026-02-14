`timescale 1ns / 1ps
module sha(
    input  wire         i_clk,
    input  wire         i_rstn,
    input  wire         i_enable,
    input  wire [7:0]   i_N,
    input  wire [511:0] i_data,
    output reg          o_done,
    output reg [255:0]  o_hash
);

    //FSM 
    localparam IDLE     = 2'd0;
    localparam INIT     = 2'd1;
    localparam COMPRESS = 2'd2;
    localparam FINISH   = 2'd3;
	 
    reg [1:0]  state, next_state;
    reg [5:0]  j;
    reg [7:0]  blk_cnt;
    reg        cnt_j_en, clr_j;
    reg        cnt_i_en, clr_i;
	 reg [31:0] a,b,c,d,e,f,g,h;
    reg [31:0] H0,H1,H2,H3,H4,H5,H6,H7;


    wire [31:0] W;
    wire [31:0] K_val;
    wire [31:0] newH0, newH1, newH2, newH3, newH4, newH5, newH6, newH7;
    wire [255:0] final_hash;
	 
    K u_K (.round(j), .K_out(K_val));
    hash u_hash (
      .H0(H0), .H1(H1), .H2(H2), .H3(H3),
      .H4(H4), .H5(H5), .H6(H6), .H7(H7),
      .a(a), .b(b), .c(c), .d(d),
      .e(e), .f(f), .g(g), .h(h),
      .newH0(newH0), .newH1(newH1), .newH2(newH2), .newH3(newH3),
      .newH4(newH4), .newH5(newH5), .newH6(newH6), .newH7(newH7),
      .o_hash(final_hash)
    );
	 	 
	 wire w_valid = (next_state == INIT);
	 W w (
		  .M (i_data),
		  .j (j),
		  .W (W)
	 );

    always @(posedge i_clk or posedge i_rstn) begin
        if (i_rstn)      j <= 6'd0;
        else if (clr_j)   j <= 6'd0;
        else if (cnt_j_en) j <= j + 6'd1;
    end
    wire done_round = (j == 6'd63) && cnt_j_en;

    always @(posedge i_clk or posedge i_rstn) begin
        if (i_rstn)       blk_cnt <= 8'd0;
        else if (clr_i)    blk_cnt <= 8'd0;
        else if (cnt_i_en) blk_cnt <= blk_cnt + 8'd1;
    end
    wire last_block = (blk_cnt == i_N-1) && cnt_i_en;

    always @(*) begin
        next_state = state;
        cnt_j_en   = 1'b0;
        clr_j      = 1'b0;
        cnt_i_en   = 1'b0;
        clr_i      = 1'b0;
		  o_done     = 1'b0;
        case (state)
          IDLE: begin
				o_done = 1'b1;
            if (i_enable) next_state = INIT;
            clr_j = 1'b1;
            clr_i = 1'b1;
          end
          INIT: begin
            next_state = COMPRESS;
				o_done = 1'b0;
            clr_j = 1'b1;
          end
          COMPRESS: begin
					cnt_j_en = 1'b1;
            if (done_round) begin
				   o_done = 1'b1;
					next_state = FINISH;
				end
          end
          FINISH: begin
			   o_done = 1'b0;
            cnt_i_en = 1'b1;
            clr_j    = 1'b1;
            if (last_block) next_state = IDLE;
            else            next_state = INIT;
          end
        endcase
    end

    //hash process
    always @(posedge i_clk or posedge i_rstn) begin
        if (i_rstn) begin
            state  <= IDLE;
            o_hash <= 256'd0;
            H0 <= 32'h6a09e667; H1 <= 32'hbb67ae85;
            H2 <= 32'h3c6ef372; H3 <= 32'ha54ff53a;
            H4 <= 32'h510e527f; H5 <= 32'h9b05688c;
            H6 <= 32'h1f83d9ab; H7 <= 32'h5be0cd19;
        end else begin
            state <= next_state;
            case (state)
              IDLE: begin
                {a,b,c,d,e,f,g,h} <= {H0,H1,H2,H3,H4,H5,H6,H7};
              end
              INIT: begin
                {a,b,c,d,e,f,g,h} <= {H0,H1,H2,H3,H4,H5,H6,H7};
              end
              COMPRESS: begin
                h <= g;
                g <= f;
                f <= e;
                e <= d + T1(a,e,W,K_val);
                d <= c;
                c <= b;
                b <= a;
                a <= T1(a,e,W,K_val) + T2(a,b,c);
              end
              FINISH: begin
                {H0,H1,H2,H3,H4,H5,H6,H7} <= {newH0,newH1,newH2,newH3,newH4,newH5,newH6,newH7};
                o_hash <= final_hash;
              end
            endcase
        end
    end
	 
    function [31:0] ROTR;
        input [31:0] x;
        input [4:0]  n;
        ROTR = (x >> n) | (x << (32-n));
    endfunction

    function [31:0] Sigma0;
        input [31:0] x;
        begin
            Sigma0 = ROTR(x, 2) ^ ROTR(x,13) ^ ROTR(x,22);
        end
    endfunction

    function [31:0] Sigma1;
        input [31:0] x;
        begin
            Sigma1 = ROTR(x, 6) ^ ROTR(x,11) ^ ROTR(x,25);
        end
    endfunction

    function [31:0] Ch;
        input [31:0] x,y,z;
        begin
            Ch = (x & y) ^ (~x & z);
        end
    endfunction

    function [31:0] Maj;
        input [31:0] x,y,z;
        begin
            Maj = (x & y) ^ (x & z) ^ (y & z);
        end
    endfunction

    function [31:0] T1;
        input [31:0] a,e,w,k;
        begin
            T1 = h + Sigma1(e) + Ch(e,f,g) + k + w;
        end
    endfunction

    function [31:0] T2;
        input [31:0] a,b,c;
        begin
            T2 = Sigma0(a) + Maj(a,b,c);
        end
    endfunction
	 
	//Display cac state
	reg [80:0] state_str;  
	always @(*) begin
	  case(state)
		 2'd0: state_str = "IDLE    ";
		 2'd1: state_str = "INIT    ";
		 2'd2: state_str = "COMPRESS";
		 2'd3: state_str = "FINISH  ";
		 default: state_str = "UNKNOWN ";
	  endcase
	end
endmodule
