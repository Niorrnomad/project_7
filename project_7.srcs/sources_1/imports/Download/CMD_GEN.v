`timescale 1ns / 1ps
module CMD_GEN (
    input  wire       i_clk,
    input  wire       i_rst,
    input  wire       i_start,   
    input  wire       i_done_all,   
    input  wire [1:0] i_sel_data,  
    output reg        o_done_all,   
    output reg        o_start,     
    output reg [1:0]  o_sel_data     
);

    parameter   IDLE    = 2'd0,
                CONNECT = 2'd1,
                WAIT    = 2'd2;

    reg [1:0] state;

    always @(posedge i_clk or posedge i_rst) begin
        if (i_rst) begin
            state      <= IDLE;
            o_done_all <= 1'b0;
            o_start    <= 1'b0;
            o_sel_data <= 2'd0;
        end else begin
            o_start    <= 1'b0; 
            o_done_all <= 1'b0; 

            case(state)
                IDLE: begin
                    if (i_start) begin
                        o_sel_data <= i_sel_data;
                        state      <= CONNECT;
                    end
                end
                CONNECT: begin
                    o_start <= 1'b1;
                    state   <= WAIT;
                end
                WAIT: begin
                    if (i_done_all) begin
                        o_done_all <= 1'b1; 
                        state      <= IDLE;
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
            CONNECT: state_str = "CONNECT   ";
            WAIT: state_str = "WAIT      ";
            default: state_str = "UNKNOWN   ";
        endcase
    end
endmodule
