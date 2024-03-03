
typedef enum logic [3:0] {
    IN_0 = 4'h0,
    IN_1 = 4'h1,
    IN_2 = 4'h2,
    IN_3 = 4'h3,
    IN_4 = 4'h4,
    IN_5 = 4'h5,
    IN_6 = 4'h6,
    IN_7 = 4'h7,
    IN_8 = 4'h8,
    IN_9 = 4'h9,
    IN_A = 4'ha,
    IN_B = 4'hb,
    IN_C = 4'hc,
    IN_D = 4'hd,
    IN_E = 4'he,
    IN_F = 4'hf
} in_enum;


module gost89_sbox(
  input logic    [63:0] sbox,
  input logic  [3:0]  in,
  output logic [3:0]  out
);
  always_comb begin
    case (in)
        IN_0: out = sbox[63:60];
        IN_1: out = sbox[59:56];
        IN_2: out = sbox[55:52];
        IN_3: out = sbox[51:48];
        IN_4: out = sbox[47:44];
        IN_5: out = sbox[43:40];
        IN_6: out = sbox[39:36];
        IN_7: out = sbox[35:32];
        IN_8: out = sbox[31:28];
        IN_9: out = sbox[27:24];
        IN_A: out = sbox[23:20];
        IN_B: out = sbox[19:16];
        IN_C: out = sbox[15:12];
        IN_D: out = sbox[11:8];
        IN_E: out = sbox[7:4];
        IN_F: out = sbox[3:0];
    endcase
  end

endmodule