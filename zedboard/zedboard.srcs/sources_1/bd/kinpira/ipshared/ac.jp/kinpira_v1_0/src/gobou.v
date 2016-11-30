
// Template to ignore unnecessary output ports.
// enumerate in quoted list of verilog-regexp-words.
/* AUTO_LISP (setq verilog-auto-output-ignore-regexp
    (verilog-regexp-words `(
      ""
   ))) */

module gobou(/*AUTOARG*/
   // Outputs
   ack, mem_img_we, mem_img_addr, write_mem_img,
   // Inputs
   clk, xrst, req, img_we, input_addr, output_addr, write_img, net_we,
   net_addr, write_net, total_out, total_in, read_img
   );
`include "gobou.vh"

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
  input signed [DWIDTH-1:0] read_img;

  /*AUTOOUTPUT*/
  output                      ack;
  output                      mem_img_we;
  output [IMGSIZE-1:0]        mem_img_addr;
  output signed [DWIDTH-1:0]  write_mem_img;

  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire			accum_rst;		// From ctrl of gobou_ctrl.v
  wire			accum_we;		// From ctrl of gobou_ctrl.v
  wire			bias_oe;		// From ctrl of gobou_ctrl.v
  wire			breg_we;		// From ctrl of gobou_ctrl.v
  wire			mac_oe;			// From ctrl of gobou_ctrl.v
  wire [NETSIZE-1:0]	mem_net_addr;		// From ctrl of gobou_ctrl.v
  wire [CORE-1:0]	mem_net_we;		// From ctrl of gobou_ctrl.v
  wire signed [DWIDTH-1:0] read_net0;		// From mem_net0 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net1;		// From mem_net1 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net10;		// From mem_net10 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net11;		// From mem_net11 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net12;		// From mem_net12 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net13;		// From mem_net13 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net14;		// From mem_net14 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net15;		// From mem_net15 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net2;		// From mem_net2 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net3;		// From mem_net3 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net4;		// From mem_net4 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net5;		// From mem_net5 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net6;		// From mem_net6 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net7;		// From mem_net7 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net8;		// From mem_net8 of gobou_mem_net.v
  wire signed [DWIDTH-1:0] read_net9;		// From mem_net9 of gobou_mem_net.v
  wire			relu_oe;		// From ctrl of gobou_ctrl.v
  wire signed [DWIDTH-1:0] result0;		// From core0 of gobou_core.v
  wire signed [DWIDTH-1:0] result1;		// From core1 of gobou_core.v
  wire signed [DWIDTH-1:0] result10;		// From core10 of gobou_core.v
  wire signed [DWIDTH-1:0] result11;		// From core11 of gobou_core.v
  wire signed [DWIDTH-1:0] result12;		// From core12 of gobou_core.v
  wire signed [DWIDTH-1:0] result13;		// From core13 of gobou_core.v
  wire signed [DWIDTH-1:0] result14;		// From core14 of gobou_core.v
  wire signed [DWIDTH-1:0] result15;		// From core15 of gobou_core.v
  wire signed [DWIDTH-1:0] result2;		// From core2 of gobou_core.v
  wire signed [DWIDTH-1:0] result3;		// From core3 of gobou_core.v
  wire signed [DWIDTH-1:0] result4;		// From core4 of gobou_core.v
  wire signed [DWIDTH-1:0] result5;		// From core5 of gobou_core.v
  wire signed [DWIDTH-1:0] result6;		// From core6 of gobou_core.v
  wire signed [DWIDTH-1:0] result7;		// From core7 of gobou_core.v
  wire signed [DWIDTH-1:0] result8;		// From core8 of gobou_core.v
  wire signed [DWIDTH-1:0] result9;		// From core9 of gobou_core.v
  wire			serial_we;		// From ctrl of gobou_ctrl.v
  wire signed [DWIDTH-1:0] write_result;	// From serial of gobou_serial_vec.v
  // End of automatics

  /*AUTOREG*/

  gobou_ctrl ctrl(/*AUTOINST*/
		  // Outputs
		  .accum_rst		(accum_rst),
		  .accum_we		(accum_we),
		  .ack			(ack),
		  .bias_oe		(bias_oe),
		  .breg_we		(breg_we),
		  .mac_oe		(mac_oe),
		  .mem_img_addr		(mem_img_addr[IMGSIZE-1:0]),
		  .mem_img_we		(mem_img_we),
		  .mem_net_addr		(mem_net_addr[NETSIZE-1:0]),
		  .mem_net_we		(mem_net_we[CORE-1:0]),
		  .relu_oe		(relu_oe),
		  .serial_we		(serial_we),
		  .write_mem_img	(write_mem_img[DWIDTH-1:0]),
		  // Inputs
		  .clk			(clk),
		  .img_we		(img_we),
		  .input_addr		(input_addr[IMGSIZE-1:0]),
		  .net_addr		(net_addr[NETSIZE-1:0]),
		  .net_we		(net_we[CORELOG:0]),
		  .output_addr		(output_addr[IMGSIZE-1:0]),
		  .req			(req),
		  .total_in		(total_in[LWIDTH-1:0]),
		  .total_out		(total_out[LWIDTH-1:0]),
		  .write_img		(write_img[DWIDTH-1:0]),
		  .write_result		(write_result[DWIDTH-1:0]),
		  .xrst			(xrst));


  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net0[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[0]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net0(/*AUTOINST*/
			 // Outputs
			 .read_data		(read_net0[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .mem_we		(mem_net_we[0]), // Templated
			 .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			 .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net0[DWIDTH-1:0]),
      .result (result0[DWIDTH-1:0]),
  ); */
  gobou_core core0(/*AUTOINST*/
		   // Outputs
		   .result		(result0[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .accum_rst		(accum_rst),
		   .accum_we		(accum_we),
		   .bias_oe		(bias_oe),
		   .breg_we		(breg_we),
		   .clk			(clk),
		   .mac_oe		(mac_oe),
		   .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		   .relu_oe		(relu_oe),
		   .weight		(read_net0[DWIDTH-1:0]), // Templated
		   .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net1[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[1]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net1(/*AUTOINST*/
			 // Outputs
			 .read_data		(read_net1[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .mem_we		(mem_net_we[1]), // Templated
			 .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			 .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net1[DWIDTH-1:0]),
      .result (result1[DWIDTH-1:0]),
  ); */
  gobou_core core1(/*AUTOINST*/
		   // Outputs
		   .result		(result1[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .accum_rst		(accum_rst),
		   .accum_we		(accum_we),
		   .bias_oe		(bias_oe),
		   .breg_we		(breg_we),
		   .clk			(clk),
		   .mac_oe		(mac_oe),
		   .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		   .relu_oe		(relu_oe),
		   .weight		(read_net1[DWIDTH-1:0]), // Templated
		   .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net2[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[2]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net2(/*AUTOINST*/
			 // Outputs
			 .read_data		(read_net2[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .mem_we		(mem_net_we[2]), // Templated
			 .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			 .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net2[DWIDTH-1:0]),
      .result (result2[DWIDTH-1:0]),
  ); */
  gobou_core core2(/*AUTOINST*/
		   // Outputs
		   .result		(result2[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .accum_rst		(accum_rst),
		   .accum_we		(accum_we),
		   .bias_oe		(bias_oe),
		   .breg_we		(breg_we),
		   .clk			(clk),
		   .mac_oe		(mac_oe),
		   .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		   .relu_oe		(relu_oe),
		   .weight		(read_net2[DWIDTH-1:0]), // Templated
		   .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net3[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[3]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net3(/*AUTOINST*/
			 // Outputs
			 .read_data		(read_net3[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .mem_we		(mem_net_we[3]), // Templated
			 .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			 .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net3[DWIDTH-1:0]),
      .result (result3[DWIDTH-1:0]),
  ); */
  gobou_core core3(/*AUTOINST*/
		   // Outputs
		   .result		(result3[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .accum_rst		(accum_rst),
		   .accum_we		(accum_we),
		   .bias_oe		(bias_oe),
		   .breg_we		(breg_we),
		   .clk			(clk),
		   .mac_oe		(mac_oe),
		   .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		   .relu_oe		(relu_oe),
		   .weight		(read_net3[DWIDTH-1:0]), // Templated
		   .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net4[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[4]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net4(/*AUTOINST*/
			 // Outputs
			 .read_data		(read_net4[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .mem_we		(mem_net_we[4]), // Templated
			 .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			 .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net4[DWIDTH-1:0]),
      .result (result4[DWIDTH-1:0]),
  ); */
  gobou_core core4(/*AUTOINST*/
		   // Outputs
		   .result		(result4[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .accum_rst		(accum_rst),
		   .accum_we		(accum_we),
		   .bias_oe		(bias_oe),
		   .breg_we		(breg_we),
		   .clk			(clk),
		   .mac_oe		(mac_oe),
		   .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		   .relu_oe		(relu_oe),
		   .weight		(read_net4[DWIDTH-1:0]), // Templated
		   .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net5[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[5]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net5(/*AUTOINST*/
			 // Outputs
			 .read_data		(read_net5[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .mem_we		(mem_net_we[5]), // Templated
			 .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			 .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net5[DWIDTH-1:0]),
      .result (result5[DWIDTH-1:0]),
  ); */
  gobou_core core5(/*AUTOINST*/
		   // Outputs
		   .result		(result5[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .accum_rst		(accum_rst),
		   .accum_we		(accum_we),
		   .bias_oe		(bias_oe),
		   .breg_we		(breg_we),
		   .clk			(clk),
		   .mac_oe		(mac_oe),
		   .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		   .relu_oe		(relu_oe),
		   .weight		(read_net5[DWIDTH-1:0]), // Templated
		   .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net6[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[6]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net6(/*AUTOINST*/
			 // Outputs
			 .read_data		(read_net6[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .mem_we		(mem_net_we[6]), // Templated
			 .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			 .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net6[DWIDTH-1:0]),
      .result (result6[DWIDTH-1:0]),
  ); */
  gobou_core core6(/*AUTOINST*/
		   // Outputs
		   .result		(result6[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .accum_rst		(accum_rst),
		   .accum_we		(accum_we),
		   .bias_oe		(bias_oe),
		   .breg_we		(breg_we),
		   .clk			(clk),
		   .mac_oe		(mac_oe),
		   .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		   .relu_oe		(relu_oe),
		   .weight		(read_net6[DWIDTH-1:0]), // Templated
		   .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net7[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[7]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net7(/*AUTOINST*/
			 // Outputs
			 .read_data		(read_net7[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .mem_we		(mem_net_we[7]), // Templated
			 .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			 .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net7[DWIDTH-1:0]),
      .result (result7[DWIDTH-1:0]),
  ); */
  gobou_core core7(/*AUTOINST*/
		   // Outputs
		   .result		(result7[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .accum_rst		(accum_rst),
		   .accum_we		(accum_we),
		   .bias_oe		(bias_oe),
		   .breg_we		(breg_we),
		   .clk			(clk),
		   .mac_oe		(mac_oe),
		   .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		   .relu_oe		(relu_oe),
		   .weight		(read_net7[DWIDTH-1:0]), // Templated
		   .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net8[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[8]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net8(/*AUTOINST*/
			 // Outputs
			 .read_data		(read_net8[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .mem_we		(mem_net_we[8]), // Templated
			 .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			 .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net8[DWIDTH-1:0]),
      .result (result8[DWIDTH-1:0]),
  ); */
  gobou_core core8(/*AUTOINST*/
		   // Outputs
		   .result		(result8[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .accum_rst		(accum_rst),
		   .accum_we		(accum_we),
		   .bias_oe		(bias_oe),
		   .breg_we		(breg_we),
		   .clk			(clk),
		   .mac_oe		(mac_oe),
		   .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		   .relu_oe		(relu_oe),
		   .weight		(read_net8[DWIDTH-1:0]), // Templated
		   .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net9[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[9]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net9(/*AUTOINST*/
			 // Outputs
			 .read_data		(read_net9[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .mem_we		(mem_net_we[9]), // Templated
			 .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			 .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net9[DWIDTH-1:0]),
      .result (result9[DWIDTH-1:0]),
  ); */
  gobou_core core9(/*AUTOINST*/
		   // Outputs
		   .result		(result9[DWIDTH-1:0]),	 // Templated
		   // Inputs
		   .accum_rst		(accum_rst),
		   .accum_we		(accum_we),
		   .bias_oe		(bias_oe),
		   .breg_we		(breg_we),
		   .clk			(clk),
		   .mac_oe		(mac_oe),
		   .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		   .relu_oe		(relu_oe),
		   .weight		(read_net9[DWIDTH-1:0]), // Templated
		   .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net10[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[10]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net10(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net10[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[10]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net10[DWIDTH-1:0]),
      .result (result10[DWIDTH-1:0]),
  ); */
  gobou_core core10(/*AUTOINST*/
		    // Outputs
		    .result		(result10[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .accum_rst		(accum_rst),
		    .accum_we		(accum_we),
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .clk		(clk),
		    .mac_oe		(mac_oe),
		    .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		    .relu_oe		(relu_oe),
		    .weight		(read_net10[DWIDTH-1:0]), // Templated
		    .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net11[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[11]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net11(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net11[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[11]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net11[DWIDTH-1:0]),
      .result (result11[DWIDTH-1:0]),
  ); */
  gobou_core core11(/*AUTOINST*/
		    // Outputs
		    .result		(result11[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .accum_rst		(accum_rst),
		    .accum_we		(accum_we),
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .clk		(clk),
		    .mac_oe		(mac_oe),
		    .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		    .relu_oe		(relu_oe),
		    .weight		(read_net11[DWIDTH-1:0]), // Templated
		    .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net12[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[12]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net12(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net12[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[12]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net12[DWIDTH-1:0]),
      .result (result12[DWIDTH-1:0]),
  ); */
  gobou_core core12(/*AUTOINST*/
		    // Outputs
		    .result		(result12[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .accum_rst		(accum_rst),
		    .accum_we		(accum_we),
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .clk		(clk),
		    .mac_oe		(mac_oe),
		    .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		    .relu_oe		(relu_oe),
		    .weight		(read_net12[DWIDTH-1:0]), // Templated
		    .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net13[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[13]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net13(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net13[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[13]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net13[DWIDTH-1:0]),
      .result (result13[DWIDTH-1:0]),
  ); */
  gobou_core core13(/*AUTOINST*/
		    // Outputs
		    .result		(result13[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .accum_rst		(accum_rst),
		    .accum_we		(accum_we),
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .clk		(clk),
		    .mac_oe		(mac_oe),
		    .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		    .relu_oe		(relu_oe),
		    .weight		(read_net13[DWIDTH-1:0]), // Templated
		    .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net14[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[14]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net14(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net14[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[14]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net14[DWIDTH-1:0]),
      .result (result14[DWIDTH-1:0]),
  ); */
  gobou_core core14(/*AUTOINST*/
		    // Outputs
		    .result		(result14[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .accum_rst		(accum_rst),
		    .accum_we		(accum_we),
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .clk		(clk),
		    .mac_oe		(mac_oe),
		    .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		    .relu_oe		(relu_oe),
		    .weight		(read_net14[DWIDTH-1:0]), // Templated
		    .xrst		(xrst));
  /* gobou_mem_net AUTO_TEMPLATE (
      .read_data  (read_net15[DWIDTH-1:0]),
      .write_data (write_net[DWIDTH-1:0]),
      .mem_we     (mem_net_we[15]),
      .mem_addr   (mem_net_addr[NETSIZE-1:0]),
  ); */
  gobou_mem_net mem_net15(/*AUTOINST*/
			  // Outputs
			  .read_data		(read_net15[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .mem_we		(mem_net_we[15]), // Templated
			  .mem_addr		(mem_net_addr[NETSIZE-1:0]), // Templated
			  .write_data		(write_net[DWIDTH-1:0])); // Templated

  /* gobou_core AUTO_TEMPLATE (
      .pixel (read_img[DWIDTH-1:0]),
      .weight (read_net15[DWIDTH-1:0]),
      .result (result15[DWIDTH-1:0]),
  ); */
  gobou_core core15(/*AUTOINST*/
		    // Outputs
		    .result		(result15[DWIDTH-1:0]),	 // Templated
		    // Inputs
		    .accum_rst		(accum_rst),
		    .accum_we		(accum_we),
		    .bias_oe		(bias_oe),
		    .breg_we		(breg_we),
		    .clk		(clk),
		    .mac_oe		(mac_oe),
		    .pixel		(read_img[DWIDTH-1:0]),	 // Templated
		    .relu_oe		(relu_oe),
		    .weight		(read_net15[DWIDTH-1:0]), // Templated
		    .xrst		(xrst));

  /* gobou_serial_vec AUTO_TEMPLATE (
      .in_data0 (result0[DWIDTH-1:0]),
      .in_data1 (result1[DWIDTH-1:0]),
      .in_data2 (result2[DWIDTH-1:0]),
      .in_data3 (result3[DWIDTH-1:0]),
      .in_data4 (result4[DWIDTH-1:0]),
      .in_data5 (result5[DWIDTH-1:0]),
      .in_data6 (result6[DWIDTH-1:0]),
      .in_data7 (result7[DWIDTH-1:0]),
      .in_data8 (result8[DWIDTH-1:0]),
      .in_data9 (result9[DWIDTH-1:0]),
      .in_data10 (result10[DWIDTH-1:0]),
      .in_data11 (result11[DWIDTH-1:0]),
      .in_data12 (result12[DWIDTH-1:0]),
      .in_data13 (result13[DWIDTH-1:0]),
      .in_data14 (result14[DWIDTH-1:0]),
      .in_data15 (result15[DWIDTH-1:0]),
      .out_data (write_result[DWIDTH-1:0]),
  ); */
  gobou_serial_vec serial(/*AUTOINST*/
			  // Outputs
			  .out_data		(write_result[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .xrst			(xrst),
			  .serial_we		(serial_we),
			  .in_data0		(result0[DWIDTH-1:0]), // Templated
			  .in_data1		(result1[DWIDTH-1:0]), // Templated
			  .in_data2		(result2[DWIDTH-1:0]), // Templated
			  .in_data3		(result3[DWIDTH-1:0]), // Templated
			  .in_data4		(result4[DWIDTH-1:0]), // Templated
			  .in_data5		(result5[DWIDTH-1:0]), // Templated
			  .in_data6		(result6[DWIDTH-1:0]), // Templated
			  .in_data7		(result7[DWIDTH-1:0]), // Templated
			  .in_data8		(result8[DWIDTH-1:0]), // Templated
			  .in_data9		(result9[DWIDTH-1:0]), // Templated
			  .in_data10		(result10[DWIDTH-1:0]), // Templated
			  .in_data11		(result11[DWIDTH-1:0]), // Templated
			  .in_data12		(result12[DWIDTH-1:0]), // Templated
			  .in_data13		(result13[DWIDTH-1:0]), // Templated
			  .in_data14		(result14[DWIDTH-1:0]), // Templated
			  .in_data15		(result15[DWIDTH-1:0])); // Templated

endmodule

