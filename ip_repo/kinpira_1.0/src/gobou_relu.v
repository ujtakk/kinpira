
module gobou_relu(/*AUTOARG*/
   // Outputs
   pixel_out,
   // Inputs
   clk, xrst, out_en, pixel_in
   );
`include "gobou.vh"

  /*AUTOINPUT*/
  input clk;
  input xrst;
  input out_en;
  input signed [DWIDTH-1:0] pixel_in;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] pixel_out;

  /*AUTOWIRE*/

  /*AUTOREG*/
  reg signed [DWIDTH-1:0] r_pixel_in;
  reg signed [DWIDTH-1:0] r_pixel_out;

  assign pixel_out = r_pixel_out;

  always @(posedge clk)
    if (!xrst)
      r_pixel_in <= 0;
    else
      r_pixel_in <= pixel_in;

  always @(posedge clk)
    if (!xrst)
      r_pixel_out <= 0;
    else if (out_en)
      if (r_pixel_in > 0)
        r_pixel_out <= r_pixel_in;
      else
        r_pixel_out <= 0;

endmodule
