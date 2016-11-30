
module renkon_mux_output(/*AUTOARG*/
   // Outputs
   read_output,
   // Inputs
   clk, xrst, output_re, read_output0, read_output1, read_output2,
   read_output3, read_output4, read_output5, read_output6,
   read_output7
   );
`include "renkon.vh"

  /*AUTOINPUT*/
  input clk;
  input xrst;
  input [CORELOG:0] output_re;
  input signed [DWIDTH-1:0] read_output0;
  input signed [DWIDTH-1:0] read_output1;
  input signed [DWIDTH-1:0] read_output2;
  input signed [DWIDTH-1:0] read_output3;
  input signed [DWIDTH-1:0] read_output4;
  input signed [DWIDTH-1:0] read_output5;
  input signed [DWIDTH-1:0] read_output6;
  input signed [DWIDTH-1:0] read_output7;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] read_output;

  /*AUTOWIRE*/

  /*AUTOREG*/
  reg [DWIDTH-1:0] r_output;

  assign read_output = r_output;

  always @(posedge clk)
    if (!xrst)
      r_output <= 0;
    else
      case (output_re)
        4'd0:     r_output <= {DWIDTH{1'b0}};
        4'd1:     r_output <= read_output0;
        4'd2:     r_output <= read_output1;
        4'd3:     r_output <= read_output2;
        4'd4:     r_output <= read_output3;
        4'd5:     r_output <= read_output4;
        4'd6:     r_output <= read_output5;
        4'd7:     r_output <= read_output6;
        4'd8:     r_output <= read_output7;
        default:  r_output <= {DWIDTH{1'b0}};
      endcase

endmodule
