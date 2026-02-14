`timescale 1ns/1ps
module hash(
  input  wire [31:0] H0, H1, H2, H3,
  input  wire [31:0] H4, H5, H6, H7,
  input  wire [31:0] a,  b,  c,  d,
  input  wire [31:0] e,  f,  g,  h,
  output wire [31:0] newH0, newH1, newH2, newH3,
  output wire [31:0] newH4, newH5, newH6, newH7,
  output wire [255:0] o_hash
);

  // C?ng luôn combinational
  assign newH0 = H0 + a;
  assign newH1 = H1 + b;
  assign newH2 = H2 + c;
  assign newH3 = H3 + d;
  assign newH4 = H4 + e;
  assign newH5 = H5 + f;
  assign newH6 = H6 + g;
  assign newH7 = H7 + h;

  // Xâu l?i thành 256-bit hash
  assign o_hash = { newH0, newH1, newH2, newH3,
                    newH4, newH5, newH6, newH7 };

endmodule
