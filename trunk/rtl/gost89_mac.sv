module gost89_mac(
  input logic              clk,
  input logic              reset,
  input logic              load_data,
  input logic      [511:0] sbox,
  input logic      [255:0] key,
  input logic      [63:0]  in,
  output logic [31:0]  out,
  output logic         busy
);
  logic  [4:0]  counter;
  logic  [31:0] round_key;
  logic         need_xor;
  logic  [31:0] n1, n2;
  logic [31:0] out1, out2;

  gost89_round
    rnd(.*, .key(round_key));

  always_ff @(posedge clk) begin
    if (reset && !load_data) begin
      counter  <= 17;
      need_xor <= 0;
      busy <= 0;
    end

    if (!reset && load_data) begin
      if (need_xor) begin
        n1 <= in[63:32] ^ n2;
        n2 <= in[31:0]  ^ n1;
      end else begin
        n1 <= in[63:32];
        n2 <= in[31:0];
        need_xor <= 1;
      end
      counter <= 0;
      busy <= 1;
    end

    if (reset && load_data) begin
      n1 <= in[63:32];
      n2 <= in[31:0];
      counter  <= 0;
      need_xor <= 1;
      busy <= 1;
    end

    if (!reset && !load_data) begin
      if (counter < 17)
        counter <= counter + 1;
      if (counter > 0 && counter < 17) begin
        n1 <= out1;
        n2 <= out2;
      end
      if (counter == 16) begin
        busy <= 0;
        out  <= out2;
      end
    end
  end

  always_ff @(posedge clk)
    case (counter)
      0:  round_key <= key[255:224];
      1:  round_key <= key[223:192];
      2:  round_key <= key[191:160];
      3:  round_key <= key[159:128];
      4:  round_key <= key[127:96];
      5:  round_key <= key[95:64];
      6:  round_key <= key[63:32];
      7:  round_key <= key[31:0];
      8:  round_key <= key[255:224];
      9:  round_key <= key[223:192];
      10: round_key <= key[191:160];
      11: round_key <= key[159:128];
      12: round_key <= key[127:96];
      13: round_key <= key[95:64];
      14: round_key <= key[63:32];
      15: round_key <= key[31:0];
    endcase
endmodule
