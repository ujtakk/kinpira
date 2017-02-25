
module renkon_serial_mat(/*AUTOARG*/
   // Outputs
   out_data,
   // Inputs
   clk, xrst, serial_we, serial_addr, serial_re, in_data0, in_data1,
   in_data2, in_data3, in_data4, in_data5, in_data6, in_data7
   );
`include "ninjin.vh"
`include "renkon.vh"

  /*AUTOINPUT*/
  input                     clk;
  input                     xrst;
  input                     serial_we;
  input [OUTSIZE-1:0]       serial_addr;
  input [RENKON_CORELOG:0]         serial_re;
  input signed [DWIDTH-1:0] in_data0;
  input signed [DWIDTH-1:0] in_data1;
  input signed [DWIDTH-1:0] in_data2;
  input signed [DWIDTH-1:0] in_data3;
  input signed [DWIDTH-1:0] in_data4;
  input signed [DWIDTH-1:0] in_data5;
  input signed [DWIDTH-1:0] in_data6;
  input signed [DWIDTH-1:0] in_data7;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] out_data;

  /*AUTOWIRE*/
  wire signed [DWIDTH-1:0] w_serial_addr0;
  wire signed [DWIDTH-1:0] mem_data0;
  wire signed [DWIDTH-1:0] w_serial_addr1;
  wire signed [DWIDTH-1:0] mem_data1;
  wire signed [DWIDTH-1:0] w_serial_addr2;
  wire signed [DWIDTH-1:0] mem_data2;
  wire signed [DWIDTH-1:0] w_serial_addr3;
  wire signed [DWIDTH-1:0] mem_data3;
  wire signed [DWIDTH-1:0] w_serial_addr4;
  wire signed [DWIDTH-1:0] mem_data4;
  wire signed [DWIDTH-1:0] w_serial_addr5;
  wire signed [DWIDTH-1:0] mem_data5;
  wire signed [DWIDTH-1:0] w_serial_addr6;
  wire signed [DWIDTH-1:0] mem_data6;
  wire signed [DWIDTH-1:0] w_serial_addr7;
  wire signed [DWIDTH-1:0] mem_data7;

  /*AUTOREG*/
  reg [RENKON_CORELOG:0] r_serial_re;

  assign w_serial_addr0 = serial_re == 'd0 ? serial_addr
                             : serial_re == 'd1 ? serial_addr
                             : 0;

  always @(posedge clk)
    if (!xrst)
      r_serial_re <= 0;
    else
      r_serial_re <= serial_re;

  /* renkon_mem_serial AUTO_TEMPLATE (
      .read_data  (mem_data0[DWIDTH-1:0]),
      .write_data (in_data0[DWIDTH-1:0]),
      .mem_we     (serial_we),
      .mem_addr   (w_serial_addr0[OUTSIZE-1:0]),
  ); */
  renkon_mem_serial mem_serial0(/*AUTOINST*/
				// Outputs
				.read_data	(mem_data0[DWIDTH-1:0]), // Templated
				// Inputs
				.clk		(clk),
				.mem_we		(serial_we),	 // Templated
				.mem_addr	(w_serial_addr0[OUTSIZE-1:0]), // Templated
				.write_data	(in_data0[DWIDTH-1:0])); // Templated
  assign w_serial_addr1 = serial_re == 'd0 ? serial_addr
                             : serial_re == 'd2 ? serial_addr
                             : 0;

  always @(posedge clk)
    if (!xrst)
      r_serial_re <= 0;
    else
      r_serial_re <= serial_re;

  /* renkon_mem_serial AUTO_TEMPLATE (
      .read_data  (mem_data1[DWIDTH-1:0]),
      .write_data (in_data1[DWIDTH-1:0]),
      .mem_we     (serial_we),
      .mem_addr   (w_serial_addr1[OUTSIZE-1:0]),
  ); */
  renkon_mem_serial mem_serial1(/*AUTOINST*/
				// Outputs
				.read_data	(mem_data1[DWIDTH-1:0]), // Templated
				// Inputs
				.clk		(clk),
				.mem_we		(serial_we),	 // Templated
				.mem_addr	(w_serial_addr1[OUTSIZE-1:0]), // Templated
				.write_data	(in_data1[DWIDTH-1:0])); // Templated
  assign w_serial_addr2 = serial_re == 'd0 ? serial_addr
                             : serial_re == 'd3 ? serial_addr
                             : 0;

  always @(posedge clk)
    if (!xrst)
      r_serial_re <= 0;
    else
      r_serial_re <= serial_re;

  /* renkon_mem_serial AUTO_TEMPLATE (
      .read_data  (mem_data2[DWIDTH-1:0]),
      .write_data (in_data2[DWIDTH-1:0]),
      .mem_we     (serial_we),
      .mem_addr   (w_serial_addr2[OUTSIZE-1:0]),
  ); */
  renkon_mem_serial mem_serial2(/*AUTOINST*/
				// Outputs
				.read_data	(mem_data2[DWIDTH-1:0]), // Templated
				// Inputs
				.clk		(clk),
				.mem_we		(serial_we),	 // Templated
				.mem_addr	(w_serial_addr2[OUTSIZE-1:0]), // Templated
				.write_data	(in_data2[DWIDTH-1:0])); // Templated
  assign w_serial_addr3 = serial_re == 'd0 ? serial_addr
                             : serial_re == 'd4 ? serial_addr
                             : 0;

  always @(posedge clk)
    if (!xrst)
      r_serial_re <= 0;
    else
      r_serial_re <= serial_re;

  /* renkon_mem_serial AUTO_TEMPLATE (
      .read_data  (mem_data3[DWIDTH-1:0]),
      .write_data (in_data3[DWIDTH-1:0]),
      .mem_we     (serial_we),
      .mem_addr   (w_serial_addr3[OUTSIZE-1:0]),
  ); */
  renkon_mem_serial mem_serial3(/*AUTOINST*/
				// Outputs
				.read_data	(mem_data3[DWIDTH-1:0]), // Templated
				// Inputs
				.clk		(clk),
				.mem_we		(serial_we),	 // Templated
				.mem_addr	(w_serial_addr3[OUTSIZE-1:0]), // Templated
				.write_data	(in_data3[DWIDTH-1:0])); // Templated
  assign w_serial_addr4 = serial_re == 'd0 ? serial_addr
                             : serial_re == 'd5 ? serial_addr
                             : 0;

  always @(posedge clk)
    if (!xrst)
      r_serial_re <= 0;
    else
      r_serial_re <= serial_re;

  /* renkon_mem_serial AUTO_TEMPLATE (
      .read_data  (mem_data4[DWIDTH-1:0]),
      .write_data (in_data4[DWIDTH-1:0]),
      .mem_we     (serial_we),
      .mem_addr   (w_serial_addr4[OUTSIZE-1:0]),
  ); */
  renkon_mem_serial mem_serial4(/*AUTOINST*/
				// Outputs
				.read_data	(mem_data4[DWIDTH-1:0]), // Templated
				// Inputs
				.clk		(clk),
				.mem_we		(serial_we),	 // Templated
				.mem_addr	(w_serial_addr4[OUTSIZE-1:0]), // Templated
				.write_data	(in_data4[DWIDTH-1:0])); // Templated
  assign w_serial_addr5 = serial_re == 'd0 ? serial_addr
                             : serial_re == 'd6 ? serial_addr
                             : 0;

  always @(posedge clk)
    if (!xrst)
      r_serial_re <= 0;
    else
      r_serial_re <= serial_re;

  /* renkon_mem_serial AUTO_TEMPLATE (
      .read_data  (mem_data5[DWIDTH-1:0]),
      .write_data (in_data5[DWIDTH-1:0]),
      .mem_we     (serial_we),
      .mem_addr   (w_serial_addr5[OUTSIZE-1:0]),
  ); */
  renkon_mem_serial mem_serial5(/*AUTOINST*/
				// Outputs
				.read_data	(mem_data5[DWIDTH-1:0]), // Templated
				// Inputs
				.clk		(clk),
				.mem_we		(serial_we),	 // Templated
				.mem_addr	(w_serial_addr5[OUTSIZE-1:0]), // Templated
				.write_data	(in_data5[DWIDTH-1:0])); // Templated
  assign w_serial_addr6 = serial_re == 'd0 ? serial_addr
                             : serial_re == 'd7 ? serial_addr
                             : 0;

  always @(posedge clk)
    if (!xrst)
      r_serial_re <= 0;
    else
      r_serial_re <= serial_re;

  /* renkon_mem_serial AUTO_TEMPLATE (
      .read_data  (mem_data6[DWIDTH-1:0]),
      .write_data (in_data6[DWIDTH-1:0]),
      .mem_we     (serial_we),
      .mem_addr   (w_serial_addr6[OUTSIZE-1:0]),
  ); */
  renkon_mem_serial mem_serial6(/*AUTOINST*/
				// Outputs
				.read_data	(mem_data6[DWIDTH-1:0]), // Templated
				// Inputs
				.clk		(clk),
				.mem_we		(serial_we),	 // Templated
				.mem_addr	(w_serial_addr6[OUTSIZE-1:0]), // Templated
				.write_data	(in_data6[DWIDTH-1:0])); // Templated
  assign w_serial_addr7 = serial_re == 'd0 ? serial_addr
                             : serial_re == 'd8 ? serial_addr
                             : 0;

  always @(posedge clk)
    if (!xrst)
      r_serial_re <= 0;
    else
      r_serial_re <= serial_re;

  /* renkon_mem_serial AUTO_TEMPLATE (
      .read_data  (mem_data7[DWIDTH-1:0]),
      .write_data (in_data7[DWIDTH-1:0]),
      .mem_we     (serial_we),
      .mem_addr   (w_serial_addr7[OUTSIZE-1:0]),
  ); */
  renkon_mem_serial mem_serial7(/*AUTOINST*/
				// Outputs
				.read_data	(mem_data7[DWIDTH-1:0]), // Templated
				// Inputs
				.clk		(clk),
				.mem_we		(serial_we),	 // Templated
				.mem_addr	(w_serial_addr7[OUTSIZE-1:0]), // Templated
				.write_data	(in_data7[DWIDTH-1:0])); // Templated

  /* renkon_mux_output AUTO_TEMPLATE (
      .output_re    (r_serial_re[RENKON_CORELOG:0]),
      .read_output0  (mem_data0[DWIDTH-1:0]),
      .read_output1  (mem_data1[DWIDTH-1:0]),
      .read_output2  (mem_data2[DWIDTH-1:0]),
      .read_output3  (mem_data3[DWIDTH-1:0]),
      .read_output4  (mem_data4[DWIDTH-1:0]),
      .read_output5  (mem_data5[DWIDTH-1:0]),
      .read_output6  (mem_data6[DWIDTH-1:0]),
      .read_output7  (mem_data7[DWIDTH-1:0]),
      .read_output  (out_data[DWIDTH-1:0]),
  ); */
  renkon_mux_output select_out(/*AUTOINST*/
			       // Outputs
			       .read_output	(out_data[DWIDTH-1:0]), // Templated
			       // Inputs
			       .clk		(clk),
			       .xrst		(xrst),
			       .output_re	(r_serial_re[RENKON_CORELOG:0]), // Templated
			       .read_output0	(mem_data0[DWIDTH-1:0]), // Templated
			       .read_output1	(mem_data1[DWIDTH-1:0]), // Templated
			       .read_output2	(mem_data2[DWIDTH-1:0]), // Templated
			       .read_output3	(mem_data3[DWIDTH-1:0]), // Templated
			       .read_output4	(mem_data4[DWIDTH-1:0]), // Templated
			       .read_output5	(mem_data5[DWIDTH-1:0]), // Templated
			       .read_output6	(mem_data6[DWIDTH-1:0]), // Templated
			       .read_output7	(mem_data7[DWIDTH-1:0])); // Templated

endmodule

