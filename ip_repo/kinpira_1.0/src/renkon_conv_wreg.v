
module renkon_conv_wreg(/*AUTOARG*/
   // Outputs
   weight0, weight1, weight2, weight3, weight4, weight5, weight6,
   weight7, weight8, weight9, weight10, weight11, weight12, weight13,
   weight14, weight15, weight16, weight17, weight18, weight19,
   weight20, weight21, weight22, weight23, weight24,
   // Inputs
   read_weight, wreg_we, clk
   );
`include "ninjin.vh"
`include "renkon.vh"

  /*AUTOINPUT*/
  input signed [DWIDTH-1:0] read_weight;
  input wreg_we;
  input clk;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] weight0;
  output signed [DWIDTH-1:0] weight1;
  output signed [DWIDTH-1:0] weight2;
  output signed [DWIDTH-1:0] weight3;
  output signed [DWIDTH-1:0] weight4;
  output signed [DWIDTH-1:0] weight5;
  output signed [DWIDTH-1:0] weight6;
  output signed [DWIDTH-1:0] weight7;
  output signed [DWIDTH-1:0] weight8;
  output signed [DWIDTH-1:0] weight9;
  output signed [DWIDTH-1:0] weight10;
  output signed [DWIDTH-1:0] weight11;
  output signed [DWIDTH-1:0] weight12;
  output signed [DWIDTH-1:0] weight13;
  output signed [DWIDTH-1:0] weight14;
  output signed [DWIDTH-1:0] weight15;
  output signed [DWIDTH-1:0] weight16;
  output signed [DWIDTH-1:0] weight17;
  output signed [DWIDTH-1:0] weight18;
  output signed [DWIDTH-1:0] weight19;
  output signed [DWIDTH-1:0] weight20;
  output signed [DWIDTH-1:0] weight21;
  output signed [DWIDTH-1:0] weight22;
  output signed [DWIDTH-1:0] weight23;
  output signed [DWIDTH-1:0] weight24;

  /*AUTOWIRE*/

  /*AUTOREG*/
  reg signed [DWIDTH-1:0] r_weight0;
  reg signed [DWIDTH-1:0] r_weight1;
  reg signed [DWIDTH-1:0] r_weight2;
  reg signed [DWIDTH-1:0] r_weight3;
  reg signed [DWIDTH-1:0] r_weight4;
  reg signed [DWIDTH-1:0] r_weight5;
  reg signed [DWIDTH-1:0] r_weight6;
  reg signed [DWIDTH-1:0] r_weight7;
  reg signed [DWIDTH-1:0] r_weight8;
  reg signed [DWIDTH-1:0] r_weight9;
  reg signed [DWIDTH-1:0] r_weight10;
  reg signed [DWIDTH-1:0] r_weight11;
  reg signed [DWIDTH-1:0] r_weight12;
  reg signed [DWIDTH-1:0] r_weight13;
  reg signed [DWIDTH-1:0] r_weight14;
  reg signed [DWIDTH-1:0] r_weight15;
  reg signed [DWIDTH-1:0] r_weight16;
  reg signed [DWIDTH-1:0] r_weight17;
  reg signed [DWIDTH-1:0] r_weight18;
  reg signed [DWIDTH-1:0] r_weight19;
  reg signed [DWIDTH-1:0] r_weight20;
  reg signed [DWIDTH-1:0] r_weight21;
  reg signed [DWIDTH-1:0] r_weight22;
  reg signed [DWIDTH-1:0] r_weight23;
  reg signed [DWIDTH-1:0] r_weight24;

  assign weight0 = r_weight0;
  assign weight1 = r_weight1;
  assign weight2 = r_weight2;
  assign weight3 = r_weight3;
  assign weight4 = r_weight4;
  assign weight5 = r_weight5;
  assign weight6 = r_weight6;
  assign weight7 = r_weight7;
  assign weight8 = r_weight8;
  assign weight9 = r_weight9;
  assign weight10 = r_weight10;
  assign weight11 = r_weight11;
  assign weight12 = r_weight12;
  assign weight13 = r_weight13;
  assign weight14 = r_weight14;
  assign weight15 = r_weight15;
  assign weight16 = r_weight16;
  assign weight17 = r_weight17;
  assign weight18 = r_weight18;
  assign weight19 = r_weight19;
  assign weight20 = r_weight20;
  assign weight21 = r_weight21;
  assign weight22 = r_weight22;
  assign weight23 = r_weight23;
  assign weight24 = r_weight24;

  always @(posedge clk)
    if (wreg_we)
      r_weight0 <= r_weight1;
    else
      r_weight0 <= r_weight0;
  always @(posedge clk)
    if (wreg_we)
      r_weight1 <= r_weight2;
    else
      r_weight1 <= r_weight1;
  always @(posedge clk)
    if (wreg_we)
      r_weight2 <= r_weight3;
    else
      r_weight2 <= r_weight2;
  always @(posedge clk)
    if (wreg_we)
      r_weight3 <= r_weight4;
    else
      r_weight3 <= r_weight3;
  always @(posedge clk)
    if (wreg_we)
      r_weight4 <= r_weight5;
    else
      r_weight4 <= r_weight4;
  always @(posedge clk)
    if (wreg_we)
      r_weight5 <= r_weight6;
    else
      r_weight5 <= r_weight5;
  always @(posedge clk)
    if (wreg_we)
      r_weight6 <= r_weight7;
    else
      r_weight6 <= r_weight6;
  always @(posedge clk)
    if (wreg_we)
      r_weight7 <= r_weight8;
    else
      r_weight7 <= r_weight7;
  always @(posedge clk)
    if (wreg_we)
      r_weight8 <= r_weight9;
    else
      r_weight8 <= r_weight8;
  always @(posedge clk)
    if (wreg_we)
      r_weight9 <= r_weight10;
    else
      r_weight9 <= r_weight9;
  always @(posedge clk)
    if (wreg_we)
      r_weight10 <= r_weight11;
    else
      r_weight10 <= r_weight10;
  always @(posedge clk)
    if (wreg_we)
      r_weight11 <= r_weight12;
    else
      r_weight11 <= r_weight11;
  always @(posedge clk)
    if (wreg_we)
      r_weight12 <= r_weight13;
    else
      r_weight12 <= r_weight12;
  always @(posedge clk)
    if (wreg_we)
      r_weight13 <= r_weight14;
    else
      r_weight13 <= r_weight13;
  always @(posedge clk)
    if (wreg_we)
      r_weight14 <= r_weight15;
    else
      r_weight14 <= r_weight14;
  always @(posedge clk)
    if (wreg_we)
      r_weight15 <= r_weight16;
    else
      r_weight15 <= r_weight15;
  always @(posedge clk)
    if (wreg_we)
      r_weight16 <= r_weight17;
    else
      r_weight16 <= r_weight16;
  always @(posedge clk)
    if (wreg_we)
      r_weight17 <= r_weight18;
    else
      r_weight17 <= r_weight17;
  always @(posedge clk)
    if (wreg_we)
      r_weight18 <= r_weight19;
    else
      r_weight18 <= r_weight18;
  always @(posedge clk)
    if (wreg_we)
      r_weight19 <= r_weight20;
    else
      r_weight19 <= r_weight19;
  always @(posedge clk)
    if (wreg_we)
      r_weight20 <= r_weight21;
    else
      r_weight20 <= r_weight20;
  always @(posedge clk)
    if (wreg_we)
      r_weight21 <= r_weight22;
    else
      r_weight21 <= r_weight21;
  always @(posedge clk)
    if (wreg_we)
      r_weight22 <= r_weight23;
    else
      r_weight22 <= r_weight22;
  always @(posedge clk)
    if (wreg_we)
      r_weight23 <= r_weight24;
    else
      r_weight23 <= r_weight23;
  always @(posedge clk)
    if (wreg_we)
      r_weight24 <= read_weight;
    else
      r_weight24 <= r_weight24;

endmodule
