`timescale 1ns / 1ps
module K (
  input  wire [5:0]  round,   // 0..63
  output wire [31:0] K_out
);

  // ROM ch?a 64 h?ng s? SHA-256
  reg [31:0] Kmem [0:63];
  initial begin
    Kmem[ 0] = 32'h428a2f98; Kmem[ 1] = 32'h71374491;
    Kmem[ 2] = 32'hb5c0fbcf; Kmem[ 3] = 32'he9b5dba5;
    Kmem[ 4] = 32'h3956c25b; Kmem[ 5] = 32'h59f111f1;
    Kmem[ 6] = 32'h923f82a4; Kmem[ 7] = 32'hab1c5ed5;
    Kmem[ 8] = 32'hd807aa98; Kmem[ 9] = 32'h12835b01;
    Kmem[10] = 32'h243185be; Kmem[11] = 32'h550c7dc3;
    Kmem[12] = 32'h72be5d74; Kmem[13] = 32'h80deb1fe;
    Kmem[14] = 32'h9bdc06a7; Kmem[15] = 32'hc19bf174;
    Kmem[16] = 32'he49b69c1; Kmem[17] = 32'hefbe4786;
    Kmem[18] = 32'h0fc19dc6; Kmem[19] = 32'h240ca1cc;
    Kmem[20] = 32'h2de92c6f; Kmem[21] = 32'h4a7484aa;
    Kmem[22] = 32'h5cb0a9dc; Kmem[23] = 32'h76f988da;
    Kmem[24] = 32'h983e5152; Kmem[25] = 32'ha831c66d;
    Kmem[26] = 32'hb00327c8; Kmem[27] = 32'hbf597fc7;
    Kmem[28] = 32'hc6e00bf3; Kmem[29] = 32'hd5a79147;
    Kmem[30] = 32'h06ca6351; Kmem[31] = 32'h14292967;
    Kmem[32] = 32'h27b70a85; Kmem[33] = 32'h2e1b2138;
    Kmem[34] = 32'h4d2c6dfc; Kmem[35] = 32'h53380d13;
    Kmem[36] = 32'h650a7354; Kmem[37] = 32'h766a0abb;
    Kmem[38] = 32'h81c2c92e; Kmem[39] = 32'h92722c85;
    Kmem[40] = 32'ha2bfe8a1; Kmem[41] = 32'ha81a664b;
    Kmem[42] = 32'hc24b8b70; Kmem[43] = 32'hc76c51a3;
    Kmem[44] = 32'hd192e819; Kmem[45] = 32'hd6990624;
    Kmem[46] = 32'hf40e3585; Kmem[47] = 32'h106aa070;
    Kmem[48] = 32'h19a4c116; Kmem[49] = 32'h1e376c08;
    Kmem[50] = 32'h2748774c; Kmem[51] = 32'h34b0bcb5;
    Kmem[52] = 32'h391c0cb3; Kmem[53] = 32'h4ed8aa4a;
    Kmem[54] = 32'h5b9cca4f; Kmem[55] = 32'h682e6ff3;
    Kmem[56] = 32'h748f82ee; Kmem[57] = 32'h78a5636f;
    Kmem[58] = 32'h84c87814; Kmem[59] = 32'h8cc70208;
    Kmem[60] = 32'h90befffa; Kmem[61] = 32'ha4506ceb;
    Kmem[62] = 32'hbef9a3f7; Kmem[63] = 32'hc67178f2;
  end

assign K_out = Kmem[round];

endmodule
