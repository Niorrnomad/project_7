`timescale 1ns/1ns 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:13 04/08/2011 
// Design Name: 
// Module Name:    keyram_256 
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
module keyram_128(clk,reset, we , addr, roundt,roundk );
		input clk, we,reset;
		input [127:0] roundt;		
		input [3:0] addr;
		output [127:0] roundk;
		
			
blk_mem_gen_v4_3 u1(.clka(clk),.rsta(reset), .wea(we), .addra(addr), .dina(roundt), .douta(roundk));
endmodule

