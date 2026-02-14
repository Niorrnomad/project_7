module sha256_tb;

    reg i_clk;
    reg i_rst_n;
    reg i_enable;
    reg [31:0] i_data; 
    reg [7:0] i_n;
    wire o_done;
    wire [255:0] o_data;
	 reg [8:0] i_miss;
	 wire [2:0] o_read;

    sha256 uut (
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_enable(i_enable),
        .i_data(i_data),
        .i_n(i_n),
        .o_done(o_done),
        .o_data(o_data),
		  .i_miss(i_miss),
		  .o_read(o_read)
    );

    always #5 i_clk = ~i_clk;
    reg [31:0] block_mem [0:3][0:15]; 
    integer blk_count;
    integer i, j;

    initial begin
        $display("Starting SHA-256 testbench...");

        i_clk = 0;
        i_rst_n = 0;
        i_enable = 0;
        i_data = 0;
        i_n = 4; 
       
		  block_mem[0][0] = 32'h61000000;
		  block_mem[0][1] = 32'h00000000;
		  block_mem[0][2] = 32'h00000000;
		  block_mem[0][3] = 32'h00000000;
		  block_mem[0][4] = 32'h00000000;
		  block_mem[0][5] = 32'h00000000;
		  block_mem[0][6] = 32'h00000000;
		  block_mem[0][7] = 32'h00000000;
		  block_mem[0][8] = 32'h00000000;
		  block_mem[0][9] = 32'h00000000;
		  block_mem[0][10] = 32'h00000000;
		  block_mem[0][11] = 32'h00000000;
		  block_mem[0][12] = 32'h00000000;
		  block_mem[0][13] = 32'h00000000;
		  block_mem[0][14] = 32'h00000000;
		  block_mem[0][15] = 32'h00000000;
        
          block_mem[1][0] = 32'h62000000;
		  block_mem[1][1] = 32'h00000000;
		  block_mem[1][2] = 32'h00000000;
		  block_mem[1][3] = 32'h00000000;
		  block_mem[1][4] = 32'h00000000;
		  block_mem[1][5] = 32'h00000000;
		  block_mem[1][6] = 32'h00000000;
		  block_mem[1][7] = 32'h00000000;
		  block_mem[1][8] = 32'h00000000;
		  block_mem[1][9] = 32'h00000000;
		  block_mem[1][10] = 32'h00000000;
		  block_mem[1][11] = 32'h00000000;
		  block_mem[1][12] = 32'h00000000;
		  block_mem[1][13] = 32'h00000000;
		  block_mem[1][14] = 32'h00000000;
		  block_mem[1][15] = 32'h00000000;
        
          block_mem[2][0] = 32'h63000000;
		  block_mem[2][1] = 32'h00000000;
		  block_mem[2][2] = 32'h00000000;
		  block_mem[2][3] = 32'h00000000;
		  block_mem[2][4] = 32'h00000000;
		  block_mem[2][5] = 32'h00000000;
		  block_mem[2][6] = 32'h00000000;
		  block_mem[2][7] = 32'h00000000;
		  block_mem[2][8] = 32'h00000000;
		  block_mem[2][9] = 32'h00000000;
		  block_mem[2][10] = 32'h00000000;
		  block_mem[2][11] = 32'h00000000;
		  block_mem[2][12] = 32'h00000000;
		  block_mem[2][13] = 32'h00000000;
		  block_mem[2][14] = 32'h00000000;
		  block_mem[2][15] = 32'h00000000;


          block_mem[3][0] = 32'h64000000;
		  block_mem[3][1] = 32'h00000000;
		  block_mem[3][2] = 32'h00000000;
		  block_mem[3][3] = 32'h00000000;
		  block_mem[3][4] = 32'h00000000;
		  block_mem[3][5] = 32'h00000000;
		  block_mem[3][6] = 32'h00000000;
		  block_mem[3][7] = 32'h00000000;
		  block_mem[3][8] = 32'h00000000;
		  block_mem[3][9] = 32'h00000000;
		  block_mem[3][10] = 32'h00000000;
		  block_mem[3][11] = 32'h00000000;
		  block_mem[3][12] = 32'h00000000;
		//   block_mem[3][13] = 32'h00000000;
		//   block_mem[3][14] = 32'h00000000;
		//   block_mem[3][15] = 32'h00000000;
			// block_mem[0][0]  = 32'h5348412d;
			// block_mem[0][1]  = 32'h32353620;
			// block_mem[0][2]  = 32'h69732061;
			// block_mem[0][3]  = 32'h20637279;
			// block_mem[0][4]  = 32'h70746f67;
			// block_mem[0][5]  = 32'h72617068;
			// block_mem[0][6]  = 32'h69632068;
			// block_mem[0][7]  = 32'h61736820;
			// block_mem[0][8]  = 32'h66756e63;
			// block_mem[0][9]  = 32'h74696f6e;
			// block_mem[0][10] = 32'h20746861;
			// block_mem[0][11] = 32'h74206765;
			// block_mem[0][12] = 32'h6e657261;
			// block_mem[0][13] = 32'h74657320;
			// block_mem[0][14] = 32'h00000000;
			// block_mem[0][15] = 32'h00000000;

        #20;
        i_rst_n = 1;
        
        i_enable = 1;  
		  i_miss=96;
        @(posedge i_clk);
        for (blk_count=0;blk_count <4; blk_count = blk_count + 1) begin
            for (j = 0; j < 16; j = j + 1) begin  
                i_data = block_mem[blk_count][j];
                @(posedge i_clk); 
            end
				wait(uut.ct1);
	        @(posedge i_clk);
			  i_enable = 1;  

				
        end
        
        wait(o_done);
        $display("SHA-256 output hash: %064x", o_data);

        #40;

        $display("SHA-256 testbench finished.");
        $stop;
    end

endmodule
