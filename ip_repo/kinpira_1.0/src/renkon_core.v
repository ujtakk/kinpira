
module renkon_core(/*AUTOARG*/
   // Outputs
   pmap,
   // Inputs
   xrst, wreg_we, w_pool_size, w_fea_size, relu_oe, read_net, pool_oe,
   pixel9, pixel8, pixel7, pixel6, pixel5, pixel4, pixel3, pixel24,
   pixel23, pixel22, pixel21, pixel20, pixel2, pixel19, pixel18,
   pixel17, pixel16, pixel15, pixel14, pixel13, pixel12, pixel11,
   pixel10, pixel1, pixel0, mem_feat_we, mem_feat_rst,
   mem_feat_addr_d1, mem_feat_addr, conv_oe, clk, buf_feat_en,
   breg_we, bias_oe
   );
`include "ninjin.vh"
`include "renkon.vh"

  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input			bias_oe;		// To bias of renkon_bias.v
  input			breg_we;		// To bias of renkon_bias.v
  input			buf_feat_en;		// To pool of renkon_pool.v
  input			clk;			// To conv of renkon_conv.v, ...
  input			conv_oe;		// To conv of renkon_conv.v
  input [FACCUM-1:0]	mem_feat_addr;		// To conv of renkon_conv.v
  input [FACCUM-1:0]	mem_feat_addr_d1;	// To conv of renkon_conv.v
  input			mem_feat_rst;		// To conv of renkon_conv.v
  input			mem_feat_we;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel0;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel1;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel10;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel11;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel12;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel13;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel14;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel15;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel16;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel17;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel18;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel19;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel2;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel20;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel21;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel22;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel23;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel24;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel3;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel4;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel5;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel6;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel7;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel8;		// To conv of renkon_conv.v
  input signed [DWIDTH-1:0] pixel9;		// To conv of renkon_conv.v
  input			pool_oe;		// To pool of renkon_pool.v
  input signed [DWIDTH-1:0] read_net;		// To conv of renkon_conv.v, ...
  input			relu_oe;		// To relu of renkon_relu.v
  input [LWIDTH-1:0]	w_fea_size;		// To pool of renkon_pool.v
  input [LWIDTH-1:0]	w_pool_size;		// To pool of renkon_pool.v
  input			wreg_we;		// To conv of renkon_conv.v
  input			xrst;			// To conv of renkon_conv.v, ...
  // End of automatics

  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output signed [DWIDTH-1:0] pmap;		// From pool of renkon_pool.v
  // End of automatics

  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire signed [DWIDTH-1:0] actived;		// From relu of renkon_relu.v
  wire signed [DWIDTH-1:0] biased;		// From bias of renkon_bias.v
  wire signed [DWIDTH-1:0] fmap;		// From conv of renkon_conv.v
  // End of automatics

  /*AUTOREG*/

  // AUTO_CONSTANT (DWIDTH)

  /* renkon_conv AUTO_TEMPLATE (
      .wreg_we        (wreg_we),
      .out_en         (conv_oe),
      .read_weight    (read_net[DWIDTH-1:0]),
      .pixel_in0 (pixel0[DWIDTH-1:0]),
      .pixel_in1 (pixel1[DWIDTH-1:0]),
      .pixel_in2 (pixel2[DWIDTH-1:0]),
      .pixel_in3 (pixel3[DWIDTH-1:0]),
      .pixel_in4 (pixel4[DWIDTH-1:0]),
      .pixel_in5 (pixel5[DWIDTH-1:0]),
      .pixel_in6 (pixel6[DWIDTH-1:0]),
      .pixel_in7 (pixel7[DWIDTH-1:0]),
      .pixel_in8 (pixel8[DWIDTH-1:0]),
      .pixel_in9 (pixel9[DWIDTH-1:0]),
      .pixel_in10 (pixel10[DWIDTH-1:0]),
      .pixel_in11 (pixel11[DWIDTH-1:0]),
      .pixel_in12 (pixel12[DWIDTH-1:0]),
      .pixel_in13 (pixel13[DWIDTH-1:0]),
      .pixel_in14 (pixel14[DWIDTH-1:0]),
      .pixel_in15 (pixel15[DWIDTH-1:0]),
      .pixel_in16 (pixel16[DWIDTH-1:0]),
      .pixel_in17 (pixel17[DWIDTH-1:0]),
      .pixel_in18 (pixel18[DWIDTH-1:0]),
      .pixel_in19 (pixel19[DWIDTH-1:0]),
      .pixel_in20 (pixel20[DWIDTH-1:0]),
      .pixel_in21 (pixel21[DWIDTH-1:0]),
      .pixel_in22 (pixel22[DWIDTH-1:0]),
      .pixel_in23 (pixel23[DWIDTH-1:0]),
      .pixel_in24 (pixel24[DWIDTH-1:0]),
      .pixel_out      (fmap[DWIDTH-1:0]),
  ); */
  renkon_conv conv(/*AUTOINST*/
		   // Outputs
		   .pixel_out		(fmap[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .clk			(clk),
		   .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
		   .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
		   .mem_feat_rst	(mem_feat_rst),
		   .mem_feat_we		(mem_feat_we),
		   .out_en		(conv_oe),		 // Templated
		   .pixel_in0		(pixel0[DWIDTH-1:0]),	 // Templated
		   .pixel_in1		(pixel1[DWIDTH-1:0]),	 // Templated
		   .pixel_in10		(pixel10[DWIDTH-1:0]),	 // Templated
		   .pixel_in11		(pixel11[DWIDTH-1:0]),	 // Templated
		   .pixel_in12		(pixel12[DWIDTH-1:0]),	 // Templated
		   .pixel_in13		(pixel13[DWIDTH-1:0]),	 // Templated
		   .pixel_in14		(pixel14[DWIDTH-1:0]),	 // Templated
		   .pixel_in15		(pixel15[DWIDTH-1:0]),	 // Templated
		   .pixel_in16		(pixel16[DWIDTH-1:0]),	 // Templated
		   .pixel_in17		(pixel17[DWIDTH-1:0]),	 // Templated
		   .pixel_in18		(pixel18[DWIDTH-1:0]),	 // Templated
		   .pixel_in19		(pixel19[DWIDTH-1:0]),	 // Templated
		   .pixel_in2		(pixel2[DWIDTH-1:0]),	 // Templated
		   .pixel_in20		(pixel20[DWIDTH-1:0]),	 // Templated
		   .pixel_in21		(pixel21[DWIDTH-1:0]),	 // Templated
		   .pixel_in22		(pixel22[DWIDTH-1:0]),	 // Templated
		   .pixel_in23		(pixel23[DWIDTH-1:0]),	 // Templated
		   .pixel_in24		(pixel24[DWIDTH-1:0]),	 // Templated
		   .pixel_in3		(pixel3[DWIDTH-1:0]),	 // Templated
		   .pixel_in4		(pixel4[DWIDTH-1:0]),	 // Templated
		   .pixel_in5		(pixel5[DWIDTH-1:0]),	 // Templated
		   .pixel_in6		(pixel6[DWIDTH-1:0]),	 // Templated
		   .pixel_in7		(pixel7[DWIDTH-1:0]),	 // Templated
		   .pixel_in8		(pixel8[DWIDTH-1:0]),	 // Templated
		   .pixel_in9		(pixel9[DWIDTH-1:0]),	 // Templated
		   .read_weight		(read_net[DWIDTH-1:0]),	 // Templated
		   .wreg_we		(wreg_we),		 // Templated
		   .xrst		(xrst));

  /* renkon_bias AUTO_TEMPLATE (
      .breg_we    (breg_we),
      .out_en     (bias_oe),
      .read_bias  (read_net[DWIDTH-1:0]),
      .pixel_in   (fmap[DWIDTH-1:0]),
      .pixel_out  (biased[DWIDTH-1:0]),
  ); */
  renkon_bias bias(/*AUTOINST*/
		   // Outputs
		   .pixel_out		(biased[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .clk			(clk),
		   .xrst		(xrst),
		   .breg_we		(breg_we),		 // Templated
		   .out_en		(bias_oe),		 // Templated
		   .read_bias		(read_net[DWIDTH-1:0]),	 // Templated
		   .pixel_in		(fmap[DWIDTH-1:0]));	 // Templated

  /* renkon_relu AUTO_TEMPLATE (
      .out_en     (relu_oe),
      .pixel_in   (biased[DWIDTH-1:0]),
      .pixel_out  (actived[DWIDTH-1:0]),
  ); */
  renkon_relu relu(/*AUTOINST*/
		   // Outputs
		   .pixel_out		(actived[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .clk			(clk),
		   .xrst		(xrst),
		   .out_en		(relu_oe),		 // Templated
		   .pixel_in		(biased[DWIDTH-1:0]));	 // Templated

  /* renkon_pool AUTO_TEMPLATE (
      .out_en     (pool_oe),
      .pixel_in   (actived[DWIDTH-1:0]),
      .pixel_out  (pmap[DWIDTH-1:0]),
  ); */
  renkon_pool pool(/*AUTOINST*/
		   // Outputs
		   .pixel_out		(pmap[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .buf_feat_en		(buf_feat_en),
		   .w_fea_size		(w_fea_size[LWIDTH-1:0]),
		   .w_pool_size		(w_pool_size[LWIDTH-1:0]),
		   .clk			(clk),
		   .xrst		(xrst),
		   .out_en		(pool_oe),		 // Templated
		   .pixel_in		(actived[DWIDTH-1:0]));	 // Templated

endmodule
