`timescale 1ns/1ps

module sd_card_text_reader (
    input wire clk,
    input wire reset,
    // SD Card Interface
    output reg sd_cs,
    output wire sd_clk,
    output reg sd_mosi,
    input wire sd_miso,
    // Text output interface
    output reg [7:0] char_out,
    output reg char_valid,
    output reg file_read_complete,
    output reg [31:0] file_size
);

    // States
    parameter IDLE = 0;
    parameter INIT_SD = 1;
    parameter OPEN_FILE = 2;
    parameter READ_BLOCK = 3;
    parameter PROCESS_DATA = 4;
    parameter DONE = 5;
    
    reg [2:0] state = IDLE;
    reg [31:0] block_addr = 0;
    reg [31:0] bytes_remaining = 0;
    reg [8:0] data_counter = 0;
    
    // Controller command registers
    reg [47:0] cmd_reg = 0;
    reg cmd_start_reg = 0;
    reg data_start_reg = 0;
    
    // SD Controller
    wire cmd_busy;
    wire [7:0] cmd_response;
    wire [7:0] data_out;
    wire data_valid;
    
    sd_card_controller controller (
        .clk(clk),
        .reset(reset),
        .sd_cs(),          // Leave unconnected - we drive directly
        .sd_clk(sd_clk),
        .sd_mosi(),        // Leave unconnected - we drive directly
        .sd_miso(sd_miso),
        .cmd(cmd_reg),
        .cmd_start(cmd_start_reg),
        .cmd_busy(cmd_busy),
        .cmd_response(cmd_response),
        .data_in(8'd0),
        .data_out(data_out),
        .data_start(data_start_reg),
        .data_busy(),
        .data_valid(data_valid),
        .data_size(9'd512)
    );
    
    // State machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            char_out <= 0;
            char_valid <= 0;
            file_read_complete <= 0;
            cmd_reg <= 0;
            cmd_start_reg <= 0;
            data_start_reg <= 0;
            sd_cs <= 1'b1;
            sd_mosi <= 1'b1;
        end else begin
            char_valid <= 0;
            cmd_start_reg <= 0;
            data_start_reg <= 0;
            
            case (state)
                IDLE: begin
                    state <= INIT_SD;
                    file_read_complete <= 0;
                end
                
                INIT_SD: begin
                    state <= OPEN_FILE;
                end
                
                OPEN_FILE: begin
                    block_addr <= 32'h00010000;
                    bytes_remaining <= 1024;
                    file_size <= 1024;
                    state <= READ_BLOCK;
                end
                
                READ_BLOCK: begin
                    if (!cmd_busy) begin
                        cmd_reg <= {16'h5100, block_addr[31:16], block_addr[15:0]};
                        cmd_start_reg <= 1'b1;
                        data_start_reg <= 1'b1;
                        data_counter <= 0;
                        state <= PROCESS_DATA;
                        block_addr <= block_addr + 512;
                        bytes_remaining <= bytes_remaining - 512;
                        sd_cs <= 1'b0;
                    end
                end
                
                PROCESS_DATA: begin
                    if (data_valid) begin
                        char_out <= data_out;
                        char_valid <= 1'b1;
                        data_counter <= data_counter + 1;
                        
                        if (data_counter == 511 || bytes_remaining == 0) begin
                            sd_cs <= 1'b1;
                            if (bytes_remaining == 0) begin
                                state <= DONE;
                            end else begin
                                state <= READ_BLOCK;
                            end
                        end
                    end
                end
                
                DONE: begin
                    file_read_complete <= 1'b1;
                    state <= DONE;
                end
            endcase
        end
    end
endmodule
