`timescale 1ns/1ps
module W (
  input  wire [511:0] M,   
  input  wire [5:0]   j,  
  output wire [31:0]  W
);
// Version 1.1 1 module SHA với 1 FSM, nên W là mạch combination => Tần số thấp
  function [31:0] sigma0(input [31:0] x);
    sigma0 = {x[6:0],   x[31:7]} ^
             {x[17:0],  x[31:18]} ^
             (x >> 3);
  endfunction

  function [31:0] sigma1(input [31:0] x);
    sigma1 = {x[16:0],  x[31:17]} ^
             {x[18:0],  x[31:19]} ^
             (x >> 10);
  endfunction

  // Extract M words
  wire [31:0] Mword [0:15];
  genvar k;
  generate
    for (k = 0; k < 16; k = k + 1) begin
      assign Mword[k] = M[511 - k*32 -: 32];
    end
  endgenerate
  
  integer t;
  reg [31:0] wtmp [0:63];
  reg [31:0] Wreg;
  always @(*) begin
    if (j < 16)
      Wreg = Mword[j];
    else begin
      //0..15
      for (t = 0; t < 16; t = t + 1)
        wtmp[t] = Mword[t];
      //
      for (t = 16; t <= j; t = t + 1) begin
        wtmp[t] = wtmp[t-16]
                + sigma0(wtmp[t-15])
                + wtmp[t-7]
                + sigma1(wtmp[t-2]);
      end
      Wreg = wtmp[j];
    end
  end

  assign W = Wreg;

endmodule
