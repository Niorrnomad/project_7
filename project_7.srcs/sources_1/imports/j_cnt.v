`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:58:14 09/03/2025 
// Design Name: 
// Module Name:    j_cnt 
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
module j_cnt(
input wire i_clk,j_en,i_clr,i_rst_n,
output reg [7:0] i_val);
reg [7:0] j;
     always @(posedge i_clk) begin
	  if(!i_rst_n)begin 
	    j<=0;
	  end else if (i_clr) begin
	    j<=0;
	  end else if (j_en) begin
	    if (j<8'd63) j<=j+1; else j<=j; 
	  end else begin
	    j<=j;
	  end
	  i_val<=j;
end
endmodule
