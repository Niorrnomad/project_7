`timescale 1ns/1ps

module sd_card_model(
    input wire cs,
    input wire sclk,
    input wire mosi,
    output reg miso = 1'b1
);
    
    reg [7:0] memory [0:511];
    integer i;
    
    initial begin
        for (i = 0; i < 512; i = i + 1) begin
            memory[i] = 8'h00;
        end
        
        memory[0] = "H";
        memory[1] = "e";
        memory[2] = "l";
        memory[3] = "l";
        memory[4] = "o";
        memory[5] = 8'h0D;
        memory[6] = 8'h0A;
        memory[7] = "W";
        memory[8] = "o";
        memory[9] = "r";
        memory[10] = "l";
        memory[11] = "d";
        memory[12] = "!";
        memory[13] = 8'h0D;
        memory[14] = 8'h0A;
    end
    
    reg [47:0] current_cmd;
    integer bit_count = 0;
    integer response_delay = 0;
    integer data_delay = 0;
    integer byte_num = 0;
    integer bit_num = 0;
    
    always @(negedge sclk or posedge cs) begin
        if (cs) begin
            bit_count <= 0;
            miso <= 1'b1;
            response_delay <= 0;
            data_delay <= 0;
        end else begin
            if (bit_count < 48) begin
                current_cmd <= {current_cmd[46:0], mosi};
                bit_count <= bit_count + 1;
                
                if (bit_count == 47 && current_cmd[46:39] == 8'h51) begin
                    response_delay <= 8;
                end
            end else if (response_delay > 0) begin
                response_delay <= response_delay - 1;
                if (response_delay == 8) begin
                    miso <= 1'b0;
                end else if (response_delay < 8) begin
                    miso <= (response_delay == 1) ? 1'b0 : 1'b1;
                end
                
                if (response_delay == 1) begin
                    data_delay <= 100;
                end
            end else if (data_delay > 0) begin
                data_delay <= data_delay - 1;
                if (data_delay == 1) begin
                    miso <= 1'b0;
                    byte_num <= 0;
                    bit_num <= 7;
                end
            end else begin
                miso <= memory[byte_num][bit_num];
                if (bit_num == 0) begin
                    bit_num <= 7;
                    byte_num <= byte_num + 1;
                end else begin
                    bit_num <= bit_num - 1;
                end
            end
        end
    end
endmodule