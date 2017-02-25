
/* AUTO_LISP(setq verilog-auto-output-ignore-regexp
    (verilog-regexp-words `(
      "out_core_begin"
      "out_mac_begin"
      "out_bias_begin"
      "out_relu_begin"
      "out_core_valid"
      "out_mac_valid"
      "out_bias_valid"
      "out_relu_valid"
      "out_core_end"
      "out_mac_end"
      "out_bias_end"
      "out_relu_end"
    ))) */

module gobou_ctrl(/*AUTOARG*/
   // Outputs
   write_mem_img, serial_we, relu_oe, mem_net_we, mem_net_addr,
   mem_img_we, mem_img_addr, mac_oe, breg_we, bias_oe, ack, accum_we,
   accum_rst,
   // Inputs
   xrst, write_result, write_img, total_out, total_in, req,
   output_addr, net_we, net_addr, input_addr, img_we, clk
   );
`include "ninjin.vh"
`include "gobou.vh"

  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input			clk;			// To ctrl_core of gobou_ctrl_core.v, ...
  input			img_we;			// To ctrl_core of gobou_ctrl_core.v
  input [IMGSIZE-1:0]	input_addr;		// To ctrl_core of gobou_ctrl_core.v
  input [GOBOU_NETSIZE-1:0] net_addr;		// To ctrl_core of gobou_ctrl_core.v
  input [GOBOU_CORELOG:0] net_we;		// To ctrl_core of gobou_ctrl_core.v
  input [IMGSIZE-1:0]	output_addr;		// To ctrl_core of gobou_ctrl_core.v
  input			req;			// To ctrl_core of gobou_ctrl_core.v
  input [LWIDTH-1:0]	total_in;		// To ctrl_core of gobou_ctrl_core.v
  input [LWIDTH-1:0]	total_out;		// To ctrl_core of gobou_ctrl_core.v
  input signed [DWIDTH-1:0] write_img;		// To ctrl_core of gobou_ctrl_core.v
  input signed [DWIDTH-1:0] write_result;	// To ctrl_core of gobou_ctrl_core.v
  input			xrst;			// To ctrl_core of gobou_ctrl_core.v, ...
  // End of automatics

  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output		accum_rst;		// From ctrl_mac of gobou_ctrl_mac.v
  output		accum_we;		// From ctrl_mac of gobou_ctrl_mac.v
  output		ack;			// From ctrl_core of gobou_ctrl_core.v
  output		bias_oe;		// From ctrl_bias of gobou_ctrl_bias.v
  output		breg_we;		// From ctrl_core of gobou_ctrl_core.v
  output		mac_oe;			// From ctrl_mac of gobou_ctrl_mac.v
  output [IMGSIZE-1:0]	mem_img_addr;		// From ctrl_core of gobou_ctrl_core.v
  output		mem_img_we;		// From ctrl_core of gobou_ctrl_core.v
  output [GOBOU_NETSIZE-1:0] mem_net_addr;	// From ctrl_core of gobou_ctrl_core.v
  output [GOBOU_CORE-1:0] mem_net_we;		// From ctrl_core of gobou_ctrl_core.v
  output		relu_oe;		// From ctrl_relu of gobou_ctrl_relu.v
  output		serial_we;		// From ctrl_core of gobou_ctrl_core.v
  output signed [DWIDTH-1:0] write_mem_img;	// From ctrl_core of gobou_ctrl_core.v
  // End of automatics

  /*AUTOWIRE*/
  wire in_core_begin;
  wire in_mac_begin;
  wire in_bias_begin;
  wire in_relu_begin;
  wire out_core_begin;
  wire out_mac_begin;
  wire out_bias_begin;
  wire out_relu_begin;
  wire in_core_valid;
  wire in_mac_valid;
  wire in_bias_valid;
  wire in_relu_valid;
  wire out_core_valid;
  wire out_mac_valid;
  wire out_bias_valid;
  wire out_relu_valid;
  wire in_core_end;
  wire in_mac_end;
  wire in_bias_end;
  wire in_relu_end;
  wire out_core_end;
  wire out_mac_end;
  wire out_bias_end;
  wire out_relu_end;

  /*AUTOREG*/

  assign in_mac_begin = out_core_begin;
  assign in_bias_begin = out_mac_begin;
  assign in_relu_begin = out_bias_begin;
  assign in_core_begin = out_relu_begin;
  assign in_mac_valid = out_core_valid;
  assign in_bias_valid = out_mac_valid;
  assign in_relu_valid = out_bias_valid;
  assign in_core_valid = out_relu_valid;
  assign in_mac_end = out_core_end;
  assign in_bias_end = out_mac_end;
  assign in_relu_end = out_bias_end;
  assign in_core_end = out_relu_end;

  /* gobou_ctrl_core AUTO_TEMPLATE (
      .in_begin    (in_core_begin),
      .out_begin  (out_core_begin),
      .in_valid    (in_core_valid),
      .out_valid  (out_core_valid),
      .in_end    (in_core_end),
      .out_end  (out_core_end),
  ); */
  gobou_ctrl_core ctrl_core(/*AUTOINST*/
			    // Outputs
			    .ack		(ack),
			    .out_begin		(out_core_begin), // Templated
			    .out_valid		(out_core_valid), // Templated
			    .out_end		(out_core_end),	 // Templated
			    .mem_img_we		(mem_img_we),
			    .mem_img_addr	(mem_img_addr[IMGSIZE-1:0]),
			    .write_mem_img	(write_mem_img[DWIDTH-1:0]),
			    .mem_net_we		(mem_net_we[GOBOU_CORE-1:0]),
			    .mem_net_addr	(mem_net_addr[GOBOU_NETSIZE-1:0]),
			    .breg_we		(breg_we),
			    .serial_we		(serial_we),
			    // Inputs
			    .clk		(clk),
			    .xrst		(xrst),
			    .req		(req),
			    .in_begin		(in_core_begin), // Templated
			    .in_valid		(in_core_valid), // Templated
			    .in_end		(in_core_end),	 // Templated
			    .img_we		(img_we),
			    .input_addr		(input_addr[IMGSIZE-1:0]),
			    .output_addr	(output_addr[IMGSIZE-1:0]),
			    .write_img		(write_img[DWIDTH-1:0]),
			    .write_result	(write_result[DWIDTH-1:0]),
			    .net_we		(net_we[GOBOU_CORELOG:0]),
			    .net_addr		(net_addr[GOBOU_NETSIZE-1:0]),
			    .total_out		(total_out[LWIDTH-1:0]),
			    .total_in		(total_in[LWIDTH-1:0]));

  /* gobou_ctrl_mac AUTO_TEMPLATE (
      .in_begin   (in_mac_begin),
      .out_begin (out_mac_begin),
      .in_valid   (in_mac_valid),
      .out_valid (out_mac_valid),
      .in_end   (in_mac_end),
      .out_end (out_mac_end),
  ); */
  gobou_ctrl_mac ctrl_mac(/*AUTOINST*/
			  // Outputs
			  .out_begin		(out_mac_begin), // Templated
			  .out_valid		(out_mac_valid), // Templated
			  .out_end		(out_mac_end),	 // Templated
			  .mac_oe		(mac_oe),
			  .accum_we		(accum_we),
			  .accum_rst		(accum_rst),
			  // Inputs
			  .clk			(clk),
			  .xrst			(xrst),
			  .in_begin		(in_mac_begin),	 // Templated
			  .in_valid		(in_mac_valid),	 // Templated
			  .in_end		(in_mac_end));	 // Templated

  /* gobou_ctrl_bias AUTO_TEMPLATE (
      .in_begin   (in_bias_begin),
      .out_begin (out_bias_begin),
      .in_valid   (in_bias_valid),
      .out_valid (out_bias_valid),
      .in_end   (in_bias_end),
      .out_end (out_bias_end),
  ); */
  gobou_ctrl_bias ctrl_bias(/*AUTOINST*/
			    // Outputs
			    .out_begin		(out_bias_begin), // Templated
			    .out_valid		(out_bias_valid), // Templated
			    .out_end		(out_bias_end),	 // Templated
			    .bias_oe		(bias_oe),
			    // Inputs
			    .clk		(clk),
			    .xrst		(xrst),
			    .in_begin		(in_bias_begin), // Templated
			    .in_valid		(in_bias_valid), // Templated
			    .in_end		(in_bias_end));	 // Templated

  /* gobou_ctrl_relu AUTO_TEMPLATE (
      .in_begin   (in_relu_begin),
      .out_begin (out_relu_begin),
      .in_valid   (in_relu_valid),
      .out_valid (out_relu_valid),
      .in_end   (in_relu_end),
      .out_end (out_relu_end),
  ); */
  gobou_ctrl_relu ctrl_relu(/*AUTOINST*/
			    // Outputs
			    .out_begin		(out_relu_begin), // Templated
			    .out_valid		(out_relu_valid), // Templated
			    .out_end		(out_relu_end),	 // Templated
			    .relu_oe		(relu_oe),
			    // Inputs
			    .clk		(clk),
			    .xrst		(xrst),
			    .in_begin		(in_relu_begin), // Templated
			    .in_valid		(in_relu_valid), // Templated
			    .in_end		(in_relu_end));	 // Templated

endmodule

