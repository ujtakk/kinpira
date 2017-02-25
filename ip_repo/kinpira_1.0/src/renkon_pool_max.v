
module renkon_pool_max(/*AUTOARG*/
   // Outputs
   pixel_out,
   // Inputs
   clk, xrst, out_en, pixel_in, pixel_feat0, pixel_feat1, pixel_feat2,
   pixel_feat3
   );
`include "ninjin.vh"
`include "renkon.vh"

  /*AUTOINPUT*/
  input                     clk;
  input                     xrst;
  input                     out_en;
  input signed [DWIDTH-1:0] pixel_in;
  input signed [DWIDTH-1:0] pixel_feat0;
  input signed [DWIDTH-1:0] pixel_feat1;
  input signed [DWIDTH-1:0] pixel_feat2;
  input signed [DWIDTH-1:0] pixel_feat3;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] pixel_out;

  /*AUTOWIRE*/
  wire signed [DWIDTH-1:0] max_0;
  wire signed [DWIDTH-1:0] max_1;
  wire signed [DWIDTH-1:0] max;

  /*AUTOREG*/
  reg signed [DWIDTH-1:0] r_max;
  reg signed [DWIDTH-1:0] r_pixel_feat0;
  reg signed [DWIDTH-1:0] r_pixel_feat1;
  reg signed [DWIDTH-1:0] r_pixel_feat2;
  reg signed [DWIDTH-1:0] r_pixel_feat3;

  assign max_0  = (r_pixel_feat0 > r_pixel_feat1)
                ? r_pixel_feat0
                : r_pixel_feat1;

  assign max_1  = (r_pixel_feat2 > r_pixel_feat3)
                ? r_pixel_feat2
                : r_pixel_feat3;

  assign max  = (max_0 > max_1)
              ? max_0
              : max_1;

  assign pixel_out = r_max;

  always @(posedge clk)
    if (!xrst)
      r_max <= 0;
    else if (out_en)
      r_max <= max;

  always @(posedge clk)
    if (!xrst)
      r_pixel_feat0 <= 0;
    else
      r_pixel_feat0 <= pixel_feat0;
  always @(posedge clk)
    if (!xrst)
      r_pixel_feat1 <= 0;
    else
      r_pixel_feat1 <= pixel_feat1;
  always @(posedge clk)
    if (!xrst)
      r_pixel_feat2 <= 0;
    else
      r_pixel_feat2 <= pixel_feat2;
  always @(posedge clk)
    if (!xrst)
      r_pixel_feat3 <= 0;
    else
      r_pixel_feat3 <= pixel_feat3;

endmodule

