
/* AUTO_LISP (setq verilog-auto-output-ignore-regexp
    (verilog-regexp-words `(
      ""
    ))) */

module gobou_core(/*AUTOARG*/
   // Outputs
   result,
   // Inputs
   xrst, weight, relu_oe, pixel, mac_oe, clk, breg_we, bias_oe,
   accum_we, accum_rst
   );
`include "ninjin.vh"
`include "gobou.vh"

  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input			accum_rst;		// To mac of gobou_mac.v
  input			accum_we;		// To mac of gobou_mac.v
  input			bias_oe;		// To bias of gobou_bias.v
  input			breg_we;		// To bias of gobou_bias.v
  input			clk;			// To mac of gobou_mac.v, ...
  input			mac_oe;			// To mac of gobou_mac.v
  input signed [DWIDTH-1:0] pixel;		// To mac of gobou_mac.v
  input			relu_oe;		// To relu of gobou_relu.v
  input signed [DWIDTH-1:0] weight;		// To mac of gobou_mac.v, ...
  input			xrst;			// To mac of gobou_mac.v, ...
  // End of automatics

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] result;

  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire signed [DWIDTH-1:0] biased;		// From bias of gobou_bias.v
  wire signed [DWIDTH-1:0] dotted;		// From mac of gobou_mac.v
  // End of automatics

  /*AUTOREG*/

  /* gobou_mac AUTO_TEMPLATE (
      .out_en   (mac_oe),
      .accum_we (accum_we),
      .reset    (accum_rst),
      .x        (pixel[DWIDTH-1:0]),
      .w        (weight[DWIDTH-1:0]),
      .y        (dotted[DWIDTH-1:0]),
  ); */
  gobou_mac mac(/*AUTOINST*/
		// Outputs
		.y			(dotted[DWIDTH-1:0]),	 // Templated
		// Inputs
		.clk			(clk),
		.xrst			(xrst),
		.out_en			(mac_oe),		 // Templated
		.accum_we		(accum_we),		 // Templated
		.reset			(accum_rst),		 // Templated
		.x			(pixel[DWIDTH-1:0]),	 // Templated
		.w			(weight[DWIDTH-1:0]));	 // Templated

  /* gobou_bias AUTO_TEMPLATE (
      .read_bias  (weight[DWIDTH-1:0]),
      .breg_we    (breg_we),
      .out_en     (bias_oe),
      .pixel_in   (dotted[DWIDTH-1:0]),
      .pixel_out  (biased[DWIDTH-1:0]),
  ); */
  gobou_bias bias(/*AUTOINST*/
		  // Outputs
		  .pixel_out		(biased[DWIDTH-1:0]),	 // Templated
		  // Inputs
		  .clk			(clk),
		  .xrst			(xrst),
		  .breg_we		(breg_we),		 // Templated
		  .out_en		(bias_oe),		 // Templated
		  .read_bias		(weight[DWIDTH-1:0]),	 // Templated
		  .pixel_in		(dotted[DWIDTH-1:0]));	 // Templated

  /* gobou_relu AUTO_TEMPLATE (
      .out_en     (relu_oe),
      .pixel_in   (biased[DWIDTH-1:0]),
      .pixel_out  (result[DWIDTH-1:0]),
  ); */
  gobou_relu relu(/*AUTOINST*/
		  // Outputs
		  .pixel_out		(result[DWIDTH-1:0]),	 // Templated
		  // Inputs
		  .clk			(clk),
		  .xrst			(xrst),
		  .out_en		(relu_oe),		 // Templated
		  .pixel_in		(biased[DWIDTH-1:0]));	 // Templated

endmodule
