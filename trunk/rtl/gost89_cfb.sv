module gost89_cfb(
  input logic              clk,
  input logic              reset,
  input logic              mode,
  input logic              load_data,
  input logic      [511:0] sbox,
  input logic      [255:0] key,
  input logic      [63:0]  in,
  output logic [63:0]  out,
  output logic         busy
);
  logic  [63:0] gamma;
  logic  [63:0] in_value;
  logic [63:0] out_ecb;
  logic        reset_ecb, load_ecb, busy_ecb;

  assign load_ecb = !reset && load_data;
  assign reset_ecb = load_ecb;

  gost89_ecb_encrypt
    ecb_encrypt(.clk, .reset(reset_ecb), .load_data(load_ecb), .sbox, .key, .in(gamma), .out(out_ecb), .busy(busy_ecb));

  always_ff @(posedge clk) begin
    if (reset && !load_data) begin
      gamma <= in;
      busy <= 0;
    end

    if (!reset & load_data) begin
      in_value <= in;
      busy <= 1;
    end

    if (!reset && !load_data && !busy_ecb && busy) begin
      if (mode) gamma <= in_value;
      else      gamma <= out_ecb ^ in_value;
      out   <= out_ecb ^ in_value;
      busy  <= 0;
    end
  end
endmodule

module gost89_cfb_encrypt(
  input logic              clk,
  input logic              reset,
  input logic              load_data,
  input logic      [511:0] sbox,
  input logic      [255:0] key,
  input logic      [63:0]  in,
  output logic [63:0]  out,
  output logic         busy
);
  logic  [63:0] gamma;
  logic  [63:0] in_value;
  logic [63:0] out_ecb;
  logic        load_ecb, busy_ecb;

  assign load_ecb = !reset && load_data;
  assign reset_ecb = load_ecb;

  gost89_ecb_encrypt
    ecb_encrypt(clk, reset_ecb, load_ecb, sbox, key, gamma, out_ecb, busy_ecb);

  always_ff @(posedge clk) begin
    if (reset && !load_data) begin
      gamma <= in;
      busy <= 0;
    end

    if (!reset & load_data) begin
      in_value <= in;
      busy <= 1;
    end

    if (!reset && !load_data && !busy_ecb && busy) begin
      gamma <= out_ecb ^ in_value;
      out   <= out_ecb ^ in_value;
      busy  <= 0;
    end
  end
endmodule

module gost89_cfb_decrypt(
  input logic              clk,
  input logic              reset,
  input logic              load_data,
  input logic      [511:0] sbox,
  input logic      [255:0] key,
  input logic      [63:0]  in,
  output logic [63:0]  out,
  output logic         busy
);
  logic  [63:0] gamma;
  logic  [63:0] in_value;
  logic [63:0] out_ecb;
  logic        load_ecb, busy_ecb;

  assign load_ecb = !reset && load_data;
  assign reset_ecb = load_ecb;

  gost89_ecb_encrypt
    ecb_encrypt(clk, reset_ecb, load_ecb, sbox, key, gamma, out_ecb, busy_ecb);

  always_ff @(posedge clk) begin
    if (reset && !load_data) begin
      gamma <= in;
      busy <= 0;
    end

    if (!reset & load_data) begin
      in_value <= in;
      busy <= 1;
    end

    if (!reset && !load_data && !busy_ecb && busy) begin
      gamma <= in_value;
      out   <= out_ecb ^ in_value;
      busy  <= 0;
    end
  end
endmodule
