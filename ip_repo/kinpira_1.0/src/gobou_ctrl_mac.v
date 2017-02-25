
module gobou_ctrl_mac(/*AUTOARG*/
   // Outputs
   out_begin, out_valid, out_end, mac_oe, accum_we, accum_rst,
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
  output mac_oe;
  output accum_we;
  output accum_rst;

  /*AUTOWIRE*/

  /*AUTOREG*/
  reg r_mac_oe;
  reg r_accum_we;
  reg r_accum_rst;
  reg r_out_begin;
  reg r_out_valid;
  reg r_out_end;

  assign mac_oe = r_mac_oe;
  assign accum_we = r_accum_we;
  assign accum_rst = r_accum_rst;

  always @(posedge clk)
    if (!xrst)
      r_mac_oe <= 0;
    else
      r_mac_oe <= in_end;

  always @(posedge clk)
    if (!xrst)
      r_accum_we <= 0;
    else
      r_accum_we <= in_valid && !in_end;

  always @(posedge clk)
    if (!xrst)
      r_accum_rst <= 0;
    else
      r_accum_rst <= mac_oe;

  assign out_begin = r_out_begin;
  assign out_valid = r_out_valid;
  assign out_end   = r_out_end;

  always @(posedge clk)
    if (!xrst)
      r_out_begin <= 0;
    else
      r_out_begin <= in_end;
  always @(posedge clk)
    if (!xrst)
      r_out_valid <= 0;
    else
      r_out_valid <= r_mac_oe;
  always @(posedge clk)
    if (!xrst)
      r_out_end <= 0;
    else
      r_out_end   <= r_mac_oe;

endmodule

