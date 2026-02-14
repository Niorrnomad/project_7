`timescale 1ns/1ps

module sd_card_system_tb();

    // Clock and reset
    reg clk = 0;
    reg reset = 1;
    
    // SD Card Interface
    wire sd_cs;
    wire sd_clk;
    wire sd_mosi;
    wire sd_miso;
    
    // Text reader outputs
    wire [7:0] char_out;
    wire char_valid;
    wire file_read_complete;
    wire [31:0] file_size;
    
    // Instantiate DUT
    sd_card_text_reader dut (
        .clk(clk),
        .reset(reset),
        .sd_cs(sd_cs),
        .sd_clk(sd_clk),
        .sd_mosi(sd_mosi),
        .sd_miso(sd_miso),
        .char_out(char_out),
        .char_valid(char_valid),
        .file_read_complete(file_read_complete),
        .file_size(file_size)
    );
    
    // SD Card Model
    sd_card_model sd_card (
        .cs(sd_cs),
        .sclk(sd_clk),
        .mosi(sd_mosi),
        .miso(sd_miso)
    );
    
    // Clock generation (50MHz)
    always #10 clk = ~clk;
    
    // Test sequence
    initial begin
        reset = 1;
        #100;
        reset = 0;
        
        wait(file_read_complete);
        #100;
        
        $display("SD Card Read Simulation Complete");
        $finish;
    end
    
    // Display text output
    always @(posedge clk) begin
        if (char_valid) begin
            $write("%c", char_out);
            if (char_out == 8'h0A) $write("\n");
        end
    end
    
    // Timeout check
    initial begin
        #500000;
        $display("Error: Simulation timed out");
        $finish;
    end
endmodule