`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:04:25 09/03/2025 
// Design Name: 
// Module Name:    w_cnt 
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
module w_cnt(
input wire i_clk,cnt_en,i_clr,i_rst_n,
output reg [7:0] i_val);
reg [7:0] w;
     always @(posedge i_clk) begin
	  if(!i_rst_n)begin 
	    w<=0;
	  end else if (i_clr) begin
	    w<=0;
	  end else if (cnt_en) begin
	    if (w<8'd63) w<=w+1; else w<=w; 
	  end else begin
	    w<=w;
	  end
	  i_val<=w;
end
endmodule
