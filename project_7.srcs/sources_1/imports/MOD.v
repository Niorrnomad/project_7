`timescale 1ns/1ps

module sd_card_controller (
    input wire clk,
    input wire reset,
    // SD Card Interface (SPI mode)
    output wire sd_cs,    // Changed to wire
    output wire sd_clk,
    output wire sd_mosi,  // Changed to wire
    input wire sd_miso,
    // Command interface
    input wire [47:0] cmd,
    input wire cmd_start,
    output wire cmd_busy,
    output wire [7:0] cmd_response,
    // Data interface
    input wire [7:0] data_in,
    output wire [7:0] data_out,
    input wire data_start,
    output wire data_busy,
    output wire data_valid,
    input wire [8:0] data_size
);

    // Internal registers
    reg sd_cs_reg = 1'b1;
    reg sd_mosi_reg = 1'b1;
    reg spi_clk = 0;
    
    // Continuous assignments
    assign sd_cs = sd_cs_reg;
    assign sd_mosi = sd_mosi_reg;
    assign sd_clk = spi_clk;

    // SPI clock generation (400kHz initial)
    reg [7:0] spi_divider = 124;
    reg [7:0] spi_counter = 0;
    
    always @(posedge clk) begin
        if (spi_counter == spi_divider) begin
            spi_counter <= 0;
            spi_clk <= ~spi_clk;
        end else begin
            spi_counter <= spi_counter + 1;
        end
    end
    
    // Command state machine
    parameter CMD_IDLE = 0;
    parameter CMD_SENDING = 1;
    parameter CMD_WAIT_RESP = 2;
    
    reg [1:0] cmd_state = CMD_IDLE;
    reg [47:0] cmd_shift;
    reg [5:0] cmd_bit_cnt;
    reg [7:0] resp_shift;
    
    assign cmd_busy = (cmd_state != CMD_IDLE);
    assign cmd_response = resp_shift;
    
    always @(posedge spi_clk or posedge reset) begin
        if (reset) begin
            cmd_state <= CMD_IDLE;
            sd_cs_reg <= 1'b1;
            sd_mosi_reg <= 1'b1;
        end else begin
            case (cmd_state)
                CMD_IDLE: begin
                    if (cmd_start) begin
                        cmd_shift <= cmd;
                        cmd_bit_cnt <= 47;
                        sd_cs_reg <= 1'b0;
                        cmd_state <= CMD_SENDING;
                    end
                end
                
                CMD_SENDING: begin
                    sd_mosi_reg <= cmd_shift[47];
                    cmd_shift <= {cmd_shift[46:0], 1'b1};
                    if (cmd_bit_cnt == 0) begin
                        cmd_state <= CMD_WAIT_RESP;
                    end else begin
                        cmd_bit_cnt <= cmd_bit_cnt - 1;
                    end
                end
                
                CMD_WAIT_RESP: begin
                    sd_mosi_reg <= 1'b1;
                    if (sd_miso == 1'b0) begin
                        resp_shift <= {resp_shift[6:0], sd_miso};
                        if (&resp_shift[6:0]) begin
                            sd_cs_reg <= 1'b1;
                            cmd_state <= CMD_IDLE;
                        end
                    end
                end
            endcase
        end
    end
    
    // Data receiver
    reg [7:0] data_shift;
    reg [3:0] data_bit_cnt;
    reg [8:0] data_byte_cnt;
    
    assign data_busy = (data_byte_cnt != 0);
    assign data_out = data_shift;
    assign data_valid = (data_bit_cnt == 0 && data_byte_cnt != 0);
    
    always @(posedge spi_clk or posedge reset) begin
        if (reset) begin
            data_byte_cnt <= 0;
        end else begin
            if (data_start) begin
                data_byte_cnt <= data_size;
                data_bit_cnt <= 7;
            end else if (data_byte_cnt != 0) begin
                data_shift <= {data_shift[6:0], sd_miso};
                if (data_bit_cnt == 0) begin
                    data_byte_cnt <= data_byte_cnt - 1;
                    data_bit_cnt <= 7;
                end else begin
                    data_bit_cnt <= data_bit_cnt - 1;
                end
            end
        end
    end
endmodule