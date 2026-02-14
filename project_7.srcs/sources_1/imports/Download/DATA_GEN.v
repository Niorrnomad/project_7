module DATA_GEN #(
    parameter [7:0] N0 = 8'd0,
    parameter [7:0] N1 = 8'd2,
    parameter [7:0] N2 = 8'd3,
    parameter [7:0] N3 = 8'd4
)(
    input  wire        i_clk,
    input  wire        i_rstn,
    input  wire [1:0]  i_sel_data,
    input  wire        i_start_d,    
    input  wire        i_done,  
    output reg         o_done_all,
    output reg  [7:0]  o_N,
    output reg [511:0] o_data,
    output reg         o_data_valid
);

    localparam IDLE = 2'd0, SEND = 2'd1, WAIT = 2'd2;
    reg [1:0]  state;
    reg [7:0]  blk_cnt;
    reg first_done_ignore; 

    reg [511:0] rom0 [0:N0-1], rom1 [0:N1-1],
                rom2 [0:N2-1], rom3 [0:N3-1];
    initial begin
        $readmemh("file0.txt", rom0);
        $readmemh("file1.txt", rom1);
        $readmemh("file2.txt", rom2);
        $readmemh("file3.txt", rom3);
    end

    always @(posedge i_clk or posedge i_rstn) begin
        if (i_rstn) begin
            state             <= IDLE;
            blk_cnt           <= 8'd0;
            o_N               <= N0;
            o_data            <= {512{1'b0}};
            o_data_valid      <= 1'b0;
            o_done_all        <= 1'b0;
            first_done_ignore <= 1'b0;
        end else begin
            case (i_sel_data)
                2'd0: o_N <= N0;
                2'd1: o_N <= N1;
                2'd2: o_N <= N2;
                2'd3: o_N <= N3;
            endcase

            case (state)
                IDLE: begin
                    o_data_valid <= 1'b0;
                    if (i_start_d) begin
                        blk_cnt           <= 8'd0;      
                        o_done_all        <= 1'b0;      
                        first_done_ignore <= 1'b1; 
                        state             <= SEND;
                    end
                end

                SEND: begin
                    o_data_valid <= 1'b1;
                    case (i_sel_data)
                        2'd0: o_data <= rom0[blk_cnt];
                        2'd1: o_data <= rom1[blk_cnt];
                        2'd2: o_data <= rom2[blk_cnt];
                        2'd3: o_data <= rom3[blk_cnt];
                    endcase
                    state <= WAIT;
                end

                WAIT: begin
                    o_data_valid <= 1'b0;
                    if (i_done) begin
                        if (first_done_ignore) begin
                            first_done_ignore <= 1'b0;
                        end else begin
                            if (blk_cnt < o_N - 1) begin
                                blk_cnt <= blk_cnt + 8'd1;
                                state   <= SEND;
                            end else begin
                                o_done_all <= 1'b1; 
                                state      <= IDLE;
                            end
                        end
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

    // Debug state
    reg [80:0] state_str;  
    always @(*) begin
        case(state)
            IDLE: state_str = "IDLE      ";
            SEND: state_str = "SEND      ";
            WAIT: state_str = "WAIT      ";
            default: state_str = "UNKNOWN   ";
        endcase
    end
endmodule
