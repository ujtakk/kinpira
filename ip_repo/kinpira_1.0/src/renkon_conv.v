
module renkon_conv(/*AUTOARG*/
   // Outputs
   pixel_out,
   // Inputs
   xrst, wreg_we, read_weight, pixel_in9, pixel_in8, pixel_in7,
   pixel_in6, pixel_in5, pixel_in4, pixel_in3, pixel_in24, pixel_in23,
   pixel_in22, pixel_in21, pixel_in20, pixel_in2, pixel_in19,
   pixel_in18, pixel_in17, pixel_in16, pixel_in15, pixel_in14,
   pixel_in13, pixel_in12, pixel_in11, pixel_in10, pixel_in1,
   pixel_in0, out_en, mem_feat_we, mem_feat_rst, mem_feat_addr_d1,
   mem_feat_addr, clk
   );
`include "ninjin.vh"
`include "renkon.vh"

  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input			clk;			// To tree of renkon_conv_tree.v, ...
  input [FACCUM-1:0]	mem_feat_addr;		// To mem_feat of renkon_mem_feat.v
  input [FACCUM-1:0]	mem_feat_addr_d1;	// To mem_feat of renkon_mem_feat.v
  input			mem_feat_rst;		// To feat_accum of renkon_accum.v
  input			mem_feat_we;		// To mem_feat of renkon_mem_feat.v
  input			out_en;			// To feat_accum of renkon_accum.v
  input signed [DWIDTH-1:0] pixel_in0;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in1;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in10;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in11;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in12;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in13;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in14;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in15;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in16;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in17;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in18;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in19;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in2;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in20;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in21;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in22;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in23;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in24;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in3;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in4;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in5;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in6;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in7;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in8;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] pixel_in9;		// To tree of renkon_conv_tree.v
  input signed [DWIDTH-1:0] read_weight;	// To wreg of renkon_conv_wreg.v
  input			wreg_we;		// To wreg of renkon_conv_wreg.v
  input			xrst;			// To tree of renkon_conv_tree.v, ...
  // End of automatics

  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output signed [DWIDTH-1:0] pixel_out;		// From feat_accum of renkon_accum.v
  // End of automatics

  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire signed [DWIDTH-1:0] read_feat;		// From mem_feat of renkon_mem_feat.v
  wire signed [DWIDTH-1:0] result;		// From tree of renkon_conv_tree.v
  wire signed [DWIDTH-1:0] weight0;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight1;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight10;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight11;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight12;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight13;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight14;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight15;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight16;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight17;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight18;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight19;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight2;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight20;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight21;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight22;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight23;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight24;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight3;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight4;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight5;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight6;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight7;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight8;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] weight9;		// From wreg of renkon_conv_wreg.v
  wire signed [DWIDTH-1:0] write_feat;		// From feat_accum of renkon_accum.v
  // End of automatics

  /*AUTOREG*/

  // AUTO_CONSTANT (DWIDTH)

  /* renkon_conv_tree AUTO_TEMPLATE (
      .pixel0  (pixel_in0[DWIDTH-1:0]),
      .pixel1  (pixel_in1[DWIDTH-1:0]),
      .pixel2  (pixel_in2[DWIDTH-1:0]),
      .pixel3  (pixel_in3[DWIDTH-1:0]),
      .pixel4  (pixel_in4[DWIDTH-1:0]),
      .pixel5  (pixel_in5[DWIDTH-1:0]),
      .pixel6  (pixel_in6[DWIDTH-1:0]),
      .pixel7  (pixel_in7[DWIDTH-1:0]),
      .pixel8  (pixel_in8[DWIDTH-1:0]),
      .pixel9  (pixel_in9[DWIDTH-1:0]),
      .pixel10  (pixel_in10[DWIDTH-1:0]),
      .pixel11  (pixel_in11[DWIDTH-1:0]),
      .pixel12  (pixel_in12[DWIDTH-1:0]),
      .pixel13  (pixel_in13[DWIDTH-1:0]),
      .pixel14  (pixel_in14[DWIDTH-1:0]),
      .pixel15  (pixel_in15[DWIDTH-1:0]),
      .pixel16  (pixel_in16[DWIDTH-1:0]),
      .pixel17  (pixel_in17[DWIDTH-1:0]),
      .pixel18  (pixel_in18[DWIDTH-1:0]),
      .pixel19  (pixel_in19[DWIDTH-1:0]),
      .pixel20  (pixel_in20[DWIDTH-1:0]),
      .pixel21  (pixel_in21[DWIDTH-1:0]),
      .pixel22  (pixel_in22[DWIDTH-1:0]),
      .pixel23  (pixel_in23[DWIDTH-1:0]),
      .pixel24  (pixel_in24[DWIDTH-1:0]),
      .fmap         (result[DWIDTH-1:0]),
  ); */
  renkon_conv_tree tree(/*AUTOINST*/
			// Outputs
			.fmap		(result[DWIDTH-1:0]),	 // Templated
			// Inputs
			.clk		(clk),
			.xrst		(xrst),
			.pixel0		(pixel_in0[DWIDTH-1:0]), // Templated
			.weight0	(weight0[DWIDTH-1:0]),
			.pixel1		(pixel_in1[DWIDTH-1:0]), // Templated
			.weight1	(weight1[DWIDTH-1:0]),
			.pixel2		(pixel_in2[DWIDTH-1:0]), // Templated
			.weight2	(weight2[DWIDTH-1:0]),
			.pixel3		(pixel_in3[DWIDTH-1:0]), // Templated
			.weight3	(weight3[DWIDTH-1:0]),
			.pixel4		(pixel_in4[DWIDTH-1:0]), // Templated
			.weight4	(weight4[DWIDTH-1:0]),
			.pixel5		(pixel_in5[DWIDTH-1:0]), // Templated
			.weight5	(weight5[DWIDTH-1:0]),
			.pixel6		(pixel_in6[DWIDTH-1:0]), // Templated
			.weight6	(weight6[DWIDTH-1:0]),
			.pixel7		(pixel_in7[DWIDTH-1:0]), // Templated
			.weight7	(weight7[DWIDTH-1:0]),
			.pixel8		(pixel_in8[DWIDTH-1:0]), // Templated
			.weight8	(weight8[DWIDTH-1:0]),
			.pixel9		(pixel_in9[DWIDTH-1:0]), // Templated
			.weight9	(weight9[DWIDTH-1:0]),
			.pixel10	(pixel_in10[DWIDTH-1:0]), // Templated
			.weight10	(weight10[DWIDTH-1:0]),
			.pixel11	(pixel_in11[DWIDTH-1:0]), // Templated
			.weight11	(weight11[DWIDTH-1:0]),
			.pixel12	(pixel_in12[DWIDTH-1:0]), // Templated
			.weight12	(weight12[DWIDTH-1:0]),
			.pixel13	(pixel_in13[DWIDTH-1:0]), // Templated
			.weight13	(weight13[DWIDTH-1:0]),
			.pixel14	(pixel_in14[DWIDTH-1:0]), // Templated
			.weight14	(weight14[DWIDTH-1:0]),
			.pixel15	(pixel_in15[DWIDTH-1:0]), // Templated
			.weight15	(weight15[DWIDTH-1:0]),
			.pixel16	(pixel_in16[DWIDTH-1:0]), // Templated
			.weight16	(weight16[DWIDTH-1:0]),
			.pixel17	(pixel_in17[DWIDTH-1:0]), // Templated
			.weight17	(weight17[DWIDTH-1:0]),
			.pixel18	(pixel_in18[DWIDTH-1:0]), // Templated
			.weight18	(weight18[DWIDTH-1:0]),
			.pixel19	(pixel_in19[DWIDTH-1:0]), // Templated
			.weight19	(weight19[DWIDTH-1:0]),
			.pixel20	(pixel_in20[DWIDTH-1:0]), // Templated
			.weight20	(weight20[DWIDTH-1:0]),
			.pixel21	(pixel_in21[DWIDTH-1:0]), // Templated
			.weight21	(weight21[DWIDTH-1:0]),
			.pixel22	(pixel_in22[DWIDTH-1:0]), // Templated
			.weight22	(weight22[DWIDTH-1:0]),
			.pixel23	(pixel_in23[DWIDTH-1:0]), // Templated
			.weight23	(weight23[DWIDTH-1:0]),
			.pixel24	(pixel_in24[DWIDTH-1:0]), // Templated
			.weight24	(weight24[DWIDTH-1:0]));

  renkon_conv_wreg wreg(/*AUTOINST*/
			// Outputs
			.weight0	(weight0[DWIDTH-1:0]),
			.weight1	(weight1[DWIDTH-1:0]),
			.weight2	(weight2[DWIDTH-1:0]),
			.weight3	(weight3[DWIDTH-1:0]),
			.weight4	(weight4[DWIDTH-1:0]),
			.weight5	(weight5[DWIDTH-1:0]),
			.weight6	(weight6[DWIDTH-1:0]),
			.weight7	(weight7[DWIDTH-1:0]),
			.weight8	(weight8[DWIDTH-1:0]),
			.weight9	(weight9[DWIDTH-1:0]),
			.weight10	(weight10[DWIDTH-1:0]),
			.weight11	(weight11[DWIDTH-1:0]),
			.weight12	(weight12[DWIDTH-1:0]),
			.weight13	(weight13[DWIDTH-1:0]),
			.weight14	(weight14[DWIDTH-1:0]),
			.weight15	(weight15[DWIDTH-1:0]),
			.weight16	(weight16[DWIDTH-1:0]),
			.weight17	(weight17[DWIDTH-1:0]),
			.weight18	(weight18[DWIDTH-1:0]),
			.weight19	(weight19[DWIDTH-1:0]),
			.weight20	(weight20[DWIDTH-1:0]),
			.weight21	(weight21[DWIDTH-1:0]),
			.weight22	(weight22[DWIDTH-1:0]),
			.weight23	(weight23[DWIDTH-1:0]),
			.weight24	(weight24[DWIDTH-1:0]),
			// Inputs
			.read_weight	(read_weight[DWIDTH-1:0]),
			.wreg_we	(wreg_we),
			.clk		(clk));

  /* renkon_mem_feat AUTO_TEMPLATE (
      .read_data1   (),
      .write_data1  (write_feat[DWIDTH-1:0]),
      .mem_we1      (mem_feat_we),
      .mem_addr1    (mem_feat_addr_d1[FACCUM-1:0]),
      .read_data2   (read_feat[DWIDTH-1:0]),
      .write_data2  ({DWIDTH{1'b0}}),
      .mem_we2      (1'b0),
      .mem_addr2    (mem_feat_addr[FACCUM-1:0]),
  ); */
  renkon_mem_feat mem_feat(/*AUTOINST*/
			   // Outputs
			   .read_data1		(),		 // Templated
			   .read_data2		(read_feat[DWIDTH-1:0]), // Templated
			   // Inputs
			   .clk			(clk),
			   .mem_we1		(mem_feat_we),	 // Templated
			   .mem_we2		(1'b0),		 // Templated
			   .mem_addr1		(mem_feat_addr_d1[FACCUM-1:0]), // Templated
			   .mem_addr2		(mem_feat_addr[FACCUM-1:0]), // Templated
			   .write_data1		(write_feat[DWIDTH-1:0]), // Templated
			   .write_data2		({DWIDTH{1'b0}})); // Templated

  /* renkon_accum AUTO_TEMPLATE (
      .pixel_in (result[DWIDTH-1:0]),
      .reset    (mem_feat_rst),
      .sum_old  (read_feat[DWIDTH-1:0]),
      .sum_new  (write_feat[DWIDTH-1:0]),
  ); */
  renkon_accum feat_accum(/*AUTOINST*/
			  // Outputs
			  .pixel_out		(pixel_out[DWIDTH-1:0]),
			  .sum_new		(write_feat[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .xrst			(xrst),
			  .reset		(mem_feat_rst),	 // Templated
			  .out_en		(out_en),
			  .pixel_in		(result[DWIDTH-1:0]), // Templated
			  .sum_old		(read_feat[DWIDTH-1:0])); // Templated

endmodule
