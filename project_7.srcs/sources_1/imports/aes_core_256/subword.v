`timescale 1ns/1ns 
 
module subword (encDec, in_Sbox, out_Sbox); 
    input encDec; 
    input [31:0] in_Sbox; 
    output [31:0] out_Sbox; 
 
    subbytes subbytes0 (.encDec(encDec), .a(in_Sbox[7:0]), .d(out_Sbox[7:0])); 
 
    subbytes subbytes1 (.encDec(encDec), .a(in_Sbox[15:8]), .d(out_Sbox[15:8])); 
 
    subbytes subbytes2 (.encDec(encDec), .a(in_Sbox[23:16]), .d(out_Sbox[23:16])); 
 
    subbytes subbytes3 (.encDec(encDec), .a(in_Sbox[31:24]), .d(out_Sbox[31:24])); 
 
endmodule 