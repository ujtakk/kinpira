
/* AUTO_LISP(setq verilog-auto-output-ignore-regexp
    (verilog-regexp-words `(
      "pixel_feat0"
      "pixel_feat1"
      "pixel_feat2"
      "pixel_feat3"
   ))) */

module renkon_pool(/*AUTOARG*/
   // Outputs
   pixel_out,
   // Inputs
   w_pool_size, w_fea_size, buf_feat_en, clk, xrst, out_en, pixel_in
   );
`include "renkon.vh"

  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input			buf_feat_en;		// To buf_feat of renkon_linebuf.v
  input [LWIDTH-1:0]	w_fea_size;		// To buf_feat of renkon_linebuf.v
  input [LWIDTH-1:0]	w_pool_size;		// To buf_feat of renkon_linebuf.v
  // End of automatics
  input                     clk;
  input                     xrst;
  input                     out_en;
  input signed [DWIDTH-1:0] pixel_in;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] pixel_out;

  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire signed [DWIDTH-1:0] pixel_feat0;		// From buf_feat of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel_feat1;		// From buf_feat of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel_feat2;		// From buf_feat of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel_feat3;		// From buf_feat of renkon_linebuf.v
  // End of automatics

  /*AUTOREG*/

  renkon_pool_max pool_tree(/*AUTOINST*/
			    // Outputs
			    .pixel_out		(pixel_out[DWIDTH-1:0]),
			    // Inputs
			    .clk		(clk),
			    .xrst		(xrst),
			    .out_en		(out_en),
			    .pixel_in		(pixel_in[DWIDTH-1:0]),
			    .pixel_feat0	(pixel_feat0[DWIDTH-1:0]),
			    .pixel_feat1	(pixel_feat1[DWIDTH-1:0]),
			    .pixel_feat2	(pixel_feat2[DWIDTH-1:0]),
			    .pixel_feat3	(pixel_feat3[DWIDTH-1:0]));

  /* renkon_linebuf AUTO_TEMPLATE (
      .buf_en     (buf_feat_en),
      .buf_input  (pixel_in[DWIDTH-1:0]),
      .img_size   (w_fea_size[LWIDTH-1:0]),
      .fil_size   (w_pool_size[LWIDTH-1:0]),
      .buf_output0_0 (pixel_feat0[DWIDTH-1:0]),
      .buf_output0_1 (pixel_feat1[DWIDTH-1:0]),
      .buf_output0_2 (),
      .buf_output0_3 (),
      .buf_output0_4 (),
      .buf_output1_0 (pixel_feat2[DWIDTH-1:0]),
      .buf_output1_1 (pixel_feat3[DWIDTH-1:0]),
      .buf_output1_2 (),
      .buf_output1_3 (),
      .buf_output1_4 (),
      .buf_output2_0 (),
      .buf_output2_1 (),
      .buf_output2_2 (),
      .buf_output2_3 (),
      .buf_output2_4 (),
      .buf_output3_0 (),
      .buf_output3_1 (),
      .buf_output3_2 (),
      .buf_output3_3 (),
      .buf_output3_4 (),
      .buf_output4_0 (),
      .buf_output4_1 (),
      .buf_output4_2 (),
      .buf_output4_3 (),
      .buf_output4_4 (),
  ); */
  renkon_linebuf buf_feat(/*AUTOINST*/
			  // Outputs
			  .buf_output0_0	(pixel_feat0[DWIDTH-1:0]), // Templated
			  .buf_output0_1	(pixel_feat1[DWIDTH-1:0]), // Templated
			  .buf_output0_2	(),		 // Templated
			  .buf_output0_3	(),		 // Templated
			  .buf_output0_4	(),		 // Templated
			  .buf_output1_0	(pixel_feat2[DWIDTH-1:0]), // Templated
			  .buf_output1_1	(pixel_feat3[DWIDTH-1:0]), // Templated
			  .buf_output1_2	(),		 // Templated
			  .buf_output1_3	(),		 // Templated
			  .buf_output1_4	(),		 // Templated
			  .buf_output2_0	(),		 // Templated
			  .buf_output2_1	(),		 // Templated
			  .buf_output2_2	(),		 // Templated
			  .buf_output2_3	(),		 // Templated
			  .buf_output2_4	(),		 // Templated
			  .buf_output3_0	(),		 // Templated
			  .buf_output3_1	(),		 // Templated
			  .buf_output3_2	(),		 // Templated
			  .buf_output3_3	(),		 // Templated
			  .buf_output3_4	(),		 // Templated
			  .buf_output4_0	(),		 // Templated
			  .buf_output4_1	(),		 // Templated
			  .buf_output4_2	(),		 // Templated
			  .buf_output4_3	(),		 // Templated
			  .buf_output4_4	(),		 // Templated
			  // Inputs
			  .clk			(clk),
			  .xrst			(xrst),
			  .buf_en		(buf_feat_en),	 // Templated
			  .img_size		(w_fea_size[LWIDTH-1:0]), // Templated
			  .fil_size		(w_pool_size[LWIDTH-1:0]), // Templated
			  .buf_input		(pixel_in[DWIDTH-1:0])); // Templated

endmodule
