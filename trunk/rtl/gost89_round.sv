module gost89_round(
  input logic          clk,
  input logic  [511:0] sbox,
  input logic  [31:0]  key,
  input logic  [31:0]  n1,
  input logic  [31:0]  n2,
  output logic [31:0]  out1,
  output logic [31:0]  out2
);
  logic [31:0] tmp1, tmp2;

  assign tmp1 = n1 + key;

  gost89_sbox
    sbox1(.sbox(sbox[511:448]), .in(tmp1[3:0]), .out(tmp2[3:0])),
    sbox2(.sbox(sbox[447:384]), .in(tmp1[7:4]), .out(tmp2[7:4])),
    sbox3(.sbox(sbox[383:320]), .in(tmp1[11:8]), .out(tmp2[11:8])),
    sbox4(.sbox(sbox[319:256]), .in(tmp1[15:12]), .out(tmp2[15:12])),
    sbox5(.sbox(sbox[255:192]), .in(tmp1[19:16]), .out(tmp2[19:16])),
    sbox6(.sbox(sbox[191:128]), .in(tmp1[23:20]), .out(tmp2[23:20])),
    sbox7(.sbox(sbox[127:64]),  .in(tmp1[27:24]), .out(tmp2[27:24])),
    sbox8(.sbox(sbox[63 :0]),  .in(tmp1[31:28]), .out(tmp2[31:28]));

  assign out1[10:0]  = tmp2[31:21] ^ n2[10:0];
  assign out1[31:11] = tmp2[20:0]  ^ n2[31:11];

  assign out2 = n1;
endmodule
