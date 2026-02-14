module TOP (
    input  wire         i_clk,
    input  wire         i_rstn,        
    input  wire [1:0]   i_sel_data,     
    input  wire         i_start,        

    output wire         o_done_all,     
    output wire [255:0] o_final_hash,   

    output wire [4:0]   led_out
);

    wire [511:0] w_data_block;
    wire [7:0]   w_N_blocks;
    wire         w_data_valid;
    wire         w_core_done;
    wire [255:0] w_final_hash;
    wire         start_pulse;
    wire         done_all;
    wire         w_start;
    wire [1:0]   w_sel_data;

    reg  [3:0]   sel_led;
	 reg			  rst_module;
    reg          start_d;
	 
	 localparam IDLE = 2'd0;
    localparam CMD  = 2'd1;
    localparam DATA = 2'd2;
    localparam HASH = 2'd3;
    reg[1:0] state, next_state;

    always @(posedge i_clk or posedge i_rstn) begin
        if (i_rstn)
            start_d <= 1'b0;
        else
            start_d <= i_start;
    end
    assign start_pulse = i_start & ~start_d;

    always @(posedge i_clk or posedge i_rstn) begin
        if (i_rstn)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: if (i_sel_data != 2'd0)     next_state = CMD;
            CMD:  if (w_start)        			 next_state = DATA;
            DATA: if (w_data_valid)   			 next_state = HASH;
            HASH: if (done_all)      			 next_state = IDLE;
            default:                  			 next_state = IDLE;
        endcase
    end

    always @(posedge i_clk or posedge i_rstn) begin
        if (i_rstn) begin
            rst_module   <= 1'b1;
        end
        else begin
            case (state)
                IDLE: begin
                    rst_module <= 1'b1;
                end
					 CMD: begin
						  rst_module <= 1'b0;
					 end
					 DATA: begin
					     rst_module <= 1'b0;
					 end
                HASH: begin
                    rst_module <= 1'b0;
                end
                default: begin
                    rst_module <= 1'b0;
                end
            endcase
        end
    end
	 
    //LED========================
    always @(posedge i_clk or posedge i_rstn) begin
        if (i_rstn) begin
            sel_led <= 4'b0000;
        end else begin
            case (i_sel_data)
                2'd0: sel_led <= 4'b0001;  
                2'd1: sel_led <= 4'b0011;  
                2'd2: sel_led <= 4'b0111;  
                2'd3: sel_led <= 4'b1111;  
                default: sel_led <= 4'b0000;
            endcase
        end
    end
	 assign led_out = {sel_led, o_done_all};

    assign o_final_hash = (o_done_all) ? w_final_hash : 256'd0;

    CMD_GEN u_cmd_gen (
        .i_clk        (i_clk),
        .i_rst        (i_rstn),
        .i_start      (start_pulse),
        .i_done_all   (done_all),
        .i_sel_data   (i_sel_data),
        .o_done_all   (o_done_all),
        .o_start      (w_start),
        .o_sel_data   (w_sel_data)
    );

    DATA_GEN u_data_gen (
        .i_clk        (i_clk),
        .i_rstn       (rst_module),
        .i_sel_data   (i_sel_data),
        .i_start_d    (w_start),
        .i_done       (w_core_done), 
        .o_data       (w_data_block), 
        .o_N          (w_N_blocks),
        .o_done_all   (done_all),
        .o_data_valid (w_data_valid)
    );

    sha u_sha (
        .i_clk      (i_clk),
        .i_rstn     (rst_module),
        .i_enable   (w_data_valid),
        .i_N        (w_N_blocks),
        .i_data     (w_data_block),
        .o_done     (w_core_done),
        .o_hash     (w_final_hash)
    );
	//Display cac state
	reg [80:0] state_str;  
	always @(*) begin
	  case(state)
		 2'd0: state_str = "IDLE    ";
		 2'd1: state_str = "CMD     ";
		 2'd2: state_str = "DATA    ";
		 2'd3: state_str = "HASH    ";
		 default: state_str = "UNKNOWN ";
	  endcase
	end
endmodule
