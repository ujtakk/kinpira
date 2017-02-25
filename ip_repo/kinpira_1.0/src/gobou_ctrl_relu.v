
module gobou_ctrl_relu(/*AUTOARG*/
   // Outputs
   out_begin, out_valid, out_end, relu_oe,
   // Inputs
   clk, xrst, in_begin, in_valid, in_end
   );
`include "ninjin.vh"
`include "gobou.vh"

  /*AUTOINPUT*/
  input clk;
  input xrst;
  input in_begin;
  input in_valid;
  input in_end;

  /*AUTOOUTPUT*/
  output out_begin;
  output out_valid;
  output out_end;
  output relu_oe;

  /*AUTOWIRE*/

  /*AUTOREG*/
  reg r_out_begin_d0;
  reg r_out_valid_d0;
  reg r_out_end_d0;
  reg r_out_begin_d1;
  reg r_out_valid_d1;
  reg r_out_end_d1;

  assign out_begin = r_out_begin_d1;
  assign out_valid = r_out_valid_d1;
  assign out_end   = r_out_end_d1;

  assign relu_oe = r_out_valid_d0;

  always @(posedge clk)
    if (!xrst)
      r_out_begin_d0 <= 0;
    else
      r_out_begin_d0 <= in_begin;
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d1 <= 0;
    else
      r_out_begin_d1 <= r_out_begin_d0;
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d0 <= 0;
    else
      r_out_valid_d0 <= in_valid;
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d1 <= 0;
    else
      r_out_valid_d1 <= r_out_valid_d0;
  always @(posedge clk)
    if (!xrst)
      r_out_end_d0 <= 0;
    else
      r_out_end_d0 <= in_end;
  always @(posedge clk)
    if (!xrst)
      r_out_end_d1 <= 0;
    else
      r_out_end_d1 <= r_out_end_d0;

endmodule
