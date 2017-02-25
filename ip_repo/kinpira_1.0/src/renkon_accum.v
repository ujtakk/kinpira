
module renkon_accum(/*AUTOARG*/
   // Outputs
   pixel_out, sum_new,
   // Inputs
   clk, xrst, reset, out_en, pixel_in, sum_old
   );
`include "ninjin.vh"
`include "renkon.vh"

  /*AUTOINPUT*/
  input clk;
  input xrst;
  input reset;
  input out_en;
  input signed [DWIDTH-1:0] pixel_in;
  input signed [DWIDTH-1:0] sum_old;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] pixel_out;
  output signed [DWIDTH-1:0] sum_new;

  /*AUTOWIRE*/
  wire signed [DWIDTH-1:0] sum;

  /*AUTOREG*/
  reg signed [DWIDTH-1:0] r_total;

  assign pixel_out  = r_total;
  assign sum_new    = sum;

  assign sum = reset
             ? pixel_in
             : pixel_in + sum_old;

  always @(posedge clk)
    if (!xrst)
      r_total <= 0;
    else if(out_en)
      r_total <= sum;

endmodule
