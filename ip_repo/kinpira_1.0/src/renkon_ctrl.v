
/* AUTO_LISP(setq verilog-auto-output-ignore-regexp
    (verilog-regexp-words `(
      "out_core_begin"
      "out_conv_begin"
      "out_bias_begin"
      "out_relu_begin"
      "out_pool_begin"
      "out_core_valid"
      "out_conv_valid"
      "out_bias_valid"
      "out_relu_valid"
      "out_pool_valid"
      "out_core_end"
      "out_conv_end"
      "out_bias_end"
      "out_relu_end"
      "out_pool_end"
   ))) */

module renkon_ctrl(/*AUTOARG*/
   // Outputs
   serial_we, serial_re, serial_addr, relu_oe, buf_pix_en, breg_we,
   bias_oe, ack, wreg_we, conv_oe, pool_oe, buf_feat_en, mem_img_we,
   mem_img_addr, write_mem_img, mem_net_we, mem_net_addr, mem_feat_we,
   mem_feat_rst, mem_feat_addr, mem_feat_addr_d1, w_img_size,
   w_fil_size, w_fea_size, w_pool_size,
   // Inputs
   pool_size, clk, xrst, req, img_we, input_addr, output_addr,
   write_img, write_result, net_we, net_addr, total_in, total_out,
   img_size, fil_size
   );
`include "ninjin.vh"
`include "renkon.vh"

  parameter S_CORE_WAIT     = 'd0;
  parameter S_CORE_NETWORK  = 'd1;
  parameter S_CORE_INPUT    = 'd2;
  parameter S_CORE_OUTPUT   = 'd3;

  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input [LWIDTH-1:0]	pool_size;		// To ctrl_pool of renkon_ctrl_pool.v
  // End of automatics
  input                     clk;
  input                     xrst;
  input                     req;
  input                     img_we;
  input [IMGSIZE-1:0]       input_addr;
  input [IMGSIZE-1:0]       output_addr;
  input signed [DWIDTH-1:0] write_img;
  input signed [DWIDTH-1:0] write_result;
  input [RENKON_CORELOG:0]         net_we;
  input [RENKON_NETSIZE-1:0]       net_addr;
  input [LWIDTH-1:0]        total_in;
  input [LWIDTH-1:0]        total_out;
  input [LWIDTH-1:0]        img_size;
  input [LWIDTH-1:0]        fil_size;

  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output		bias_oe;		// From ctrl_bias of renkon_ctrl_bias.v
  output		breg_we;		// From ctrl_core of renkon_ctrl_core.v
  output		buf_pix_en;		// From ctrl_core of renkon_ctrl_core.v
  output		relu_oe;		// From ctrl_relu of renkon_ctrl_relu.v
  output [OUTSIZE-1:0]	serial_addr;		// From ctrl_core of renkon_ctrl_core.v
  output [RENKON_CORELOG:0] serial_re;		// From ctrl_core of renkon_ctrl_core.v
  output		serial_we;		// From ctrl_core of renkon_ctrl_core.v
  // End of automatics
  output                      ack;
  output                      wreg_we;
  output                      conv_oe;
  output                      pool_oe;
  output                      buf_feat_en;
  output                      mem_img_we;
  output [IMGSIZE-1:0]        mem_img_addr;
  output signed [DWIDTH-1:0]  write_mem_img;
  output [RENKON_CORE-1:0]           mem_net_we;
  output [RENKON_NETSIZE-1:0]        mem_net_addr;
  output                      mem_feat_we;
  output                      mem_feat_rst;
  output [FACCUM-1:0]         mem_feat_addr;
  output [FACCUM-1:0]         mem_feat_addr_d1;
  output [LWIDTH-1:0]         w_img_size;
  output [LWIDTH-1:0]         w_fil_size;
  output [LWIDTH-1:0]         w_fea_size;
  output [LWIDTH-1:0]         w_pool_size;

  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire [1:0]		core_state;		// From ctrl_core of renkon_ctrl_core.v
  wire			first_input;		// From ctrl_core of renkon_ctrl_core.v
  wire			last_input;		// From ctrl_core of renkon_ctrl_core.v
  // End of automatics
  wire in_core_begin;
  wire in_conv_begin;
  wire in_bias_begin;
  wire in_relu_begin;
  wire in_pool_begin;
  wire out_core_begin;
  wire out_conv_begin;
  wire out_bias_begin;
  wire out_relu_begin;
  wire out_pool_begin;
  wire in_core_valid;
  wire in_conv_valid;
  wire in_bias_valid;
  wire in_relu_valid;
  wire in_pool_valid;
  wire out_core_valid;
  wire out_conv_valid;
  wire out_bias_valid;
  wire out_relu_valid;
  wire out_pool_valid;
  wire in_core_end;
  wire in_conv_end;
  wire in_bias_end;
  wire in_relu_end;
  wire in_pool_end;
  wire out_core_end;
  wire out_conv_end;
  wire out_bias_end;
  wire out_relu_end;
  wire out_pool_end;

  /*AUTOREG*/


//====================================================================
// control modules
//====================================================================

  // assign in_conv_begin = out_core_begin;
  // assign in_pool_begin = out_conv_begin;
  // assign in_core_begin = out_pool_begin;

  assign in_conv_begin = out_core_begin;
  assign in_bias_begin = out_conv_begin;
  assign in_relu_begin = out_bias_begin;
  assign in_pool_begin = out_relu_begin;
  assign in_core_begin = out_pool_begin;
  // assign in_conv_valid = out_core_valid;
  // assign in_pool_valid = out_conv_valid;
  // assign in_core_valid = out_pool_valid;

  assign in_conv_valid = out_core_valid;
  assign in_bias_valid = out_conv_valid;
  assign in_relu_valid = out_bias_valid;
  assign in_pool_valid = out_relu_valid;
  assign in_core_valid = out_pool_valid;
  // assign in_conv_end = out_core_end;
  // assign in_pool_end = out_conv_end;
  // assign in_core_end = out_pool_end;

  assign in_conv_end = out_core_end;
  assign in_bias_end = out_conv_end;
  assign in_relu_end = out_bias_end;
  assign in_pool_end = out_relu_end;
  assign in_core_end = out_pool_end;

  /* renkon_ctrl_core AUTO_TEMPLATE (
      .in_begin    (in_core_begin),
      .out_begin  (out_core_begin),
      .in_valid    (in_core_valid),
      .out_valid  (out_core_valid),
      .in_end    (in_core_end),
      .out_end  (out_core_end),
  ); */
  renkon_ctrl_core ctrl_core(/*AUTOINST*/
			     // Outputs
			     .ack		(ack),
			     .core_state	(core_state[2-1:0]),
			     .out_begin		(out_core_begin), // Templated
			     .out_valid		(out_core_valid), // Templated
			     .out_end		(out_core_end),	 // Templated
			     .mem_img_we	(mem_img_we),
			     .mem_img_addr	(mem_img_addr[IMGSIZE-1:0]),
			     .write_mem_img	(write_mem_img[DWIDTH-1:0]),
			     .mem_net_we	(mem_net_we[RENKON_CORE-1:0]),
			     .mem_net_addr	(mem_net_addr[RENKON_NETSIZE-1:0]),
			     .buf_pix_en	(buf_pix_en),
			     .first_input	(first_input),
			     .last_input	(last_input),
			     .wreg_we		(wreg_we),
			     .breg_we		(breg_we),
			     .serial_we		(serial_we),
			     .serial_re		(serial_re[RENKON_CORELOG:0]),
			     .serial_addr	(serial_addr[OUTSIZE-1:0]),
			     .w_img_size	(w_img_size[LWIDTH-1:0]),
			     .w_fil_size	(w_fil_size[LWIDTH-1:0]),
			     // Inputs
			     .clk		(clk),
			     .xrst		(xrst),
			     .req		(req),
			     .in_begin		(in_core_begin), // Templated
			     .in_valid		(in_core_valid), // Templated
			     .in_end		(in_core_end),	 // Templated
			     .img_we		(img_we),
			     .input_addr	(input_addr[IMGSIZE-1:0]),
			     .output_addr	(output_addr[IMGSIZE-1:0]),
			     .write_img		(write_img[DWIDTH-1:0]),
			     .write_result	(write_result[DWIDTH-1:0]),
			     .net_we		(net_we[RENKON_CORELOG:0]),
			     .net_addr		(net_addr[RENKON_NETSIZE-1:0]),
			     .total_out		(total_out[LWIDTH-1:0]),
			     .total_in		(total_in[LWIDTH-1:0]),
			     .img_size		(img_size[LWIDTH-1:0]),
			     .fil_size		(fil_size[LWIDTH-1:0]));

  /* renkon_ctrl_conv AUTO_TEMPLATE (
      .in_begin    (in_conv_begin),
      .out_begin  (out_conv_begin),
      .in_valid    (in_conv_valid),
      .out_valid  (out_conv_valid),
      .in_end    (in_conv_end),
      .out_end  (out_conv_end),
  ); */
  renkon_ctrl_conv ctrl_conv(/*AUTOINST*/
			     // Outputs
			     .out_begin		(out_conv_begin), // Templated
			     .out_valid		(out_conv_valid), // Templated
			     .out_end		(out_conv_end),	 // Templated
			     .mem_feat_we	(mem_feat_we),
			     .mem_feat_rst	(mem_feat_rst),
			     .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
			     .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
			     .conv_oe		(conv_oe),
			     .w_fea_size	(w_fea_size[LWIDTH-1:0]),
			     // Inputs
			     .clk		(clk),
			     .xrst		(xrst),
			     .in_begin		(in_conv_begin), // Templated
			     .in_valid		(in_conv_valid), // Templated
			     .in_end		(in_conv_end),	 // Templated
			     .core_state	(core_state[2-1:0]),
			     .w_img_size	(w_img_size[LWIDTH-1:0]),
			     .w_fil_size	(w_fil_size[LWIDTH-1:0]),
			     .first_input	(first_input),
			     .last_input	(last_input));

  /* renkon_ctrl_bias AUTO_TEMPLATE (
      .in_begin   (in_bias_begin),
      .out_begin (out_bias_begin),
      .in_valid   (in_bias_valid),
      .out_valid (out_bias_valid),
      .in_end   (in_bias_end),
      .out_end (out_bias_end),
  ); */
  renkon_ctrl_bias ctrl_bias(/*AUTOINST*/
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

  /* renkon_ctrl_relu AUTO_TEMPLATE (
      .in_begin   (in_relu_begin),
      .out_begin (out_relu_begin),
      .in_valid   (in_relu_valid),
      .out_valid (out_relu_valid),
      .in_end   (in_relu_end),
      .out_end (out_relu_end),
  ); */
  renkon_ctrl_relu ctrl_relu(/*AUTOINST*/
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

  /* renkon_ctrl_pool AUTO_TEMPLATE (
      .in_begin    (in_pool_begin),
      .out_begin  (out_pool_begin),
      .in_valid    (in_pool_valid),
      .out_valid  (out_pool_valid),
      .in_end    (in_pool_end),
      .out_end  (out_pool_end),
  ); */
  renkon_ctrl_pool ctrl_pool(/*AUTOINST*/
			     // Outputs
			     .buf_feat_en	(buf_feat_en),
			     .out_begin		(out_pool_begin), // Templated
			     .out_valid		(out_pool_valid), // Templated
			     .out_end		(out_pool_end),	 // Templated
			     .pool_oe		(pool_oe),
			     .w_pool_size	(w_pool_size[LWIDTH-1:0]),
			     // Inputs
			     .clk		(clk),
			     .xrst		(xrst),
			     .in_begin		(in_pool_begin), // Templated
			     .in_valid		(in_pool_valid), // Templated
			     .in_end		(in_pool_end),	 // Templated
			     .w_fea_size	(w_fea_size[LWIDTH-1:0]),
			     .pool_size		(pool_size[LWIDTH-1:0]));

endmodule
