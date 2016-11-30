
// Template to ignore unnecessary output ports.
// enumerate in quoted list of verilog-regexp-words.
/* AUTO_LISP(setq verilog-auto-output-ignore-regexp
    (verilog-regexp-words `(
      ""
   ))) */

module renkon(/*AUTOARG*/
   // Outputs
   ack, mem_img_we, mem_img_addr, write_mem_img,
   // Inputs
   clk, xrst, req, img_we, input_addr, output_addr, write_img, net_we,
   net_addr, write_net, total_out, total_in, img_size, fil_size,
   pool_size, read_img
   );
`include "renkon.vh"

  /*AUTOINPUT*/
  input                     clk;
  input                     xrst;
  input                     req;
  input                     img_we;
  input [IMGSIZE-1:0]       input_addr;
  input [IMGSIZE-1:0]       output_addr;
  input signed [DWIDTH-1:0] write_img;
  input [CORELOG:0]         net_we;
  input [NETSIZE-1:0]       net_addr;
  input signed [DWIDTH-1:0] write_net;
  input [LWIDTH-1:0]        total_out;
  input [LWIDTH-1:0]        total_in;
  input [LWIDTH-1:0]        img_size;
  input [LWIDTH-1:0]        fil_size;
  input [LWIDTH-1:0]        pool_size;
  input signed [DWIDTH-1:0] read_img;

  /*AUTOOUTPUT*/
  output                      ack;
  output                      mem_img_we;
  output [IMGSIZE-1:0]        mem_img_addr;
  output signed [DWIDTH-1:0]  write_mem_img;

  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire			bias_oe;		// From ctrl of renkon_ctrl.v
  wire			breg_we;		// From ctrl of renkon_ctrl.v
  wire			buf_feat_en;		// From ctrl of renkon_ctrl.v
  wire			buf_pix_en;		// From ctrl of renkon_ctrl.v
  wire			conv_oe;		// From ctrl of renkon_ctrl.v
  wire [FACCUM-1:0]	mem_feat_addr;		// From ctrl of renkon_ctrl.v
  wire [FACCUM-1:0]	mem_feat_addr_d1;	// From ctrl of renkon_ctrl.v
  wire			mem_feat_rst;		// From ctrl of renkon_ctrl.v
  wire			mem_feat_we;		// From ctrl of renkon_ctrl.v
  wire [NETSIZE-1:0]	mem_net_addr;		// From ctrl of renkon_ctrl.v
  wire [CORE-1:0]	mem_net_we;		// From ctrl of renkon_ctrl.v
  wire signed [DWIDTH-1:0] pixel0;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel1;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel10;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel11;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel12;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel13;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel14;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel15;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel16;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel17;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel18;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel19;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel2;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel20;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel21;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel22;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel23;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel24;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel3;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel4;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel5;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel6;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel7;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel8;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pixel9;		// From buf_pix of renkon_linebuf.v
  wire signed [DWIDTH-1:0] pmap0;		// From core0 of renkon_core.v
  wire signed [DWIDTH-1:0] pmap1;		// From core1 of renkon_core.v
  wire signed [DWIDTH-1:0] pmap2;		// From core2 of renkon_core.v
  wire signed [DWIDTH-1:0] pmap3;		// From core3 of renkon_core.v
  wire signed [DWIDTH-1:0] pmap4;		// From core4 of renkon_core.v
  wire signed [DWIDTH-1:0] pmap5;		// From core5 of renkon_core.v
  wire signed [DWIDTH-1:0] pmap6;		// From core6 of renkon_core.v
  wire signed [DWIDTH-1:0] pmap7;		// From core7 of renkon_core.v
  wire			pool_oe;		// From ctrl of renkon_ctrl.v
  wire signed [DWIDTH-1:0] read_net0;		// From mem_net0 of renkon_mem_net.v
  wire signed [DWIDTH-1:0] read_net1;		// From mem_net1 of renkon_mem_net.v
  wire signed [DWIDTH-1:0] read_net2;		// From mem_net2 of renkon_mem_net.v
  wire signed [DWIDTH-1:0] read_net3;		// From mem_net3 of renkon_mem_net.v
  wire signed [DWIDTH-1:0] read_net4;		// From mem_net4 of renkon_mem_net.v
  wire signed [DWIDTH-1:0] read_net5;		// From mem_net5 of renkon_mem_net.v
  wire signed [DWIDTH-1:0] read_net6;		// From mem_net6 of renkon_mem_net.v
  wire signed [DWIDTH-1:0] read_net7;		// From mem_net7 of renkon_mem_net.v
  wire			relu_oe;		// From ctrl of renkon_ctrl.v
  wire [OUTSIZE-1:0]	serial_addr;		// From ctrl of renkon_ctrl.v
  wire [CORELOG:0]	serial_re;		// From ctrl of renkon_ctrl.v
  wire			serial_we;		// From ctrl of renkon_ctrl.v
  wire [LWIDTH-1:0]	w_fea_size;		// From ctrl of renkon_ctrl.v
  wire [LWIDTH-1:0]	w_fil_size;		// From ctrl of renkon_ctrl.v
  wire [LWIDTH-1:0]	w_img_size;		// From ctrl of renkon_ctrl.v
  wire [LWIDTH-1:0]	w_pool_size;		// From ctrl of renkon_ctrl.v
  wire			wreg_we;		// From ctrl of renkon_ctrl.v
  wire signed [DWIDTH-1:0] write_result;	// From serial of renkon_serial_mat.v
  // End of automatics

  /*AUTOREG*/

  // AUTO_CONSTANT (DWIDTH)

  renkon_ctrl ctrl(/*AUTOINST*/
		   // Outputs
		   .bias_oe		(bias_oe),
		   .breg_we		(breg_we),
		   .buf_pix_en		(buf_pix_en),
		   .relu_oe		(relu_oe),
		   .serial_addr		(serial_addr[OUTSIZE-1:0]),
		   .serial_re		(serial_re[CORELOG:0]),
		   .serial_we		(serial_we),
		   .ack			(ack),
		   .wreg_we		(wreg_we),
		   .conv_oe		(conv_oe),
		   .pool_oe		(pool_oe),
		   .buf_feat_en		(buf_feat_en),
		   .mem_img_we		(mem_img_we),
		   .mem_img_addr	(mem_img_addr[IMGSIZE-1:0]),
		   .write_mem_img	(write_mem_img[DWIDTH-1:0]),
		   .mem_net_we		(mem_net_we[CORE-1:0]),
		   .mem_net_addr	(mem_net_addr[NETSIZE-1:0]),
		   .mem_feat_we		(mem_feat_we),
		   .mem_feat_rst	(mem_feat_rst),
		   .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
		   .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
		   .w_img_size		(w_img_size[LWIDTH-1:0]),
		   .w_fil_size		(w_fil_size[LWIDTH-1:0]),
		   .w_fea_size		(w_fea_size[LWIDTH-1:0]),
		   .w_pool_size		(w_pool_size[LWIDTH-1:0]),
		   // Inputs
		   .pool_size		(pool_size[LWIDTH-1:0]),
		   .clk			(clk),
		   .xrst		(xrst),
		   .req			(req),
		   .img_we		(img_we),
		   .input_addr		(input_addr[IMGSIZE-1:0]),
		   .output_addr		(output_addr[IMGSIZE-1:0]),
		   .write_img		(write_img[DWIDTH-1:0]),
		   .write_result	(write_result[DWIDTH-1:0]),
		   .net_we		(net_we[CORELOG:0]),
		   .net_addr		(net_addr[NETSIZE-1:0]),
		   .total_in		(total_in[LWIDTH-1:0]),
		   .total_out		(total_out[LWIDTH-1:0]),
		   .img_size		(img_size[LWIDTH-1:0]),
		   .fil_size		(fil_size[LWIDTH-1:0]));


  /* renkon_linebuf AUTO_TEMPLATE (
      .buf_en     (buf_pix_en),
      .buf_input  (read_img[DWIDTH-1:0]),
      .img_size   (w_img_size[LWIDTH-1:0]),
      .fil_size   (w_fil_size[LWIDTH-1:0]),
      .buf_output0_0 (pixel0[DWIDTH-1:0]),
      .buf_output0_1 (pixel1[DWIDTH-1:0]),
      .buf_output0_2 (pixel2[DWIDTH-1:0]),
      .buf_output0_3 (pixel3[DWIDTH-1:0]),
      .buf_output0_4 (pixel4[DWIDTH-1:0]),
      .buf_output1_0 (pixel5[DWIDTH-1:0]),
      .buf_output1_1 (pixel6[DWIDTH-1:0]),
      .buf_output1_2 (pixel7[DWIDTH-1:0]),
      .buf_output1_3 (pixel8[DWIDTH-1:0]),
      .buf_output1_4 (pixel9[DWIDTH-1:0]),
      .buf_output2_0 (pixel10[DWIDTH-1:0]),
      .buf_output2_1 (pixel11[DWIDTH-1:0]),
      .buf_output2_2 (pixel12[DWIDTH-1:0]),
      .buf_output2_3 (pixel13[DWIDTH-1:0]),
      .buf_output2_4 (pixel14[DWIDTH-1:0]),
      .buf_output3_0 (pixel15[DWIDTH-1:0]),
      .buf_output3_1 (pixel16[DWIDTH-1:0]),
      .buf_output3_2 (pixel17[DWIDTH-1:0]),
      .buf_output3_3 (pixel18[DWIDTH-1:0]),
      .buf_output3_4 (pixel19[DWIDTH-1:0]),
      .buf_output4_0 (pixel20[DWIDTH-1:0]),
      .buf_output4_1 (pixel21[DWIDTH-1:0]),
      .buf_output4_2 (pixel22[DWIDTH-1:0]),
      .buf_output4_3 (pixel23[DWIDTH-1:0]),
      .buf_output4_4 (pixel24[DWIDTH-1:0]),
  ); */
  renkon_linebuf buf_pix(/*AUTOINST*/
			 // Outputs
			 .buf_output0_0		(pixel0[DWIDTH-1:0]), // Templated
			 .buf_output0_1		(pixel1[DWIDTH-1:0]), // Templated
			 .buf_output0_2		(pixel2[DWIDTH-1:0]), // Templated
			 .buf_output0_3		(pixel3[DWIDTH-1:0]), // Templated
			 .buf_output0_4		(pixel4[DWIDTH-1:0]), // Templated
			 .buf_output1_0		(pixel5[DWIDTH-1:0]), // Templated
			 .buf_output1_1		(pixel6[DWIDTH-1:0]), // Templated
			 .buf_output1_2		(pixel7[DWIDTH-1:0]), // Templated
			 .buf_output1_3		(pixel8[DWIDTH-1:0]), // Templated
			 .buf_output1_4		(pixel9[DWIDTH-1:0]), // Templated
			 .buf_output2_0		(pixel10[DWIDTH-1:0]), // Templated
			 .buf_output2_1		(pixel11[DWIDTH-1:0]), // Templated
			 .buf_output2_2		(pixel12[DWIDTH-1:0]), // Templated
			 .buf_output2_3		(pixel13[DWIDTH-1:0]), // Templated
			 .buf_output2_4		(pixel14[DWIDTH-1:0]), // Templated
			 .buf_output3_0		(pixel15[DWIDTH-1:0]), // Templated
			 .buf_output3_1		(pixel16[DWIDTH-1:0]), // Templated
			 .buf_output3_2		(pixel17[DWIDTH-1:0]), // Templated
			 .buf_output3_3		(pixel18[DWIDTH-1:0]), // Templated
			 .buf_output3_4		(pixel19[DWIDTH-1:0]), // Templated
			 .buf_output4_0		(pixel20[DWIDTH-1:0]), // Templated
			 .buf_output4_1		(pixel21[DWIDTH-1:0]), // Templated
			 .buf_output4_2		(pixel22[DWIDTH-1:0]), // Templated
			 .buf_output4_3		(pixel23[DWIDTH-1:0]), // Templated
			 .buf_output4_4		(pixel24[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .xrst			(xrst),
			 .buf_en		(buf_pix_en),	 // Templated
			 .img_size		(w_img_size[LWIDTH-1:0]), // Templated
			 .fil_size		(w_fil_size[LWIDTH-1:0]), // Templated
			 .buf_input		(read_img[DWIDTH-1:0])); // Templated

  /* renkon_mem_net AUTO_TEMPLATE (
      .read_data  (read_net0[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[0]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  renkon_mem_net mem_net0(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net0[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[0]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* renkon_core AUTO_TEMPLATE (
      .read_net     (read_net0[DWIDTH-1:0]),
      .pixel0  (pixel0[DWIDTH-1:0]),
      .pixel1  (pixel1[DWIDTH-1:0]),
      .pixel2  (pixel2[DWIDTH-1:0]),
      .pixel3  (pixel3[DWIDTH-1:0]),
      .pixel4  (pixel4[DWIDTH-1:0]),
      .pixel5  (pixel5[DWIDTH-1:0]),
      .pixel6  (pixel6[DWIDTH-1:0]),
      .pixel7  (pixel7[DWIDTH-1:0]),
      .pixel8  (pixel8[DWIDTH-1:0]),
      .pixel9  (pixel9[DWIDTH-1:0]),
      .pixel10  (pixel10[DWIDTH-1:0]),
      .pixel11  (pixel11[DWIDTH-1:0]),
      .pixel12  (pixel12[DWIDTH-1:0]),
      .pixel13  (pixel13[DWIDTH-1:0]),
      .pixel14  (pixel14[DWIDTH-1:0]),
      .pixel15  (pixel15[DWIDTH-1:0]),
      .pixel16  (pixel16[DWIDTH-1:0]),
      .pixel17  (pixel17[DWIDTH-1:0]),
      .pixel18  (pixel18[DWIDTH-1:0]),
      .pixel19  (pixel19[DWIDTH-1:0]),
      .pixel20  (pixel20[DWIDTH-1:0]),
      .pixel21  (pixel21[DWIDTH-1:0]),
      .pixel22  (pixel22[DWIDTH-1:0]),
      .pixel23  (pixel23[DWIDTH-1:0]),
      .pixel24  (pixel24[DWIDTH-1:0]),
      .pmap         (pmap0[DWIDTH-1:0]),
  ); */
  renkon_core core0(/*AUTOINST*/
		    // Outputs
		    .pmap		(pmap0[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .buf_feat_en	(buf_feat_en),
		    .clk		(clk),
		    .conv_oe		(conv_oe),
		    .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
		    .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
		    .mem_feat_rst	(mem_feat_rst),
		    .mem_feat_we	(mem_feat_we),
		    .pixel0		(pixel0[DWIDTH-1:0]),	 // Templated
		    .pixel1		(pixel1[DWIDTH-1:0]),	 // Templated
		    .pixel10		(pixel10[DWIDTH-1:0]),	 // Templated
		    .pixel11		(pixel11[DWIDTH-1:0]),	 // Templated
		    .pixel12		(pixel12[DWIDTH-1:0]),	 // Templated
		    .pixel13		(pixel13[DWIDTH-1:0]),	 // Templated
		    .pixel14		(pixel14[DWIDTH-1:0]),	 // Templated
		    .pixel15		(pixel15[DWIDTH-1:0]),	 // Templated
		    .pixel16		(pixel16[DWIDTH-1:0]),	 // Templated
		    .pixel17		(pixel17[DWIDTH-1:0]),	 // Templated
		    .pixel18		(pixel18[DWIDTH-1:0]),	 // Templated
		    .pixel19		(pixel19[DWIDTH-1:0]),	 // Templated
		    .pixel2		(pixel2[DWIDTH-1:0]),	 // Templated
		    .pixel20		(pixel20[DWIDTH-1:0]),	 // Templated
		    .pixel21		(pixel21[DWIDTH-1:0]),	 // Templated
		    .pixel22		(pixel22[DWIDTH-1:0]),	 // Templated
		    .pixel23		(pixel23[DWIDTH-1:0]),	 // Templated
		    .pixel24		(pixel24[DWIDTH-1:0]),	 // Templated
		    .pixel3		(pixel3[DWIDTH-1:0]),	 // Templated
		    .pixel4		(pixel4[DWIDTH-1:0]),	 // Templated
		    .pixel5		(pixel5[DWIDTH-1:0]),	 // Templated
		    .pixel6		(pixel6[DWIDTH-1:0]),	 // Templated
		    .pixel7		(pixel7[DWIDTH-1:0]),	 // Templated
		    .pixel8		(pixel8[DWIDTH-1:0]),	 // Templated
		    .pixel9		(pixel9[DWIDTH-1:0]),	 // Templated
		    .pool_oe		(pool_oe),
		    .read_net		(read_net0[DWIDTH-1:0]), // Templated
		    .relu_oe		(relu_oe),
		    .w_fea_size		(w_fea_size[LWIDTH-1:0]),
		    .w_pool_size	(w_pool_size[LWIDTH-1:0]),
		    .wreg_we		(wreg_we),
		    .xrst		(xrst));
  /* renkon_mem_net AUTO_TEMPLATE (
      .read_data  (read_net1[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[1]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  renkon_mem_net mem_net1(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net1[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[1]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* renkon_core AUTO_TEMPLATE (
      .read_net     (read_net1[DWIDTH-1:0]),
      .pixel0  (pixel0[DWIDTH-1:0]),
      .pixel1  (pixel1[DWIDTH-1:0]),
      .pixel2  (pixel2[DWIDTH-1:0]),
      .pixel3  (pixel3[DWIDTH-1:0]),
      .pixel4  (pixel4[DWIDTH-1:0]),
      .pixel5  (pixel5[DWIDTH-1:0]),
      .pixel6  (pixel6[DWIDTH-1:0]),
      .pixel7  (pixel7[DWIDTH-1:0]),
      .pixel8  (pixel8[DWIDTH-1:0]),
      .pixel9  (pixel9[DWIDTH-1:0]),
      .pixel10  (pixel10[DWIDTH-1:0]),
      .pixel11  (pixel11[DWIDTH-1:0]),
      .pixel12  (pixel12[DWIDTH-1:0]),
      .pixel13  (pixel13[DWIDTH-1:0]),
      .pixel14  (pixel14[DWIDTH-1:0]),
      .pixel15  (pixel15[DWIDTH-1:0]),
      .pixel16  (pixel16[DWIDTH-1:0]),
      .pixel17  (pixel17[DWIDTH-1:0]),
      .pixel18  (pixel18[DWIDTH-1:0]),
      .pixel19  (pixel19[DWIDTH-1:0]),
      .pixel20  (pixel20[DWIDTH-1:0]),
      .pixel21  (pixel21[DWIDTH-1:0]),
      .pixel22  (pixel22[DWIDTH-1:0]),
      .pixel23  (pixel23[DWIDTH-1:0]),
      .pixel24  (pixel24[DWIDTH-1:0]),
      .pmap         (pmap1[DWIDTH-1:0]),
  ); */
  renkon_core core1(/*AUTOINST*/
		    // Outputs
		    .pmap		(pmap1[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .buf_feat_en	(buf_feat_en),
		    .clk		(clk),
		    .conv_oe		(conv_oe),
		    .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
		    .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
		    .mem_feat_rst	(mem_feat_rst),
		    .mem_feat_we	(mem_feat_we),
		    .pixel0		(pixel0[DWIDTH-1:0]),	 // Templated
		    .pixel1		(pixel1[DWIDTH-1:0]),	 // Templated
		    .pixel10		(pixel10[DWIDTH-1:0]),	 // Templated
		    .pixel11		(pixel11[DWIDTH-1:0]),	 // Templated
		    .pixel12		(pixel12[DWIDTH-1:0]),	 // Templated
		    .pixel13		(pixel13[DWIDTH-1:0]),	 // Templated
		    .pixel14		(pixel14[DWIDTH-1:0]),	 // Templated
		    .pixel15		(pixel15[DWIDTH-1:0]),	 // Templated
		    .pixel16		(pixel16[DWIDTH-1:0]),	 // Templated
		    .pixel17		(pixel17[DWIDTH-1:0]),	 // Templated
		    .pixel18		(pixel18[DWIDTH-1:0]),	 // Templated
		    .pixel19		(pixel19[DWIDTH-1:0]),	 // Templated
		    .pixel2		(pixel2[DWIDTH-1:0]),	 // Templated
		    .pixel20		(pixel20[DWIDTH-1:0]),	 // Templated
		    .pixel21		(pixel21[DWIDTH-1:0]),	 // Templated
		    .pixel22		(pixel22[DWIDTH-1:0]),	 // Templated
		    .pixel23		(pixel23[DWIDTH-1:0]),	 // Templated
		    .pixel24		(pixel24[DWIDTH-1:0]),	 // Templated
		    .pixel3		(pixel3[DWIDTH-1:0]),	 // Templated
		    .pixel4		(pixel4[DWIDTH-1:0]),	 // Templated
		    .pixel5		(pixel5[DWIDTH-1:0]),	 // Templated
		    .pixel6		(pixel6[DWIDTH-1:0]),	 // Templated
		    .pixel7		(pixel7[DWIDTH-1:0]),	 // Templated
		    .pixel8		(pixel8[DWIDTH-1:0]),	 // Templated
		    .pixel9		(pixel9[DWIDTH-1:0]),	 // Templated
		    .pool_oe		(pool_oe),
		    .read_net		(read_net1[DWIDTH-1:0]), // Templated
		    .relu_oe		(relu_oe),
		    .w_fea_size		(w_fea_size[LWIDTH-1:0]),
		    .w_pool_size	(w_pool_size[LWIDTH-1:0]),
		    .wreg_we		(wreg_we),
		    .xrst		(xrst));
  /* renkon_mem_net AUTO_TEMPLATE (
      .read_data  (read_net2[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[2]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  renkon_mem_net mem_net2(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net2[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[2]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* renkon_core AUTO_TEMPLATE (
      .read_net     (read_net2[DWIDTH-1:0]),
      .pixel0  (pixel0[DWIDTH-1:0]),
      .pixel1  (pixel1[DWIDTH-1:0]),
      .pixel2  (pixel2[DWIDTH-1:0]),
      .pixel3  (pixel3[DWIDTH-1:0]),
      .pixel4  (pixel4[DWIDTH-1:0]),
      .pixel5  (pixel5[DWIDTH-1:0]),
      .pixel6  (pixel6[DWIDTH-1:0]),
      .pixel7  (pixel7[DWIDTH-1:0]),
      .pixel8  (pixel8[DWIDTH-1:0]),
      .pixel9  (pixel9[DWIDTH-1:0]),
      .pixel10  (pixel10[DWIDTH-1:0]),
      .pixel11  (pixel11[DWIDTH-1:0]),
      .pixel12  (pixel12[DWIDTH-1:0]),
      .pixel13  (pixel13[DWIDTH-1:0]),
      .pixel14  (pixel14[DWIDTH-1:0]),
      .pixel15  (pixel15[DWIDTH-1:0]),
      .pixel16  (pixel16[DWIDTH-1:0]),
      .pixel17  (pixel17[DWIDTH-1:0]),
      .pixel18  (pixel18[DWIDTH-1:0]),
      .pixel19  (pixel19[DWIDTH-1:0]),
      .pixel20  (pixel20[DWIDTH-1:0]),
      .pixel21  (pixel21[DWIDTH-1:0]),
      .pixel22  (pixel22[DWIDTH-1:0]),
      .pixel23  (pixel23[DWIDTH-1:0]),
      .pixel24  (pixel24[DWIDTH-1:0]),
      .pmap         (pmap2[DWIDTH-1:0]),
  ); */
  renkon_core core2(/*AUTOINST*/
		    // Outputs
		    .pmap		(pmap2[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .buf_feat_en	(buf_feat_en),
		    .clk		(clk),
		    .conv_oe		(conv_oe),
		    .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
		    .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
		    .mem_feat_rst	(mem_feat_rst),
		    .mem_feat_we	(mem_feat_we),
		    .pixel0		(pixel0[DWIDTH-1:0]),	 // Templated
		    .pixel1		(pixel1[DWIDTH-1:0]),	 // Templated
		    .pixel10		(pixel10[DWIDTH-1:0]),	 // Templated
		    .pixel11		(pixel11[DWIDTH-1:0]),	 // Templated
		    .pixel12		(pixel12[DWIDTH-1:0]),	 // Templated
		    .pixel13		(pixel13[DWIDTH-1:0]),	 // Templated
		    .pixel14		(pixel14[DWIDTH-1:0]),	 // Templated
		    .pixel15		(pixel15[DWIDTH-1:0]),	 // Templated
		    .pixel16		(pixel16[DWIDTH-1:0]),	 // Templated
		    .pixel17		(pixel17[DWIDTH-1:0]),	 // Templated
		    .pixel18		(pixel18[DWIDTH-1:0]),	 // Templated
		    .pixel19		(pixel19[DWIDTH-1:0]),	 // Templated
		    .pixel2		(pixel2[DWIDTH-1:0]),	 // Templated
		    .pixel20		(pixel20[DWIDTH-1:0]),	 // Templated
		    .pixel21		(pixel21[DWIDTH-1:0]),	 // Templated
		    .pixel22		(pixel22[DWIDTH-1:0]),	 // Templated
		    .pixel23		(pixel23[DWIDTH-1:0]),	 // Templated
		    .pixel24		(pixel24[DWIDTH-1:0]),	 // Templated
		    .pixel3		(pixel3[DWIDTH-1:0]),	 // Templated
		    .pixel4		(pixel4[DWIDTH-1:0]),	 // Templated
		    .pixel5		(pixel5[DWIDTH-1:0]),	 // Templated
		    .pixel6		(pixel6[DWIDTH-1:0]),	 // Templated
		    .pixel7		(pixel7[DWIDTH-1:0]),	 // Templated
		    .pixel8		(pixel8[DWIDTH-1:0]),	 // Templated
		    .pixel9		(pixel9[DWIDTH-1:0]),	 // Templated
		    .pool_oe		(pool_oe),
		    .read_net		(read_net2[DWIDTH-1:0]), // Templated
		    .relu_oe		(relu_oe),
		    .w_fea_size		(w_fea_size[LWIDTH-1:0]),
		    .w_pool_size	(w_pool_size[LWIDTH-1:0]),
		    .wreg_we		(wreg_we),
		    .xrst		(xrst));
  /* renkon_mem_net AUTO_TEMPLATE (
      .read_data  (read_net3[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[3]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  renkon_mem_net mem_net3(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net3[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[3]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* renkon_core AUTO_TEMPLATE (
      .read_net     (read_net3[DWIDTH-1:0]),
      .pixel0  (pixel0[DWIDTH-1:0]),
      .pixel1  (pixel1[DWIDTH-1:0]),
      .pixel2  (pixel2[DWIDTH-1:0]),
      .pixel3  (pixel3[DWIDTH-1:0]),
      .pixel4  (pixel4[DWIDTH-1:0]),
      .pixel5  (pixel5[DWIDTH-1:0]),
      .pixel6  (pixel6[DWIDTH-1:0]),
      .pixel7  (pixel7[DWIDTH-1:0]),
      .pixel8  (pixel8[DWIDTH-1:0]),
      .pixel9  (pixel9[DWIDTH-1:0]),
      .pixel10  (pixel10[DWIDTH-1:0]),
      .pixel11  (pixel11[DWIDTH-1:0]),
      .pixel12  (pixel12[DWIDTH-1:0]),
      .pixel13  (pixel13[DWIDTH-1:0]),
      .pixel14  (pixel14[DWIDTH-1:0]),
      .pixel15  (pixel15[DWIDTH-1:0]),
      .pixel16  (pixel16[DWIDTH-1:0]),
      .pixel17  (pixel17[DWIDTH-1:0]),
      .pixel18  (pixel18[DWIDTH-1:0]),
      .pixel19  (pixel19[DWIDTH-1:0]),
      .pixel20  (pixel20[DWIDTH-1:0]),
      .pixel21  (pixel21[DWIDTH-1:0]),
      .pixel22  (pixel22[DWIDTH-1:0]),
      .pixel23  (pixel23[DWIDTH-1:0]),
      .pixel24  (pixel24[DWIDTH-1:0]),
      .pmap         (pmap3[DWIDTH-1:0]),
  ); */
  renkon_core core3(/*AUTOINST*/
		    // Outputs
		    .pmap		(pmap3[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .buf_feat_en	(buf_feat_en),
		    .clk		(clk),
		    .conv_oe		(conv_oe),
		    .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
		    .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
		    .mem_feat_rst	(mem_feat_rst),
		    .mem_feat_we	(mem_feat_we),
		    .pixel0		(pixel0[DWIDTH-1:0]),	 // Templated
		    .pixel1		(pixel1[DWIDTH-1:0]),	 // Templated
		    .pixel10		(pixel10[DWIDTH-1:0]),	 // Templated
		    .pixel11		(pixel11[DWIDTH-1:0]),	 // Templated
		    .pixel12		(pixel12[DWIDTH-1:0]),	 // Templated
		    .pixel13		(pixel13[DWIDTH-1:0]),	 // Templated
		    .pixel14		(pixel14[DWIDTH-1:0]),	 // Templated
		    .pixel15		(pixel15[DWIDTH-1:0]),	 // Templated
		    .pixel16		(pixel16[DWIDTH-1:0]),	 // Templated
		    .pixel17		(pixel17[DWIDTH-1:0]),	 // Templated
		    .pixel18		(pixel18[DWIDTH-1:0]),	 // Templated
		    .pixel19		(pixel19[DWIDTH-1:0]),	 // Templated
		    .pixel2		(pixel2[DWIDTH-1:0]),	 // Templated
		    .pixel20		(pixel20[DWIDTH-1:0]),	 // Templated
		    .pixel21		(pixel21[DWIDTH-1:0]),	 // Templated
		    .pixel22		(pixel22[DWIDTH-1:0]),	 // Templated
		    .pixel23		(pixel23[DWIDTH-1:0]),	 // Templated
		    .pixel24		(pixel24[DWIDTH-1:0]),	 // Templated
		    .pixel3		(pixel3[DWIDTH-1:0]),	 // Templated
		    .pixel4		(pixel4[DWIDTH-1:0]),	 // Templated
		    .pixel5		(pixel5[DWIDTH-1:0]),	 // Templated
		    .pixel6		(pixel6[DWIDTH-1:0]),	 // Templated
		    .pixel7		(pixel7[DWIDTH-1:0]),	 // Templated
		    .pixel8		(pixel8[DWIDTH-1:0]),	 // Templated
		    .pixel9		(pixel9[DWIDTH-1:0]),	 // Templated
		    .pool_oe		(pool_oe),
		    .read_net		(read_net3[DWIDTH-1:0]), // Templated
		    .relu_oe		(relu_oe),
		    .w_fea_size		(w_fea_size[LWIDTH-1:0]),
		    .w_pool_size	(w_pool_size[LWIDTH-1:0]),
		    .wreg_we		(wreg_we),
		    .xrst		(xrst));
  /* renkon_mem_net AUTO_TEMPLATE (
      .read_data  (read_net4[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[4]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  renkon_mem_net mem_net4(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net4[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[4]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* renkon_core AUTO_TEMPLATE (
      .read_net     (read_net4[DWIDTH-1:0]),
      .pixel0  (pixel0[DWIDTH-1:0]),
      .pixel1  (pixel1[DWIDTH-1:0]),
      .pixel2  (pixel2[DWIDTH-1:0]),
      .pixel3  (pixel3[DWIDTH-1:0]),
      .pixel4  (pixel4[DWIDTH-1:0]),
      .pixel5  (pixel5[DWIDTH-1:0]),
      .pixel6  (pixel6[DWIDTH-1:0]),
      .pixel7  (pixel7[DWIDTH-1:0]),
      .pixel8  (pixel8[DWIDTH-1:0]),
      .pixel9  (pixel9[DWIDTH-1:0]),
      .pixel10  (pixel10[DWIDTH-1:0]),
      .pixel11  (pixel11[DWIDTH-1:0]),
      .pixel12  (pixel12[DWIDTH-1:0]),
      .pixel13  (pixel13[DWIDTH-1:0]),
      .pixel14  (pixel14[DWIDTH-1:0]),
      .pixel15  (pixel15[DWIDTH-1:0]),
      .pixel16  (pixel16[DWIDTH-1:0]),
      .pixel17  (pixel17[DWIDTH-1:0]),
      .pixel18  (pixel18[DWIDTH-1:0]),
      .pixel19  (pixel19[DWIDTH-1:0]),
      .pixel20  (pixel20[DWIDTH-1:0]),
      .pixel21  (pixel21[DWIDTH-1:0]),
      .pixel22  (pixel22[DWIDTH-1:0]),
      .pixel23  (pixel23[DWIDTH-1:0]),
      .pixel24  (pixel24[DWIDTH-1:0]),
      .pmap         (pmap4[DWIDTH-1:0]),
  ); */
  renkon_core core4(/*AUTOINST*/
		    // Outputs
		    .pmap		(pmap4[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .buf_feat_en	(buf_feat_en),
		    .clk		(clk),
		    .conv_oe		(conv_oe),
		    .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
		    .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
		    .mem_feat_rst	(mem_feat_rst),
		    .mem_feat_we	(mem_feat_we),
		    .pixel0		(pixel0[DWIDTH-1:0]),	 // Templated
		    .pixel1		(pixel1[DWIDTH-1:0]),	 // Templated
		    .pixel10		(pixel10[DWIDTH-1:0]),	 // Templated
		    .pixel11		(pixel11[DWIDTH-1:0]),	 // Templated
		    .pixel12		(pixel12[DWIDTH-1:0]),	 // Templated
		    .pixel13		(pixel13[DWIDTH-1:0]),	 // Templated
		    .pixel14		(pixel14[DWIDTH-1:0]),	 // Templated
		    .pixel15		(pixel15[DWIDTH-1:0]),	 // Templated
		    .pixel16		(pixel16[DWIDTH-1:0]),	 // Templated
		    .pixel17		(pixel17[DWIDTH-1:0]),	 // Templated
		    .pixel18		(pixel18[DWIDTH-1:0]),	 // Templated
		    .pixel19		(pixel19[DWIDTH-1:0]),	 // Templated
		    .pixel2		(pixel2[DWIDTH-1:0]),	 // Templated
		    .pixel20		(pixel20[DWIDTH-1:0]),	 // Templated
		    .pixel21		(pixel21[DWIDTH-1:0]),	 // Templated
		    .pixel22		(pixel22[DWIDTH-1:0]),	 // Templated
		    .pixel23		(pixel23[DWIDTH-1:0]),	 // Templated
		    .pixel24		(pixel24[DWIDTH-1:0]),	 // Templated
		    .pixel3		(pixel3[DWIDTH-1:0]),	 // Templated
		    .pixel4		(pixel4[DWIDTH-1:0]),	 // Templated
		    .pixel5		(pixel5[DWIDTH-1:0]),	 // Templated
		    .pixel6		(pixel6[DWIDTH-1:0]),	 // Templated
		    .pixel7		(pixel7[DWIDTH-1:0]),	 // Templated
		    .pixel8		(pixel8[DWIDTH-1:0]),	 // Templated
		    .pixel9		(pixel9[DWIDTH-1:0]),	 // Templated
		    .pool_oe		(pool_oe),
		    .read_net		(read_net4[DWIDTH-1:0]), // Templated
		    .relu_oe		(relu_oe),
		    .w_fea_size		(w_fea_size[LWIDTH-1:0]),
		    .w_pool_size	(w_pool_size[LWIDTH-1:0]),
		    .wreg_we		(wreg_we),
		    .xrst		(xrst));
  /* renkon_mem_net AUTO_TEMPLATE (
      .read_data  (read_net5[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[5]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  renkon_mem_net mem_net5(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net5[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[5]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* renkon_core AUTO_TEMPLATE (
      .read_net     (read_net5[DWIDTH-1:0]),
      .pixel0  (pixel0[DWIDTH-1:0]),
      .pixel1  (pixel1[DWIDTH-1:0]),
      .pixel2  (pixel2[DWIDTH-1:0]),
      .pixel3  (pixel3[DWIDTH-1:0]),
      .pixel4  (pixel4[DWIDTH-1:0]),
      .pixel5  (pixel5[DWIDTH-1:0]),
      .pixel6  (pixel6[DWIDTH-1:0]),
      .pixel7  (pixel7[DWIDTH-1:0]),
      .pixel8  (pixel8[DWIDTH-1:0]),
      .pixel9  (pixel9[DWIDTH-1:0]),
      .pixel10  (pixel10[DWIDTH-1:0]),
      .pixel11  (pixel11[DWIDTH-1:0]),
      .pixel12  (pixel12[DWIDTH-1:0]),
      .pixel13  (pixel13[DWIDTH-1:0]),
      .pixel14  (pixel14[DWIDTH-1:0]),
      .pixel15  (pixel15[DWIDTH-1:0]),
      .pixel16  (pixel16[DWIDTH-1:0]),
      .pixel17  (pixel17[DWIDTH-1:0]),
      .pixel18  (pixel18[DWIDTH-1:0]),
      .pixel19  (pixel19[DWIDTH-1:0]),
      .pixel20  (pixel20[DWIDTH-1:0]),
      .pixel21  (pixel21[DWIDTH-1:0]),
      .pixel22  (pixel22[DWIDTH-1:0]),
      .pixel23  (pixel23[DWIDTH-1:0]),
      .pixel24  (pixel24[DWIDTH-1:0]),
      .pmap         (pmap5[DWIDTH-1:0]),
  ); */
  renkon_core core5(/*AUTOINST*/
		    // Outputs
		    .pmap		(pmap5[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .buf_feat_en	(buf_feat_en),
		    .clk		(clk),
		    .conv_oe		(conv_oe),
		    .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
		    .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
		    .mem_feat_rst	(mem_feat_rst),
		    .mem_feat_we	(mem_feat_we),
		    .pixel0		(pixel0[DWIDTH-1:0]),	 // Templated
		    .pixel1		(pixel1[DWIDTH-1:0]),	 // Templated
		    .pixel10		(pixel10[DWIDTH-1:0]),	 // Templated
		    .pixel11		(pixel11[DWIDTH-1:0]),	 // Templated
		    .pixel12		(pixel12[DWIDTH-1:0]),	 // Templated
		    .pixel13		(pixel13[DWIDTH-1:0]),	 // Templated
		    .pixel14		(pixel14[DWIDTH-1:0]),	 // Templated
		    .pixel15		(pixel15[DWIDTH-1:0]),	 // Templated
		    .pixel16		(pixel16[DWIDTH-1:0]),	 // Templated
		    .pixel17		(pixel17[DWIDTH-1:0]),	 // Templated
		    .pixel18		(pixel18[DWIDTH-1:0]),	 // Templated
		    .pixel19		(pixel19[DWIDTH-1:0]),	 // Templated
		    .pixel2		(pixel2[DWIDTH-1:0]),	 // Templated
		    .pixel20		(pixel20[DWIDTH-1:0]),	 // Templated
		    .pixel21		(pixel21[DWIDTH-1:0]),	 // Templated
		    .pixel22		(pixel22[DWIDTH-1:0]),	 // Templated
		    .pixel23		(pixel23[DWIDTH-1:0]),	 // Templated
		    .pixel24		(pixel24[DWIDTH-1:0]),	 // Templated
		    .pixel3		(pixel3[DWIDTH-1:0]),	 // Templated
		    .pixel4		(pixel4[DWIDTH-1:0]),	 // Templated
		    .pixel5		(pixel5[DWIDTH-1:0]),	 // Templated
		    .pixel6		(pixel6[DWIDTH-1:0]),	 // Templated
		    .pixel7		(pixel7[DWIDTH-1:0]),	 // Templated
		    .pixel8		(pixel8[DWIDTH-1:0]),	 // Templated
		    .pixel9		(pixel9[DWIDTH-1:0]),	 // Templated
		    .pool_oe		(pool_oe),
		    .read_net		(read_net5[DWIDTH-1:0]), // Templated
		    .relu_oe		(relu_oe),
		    .w_fea_size		(w_fea_size[LWIDTH-1:0]),
		    .w_pool_size	(w_pool_size[LWIDTH-1:0]),
		    .wreg_we		(wreg_we),
		    .xrst		(xrst));
  /* renkon_mem_net AUTO_TEMPLATE (
      .read_data  (read_net6[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[6]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  renkon_mem_net mem_net6(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net6[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[6]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* renkon_core AUTO_TEMPLATE (
      .read_net     (read_net6[DWIDTH-1:0]),
      .pixel0  (pixel0[DWIDTH-1:0]),
      .pixel1  (pixel1[DWIDTH-1:0]),
      .pixel2  (pixel2[DWIDTH-1:0]),
      .pixel3  (pixel3[DWIDTH-1:0]),
      .pixel4  (pixel4[DWIDTH-1:0]),
      .pixel5  (pixel5[DWIDTH-1:0]),
      .pixel6  (pixel6[DWIDTH-1:0]),
      .pixel7  (pixel7[DWIDTH-1:0]),
      .pixel8  (pixel8[DWIDTH-1:0]),
      .pixel9  (pixel9[DWIDTH-1:0]),
      .pixel10  (pixel10[DWIDTH-1:0]),
      .pixel11  (pixel11[DWIDTH-1:0]),
      .pixel12  (pixel12[DWIDTH-1:0]),
      .pixel13  (pixel13[DWIDTH-1:0]),
      .pixel14  (pixel14[DWIDTH-1:0]),
      .pixel15  (pixel15[DWIDTH-1:0]),
      .pixel16  (pixel16[DWIDTH-1:0]),
      .pixel17  (pixel17[DWIDTH-1:0]),
      .pixel18  (pixel18[DWIDTH-1:0]),
      .pixel19  (pixel19[DWIDTH-1:0]),
      .pixel20  (pixel20[DWIDTH-1:0]),
      .pixel21  (pixel21[DWIDTH-1:0]),
      .pixel22  (pixel22[DWIDTH-1:0]),
      .pixel23  (pixel23[DWIDTH-1:0]),
      .pixel24  (pixel24[DWIDTH-1:0]),
      .pmap         (pmap6[DWIDTH-1:0]),
  ); */
  renkon_core core6(/*AUTOINST*/
		    // Outputs
		    .pmap		(pmap6[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .buf_feat_en	(buf_feat_en),
		    .clk		(clk),
		    .conv_oe		(conv_oe),
		    .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
		    .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
		    .mem_feat_rst	(mem_feat_rst),
		    .mem_feat_we	(mem_feat_we),
		    .pixel0		(pixel0[DWIDTH-1:0]),	 // Templated
		    .pixel1		(pixel1[DWIDTH-1:0]),	 // Templated
		    .pixel10		(pixel10[DWIDTH-1:0]),	 // Templated
		    .pixel11		(pixel11[DWIDTH-1:0]),	 // Templated
		    .pixel12		(pixel12[DWIDTH-1:0]),	 // Templated
		    .pixel13		(pixel13[DWIDTH-1:0]),	 // Templated
		    .pixel14		(pixel14[DWIDTH-1:0]),	 // Templated
		    .pixel15		(pixel15[DWIDTH-1:0]),	 // Templated
		    .pixel16		(pixel16[DWIDTH-1:0]),	 // Templated
		    .pixel17		(pixel17[DWIDTH-1:0]),	 // Templated
		    .pixel18		(pixel18[DWIDTH-1:0]),	 // Templated
		    .pixel19		(pixel19[DWIDTH-1:0]),	 // Templated
		    .pixel2		(pixel2[DWIDTH-1:0]),	 // Templated
		    .pixel20		(pixel20[DWIDTH-1:0]),	 // Templated
		    .pixel21		(pixel21[DWIDTH-1:0]),	 // Templated
		    .pixel22		(pixel22[DWIDTH-1:0]),	 // Templated
		    .pixel23		(pixel23[DWIDTH-1:0]),	 // Templated
		    .pixel24		(pixel24[DWIDTH-1:0]),	 // Templated
		    .pixel3		(pixel3[DWIDTH-1:0]),	 // Templated
		    .pixel4		(pixel4[DWIDTH-1:0]),	 // Templated
		    .pixel5		(pixel5[DWIDTH-1:0]),	 // Templated
		    .pixel6		(pixel6[DWIDTH-1:0]),	 // Templated
		    .pixel7		(pixel7[DWIDTH-1:0]),	 // Templated
		    .pixel8		(pixel8[DWIDTH-1:0]),	 // Templated
		    .pixel9		(pixel9[DWIDTH-1:0]),	 // Templated
		    .pool_oe		(pool_oe),
		    .read_net		(read_net6[DWIDTH-1:0]), // Templated
		    .relu_oe		(relu_oe),
		    .w_fea_size		(w_fea_size[LWIDTH-1:0]),
		    .w_pool_size	(w_pool_size[LWIDTH-1:0]),
		    .wreg_we		(wreg_we),
		    .xrst		(xrst));
  /* renkon_mem_net AUTO_TEMPLATE (
      .read_data  (read_net7[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[7]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  renkon_mem_net mem_net7(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net7[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[7]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* renkon_core AUTO_TEMPLATE (
      .read_net     (read_net7[DWIDTH-1:0]),
      .pixel0  (pixel0[DWIDTH-1:0]),
      .pixel1  (pixel1[DWIDTH-1:0]),
      .pixel2  (pixel2[DWIDTH-1:0]),
      .pixel3  (pixel3[DWIDTH-1:0]),
      .pixel4  (pixel4[DWIDTH-1:0]),
      .pixel5  (pixel5[DWIDTH-1:0]),
      .pixel6  (pixel6[DWIDTH-1:0]),
      .pixel7  (pixel7[DWIDTH-1:0]),
      .pixel8  (pixel8[DWIDTH-1:0]),
      .pixel9  (pixel9[DWIDTH-1:0]),
      .pixel10  (pixel10[DWIDTH-1:0]),
      .pixel11  (pixel11[DWIDTH-1:0]),
      .pixel12  (pixel12[DWIDTH-1:0]),
      .pixel13  (pixel13[DWIDTH-1:0]),
      .pixel14  (pixel14[DWIDTH-1:0]),
      .pixel15  (pixel15[DWIDTH-1:0]),
      .pixel16  (pixel16[DWIDTH-1:0]),
      .pixel17  (pixel17[DWIDTH-1:0]),
      .pixel18  (pixel18[DWIDTH-1:0]),
      .pixel19  (pixel19[DWIDTH-1:0]),
      .pixel20  (pixel20[DWIDTH-1:0]),
      .pixel21  (pixel21[DWIDTH-1:0]),
      .pixel22  (pixel22[DWIDTH-1:0]),
      .pixel23  (pixel23[DWIDTH-1:0]),
      .pixel24  (pixel24[DWIDTH-1:0]),
      .pmap         (pmap7[DWIDTH-1:0]),
  ); */
  renkon_core core7(/*AUTOINST*/
		    // Outputs
		    .pmap		(pmap7[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .buf_feat_en	(buf_feat_en),
		    .clk		(clk),
		    .conv_oe		(conv_oe),
		    .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
		    .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
		    .mem_feat_rst	(mem_feat_rst),
		    .mem_feat_we	(mem_feat_we),
		    .pixel0		(pixel0[DWIDTH-1:0]),	 // Templated
		    .pixel1		(pixel1[DWIDTH-1:0]),	 // Templated
		    .pixel10		(pixel10[DWIDTH-1:0]),	 // Templated
		    .pixel11		(pixel11[DWIDTH-1:0]),	 // Templated
		    .pixel12		(pixel12[DWIDTH-1:0]),	 // Templated
		    .pixel13		(pixel13[DWIDTH-1:0]),	 // Templated
		    .pixel14		(pixel14[DWIDTH-1:0]),	 // Templated
		    .pixel15		(pixel15[DWIDTH-1:0]),	 // Templated
		    .pixel16		(pixel16[DWIDTH-1:0]),	 // Templated
		    .pixel17		(pixel17[DWIDTH-1:0]),	 // Templated
		    .pixel18		(pixel18[DWIDTH-1:0]),	 // Templated
		    .pixel19		(pixel19[DWIDTH-1:0]),	 // Templated
		    .pixel2		(pixel2[DWIDTH-1:0]),	 // Templated
		    .pixel20		(pixel20[DWIDTH-1:0]),	 // Templated
		    .pixel21		(pixel21[DWIDTH-1:0]),	 // Templated
		    .pixel22		(pixel22[DWIDTH-1:0]),	 // Templated
		    .pixel23		(pixel23[DWIDTH-1:0]),	 // Templated
		    .pixel24		(pixel24[DWIDTH-1:0]),	 // Templated
		    .pixel3		(pixel3[DWIDTH-1:0]),	 // Templated
		    .pixel4		(pixel4[DWIDTH-1:0]),	 // Templated
		    .pixel5		(pixel5[DWIDTH-1:0]),	 // Templated
		    .pixel6		(pixel6[DWIDTH-1:0]),	 // Templated
		    .pixel7		(pixel7[DWIDTH-1:0]),	 // Templated
		    .pixel8		(pixel8[DWIDTH-1:0]),	 // Templated
		    .pixel9		(pixel9[DWIDTH-1:0]),	 // Templated
		    .pool_oe		(pool_oe),
		    .read_net		(read_net7[DWIDTH-1:0]), // Templated
		    .relu_oe		(relu_oe),
		    .w_fea_size		(w_fea_size[LWIDTH-1:0]),
		    .w_pool_size	(w_pool_size[LWIDTH-1:0]),
		    .wreg_we		(wreg_we),
		    .xrst		(xrst));

  /* renkon_serial_mat AUTO_TEMPLATE (
      .in_data0 (pmap0[DWIDTH-1:0]),
      .in_data1 (pmap1[DWIDTH-1:0]),
      .in_data2 (pmap2[DWIDTH-1:0]),
      .in_data3 (pmap3[DWIDTH-1:0]),
      .in_data4 (pmap4[DWIDTH-1:0]),
      .in_data5 (pmap5[DWIDTH-1:0]),
      .in_data6 (pmap6[DWIDTH-1:0]),
      .in_data7 (pmap7[DWIDTH-1:0]),
      .out_data (write_result[DWIDTH-1:0]),
  ); */
  renkon_serial_mat serial(/*AUTOINST*/
			   // Outputs
			   .out_data		(write_result[DWIDTH-1:0]), // Templated
			   // Inputs
			   .clk			(clk),
			   .xrst		(xrst),
			   .serial_we		(serial_we),
			   .serial_addr		(serial_addr[OUTSIZE-1:0]),
			   .serial_re		(serial_re[CORELOG:0]),
			   .in_data0		(pmap0[DWIDTH-1:0]), // Templated
			   .in_data1		(pmap1[DWIDTH-1:0]), // Templated
			   .in_data2		(pmap2[DWIDTH-1:0]), // Templated
			   .in_data3		(pmap3[DWIDTH-1:0]), // Templated
			   .in_data4		(pmap4[DWIDTH-1:0]), // Templated
			   .in_data5		(pmap5[DWIDTH-1:0]), // Templated
			   .in_data6		(pmap6[DWIDTH-1:0]), // Templated
			   .in_data7		(pmap7[DWIDTH-1:0])); // Templated

endmodule
