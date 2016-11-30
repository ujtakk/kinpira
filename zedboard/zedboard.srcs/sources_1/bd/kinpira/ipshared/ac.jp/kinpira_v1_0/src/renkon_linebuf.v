
/* AUTO_LISP(setq verilog-auto-output-ignore-regexp
   (verilog-regexp-words `(
     "read_mem0"
     "read_mem1"
     "read_mem2"
     "read_mem3"
     "read_mem4"
     "read_mem5"
   ))) */

module renkon_linebuf(/*AUTOARG*/
   // Outputs
   buf_output0_0, buf_output0_1, buf_output0_2, buf_output0_3,
   buf_output0_4, buf_output1_0, buf_output1_1, buf_output1_2,
   buf_output1_3, buf_output1_4, buf_output2_0, buf_output2_1,
   buf_output2_2, buf_output2_3, buf_output2_4, buf_output3_0,
   buf_output3_1, buf_output3_2, buf_output3_3, buf_output3_4,
   buf_output4_0, buf_output4_1, buf_output4_2, buf_output4_3,
   buf_output4_4,
   // Inputs
   clk, xrst, buf_en, img_size, fil_size, buf_input
   );
`include "renkon.vh"

  parameter _BUFSIZE = 5;

  parameter S_WAIT   = 'd0;
  parameter S_CHARGE = 'd1;
  parameter S_ACTIVE = 'd2;

  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input			clk;			// To buff0 of renkon_mem_linebuf.v, ...
  // End of automatics
  input xrst;
  input buf_en;
  input [LWIDTH-1:0] img_size;
  input [LWIDTH-1:0] fil_size;
  input signed [DWIDTH-1:0] buf_input;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] buf_output0_0;
  output signed [DWIDTH-1:0] buf_output0_1;
  output signed [DWIDTH-1:0] buf_output0_2;
  output signed [DWIDTH-1:0] buf_output0_3;
  output signed [DWIDTH-1:0] buf_output0_4;
  output signed [DWIDTH-1:0] buf_output1_0;
  output signed [DWIDTH-1:0] buf_output1_1;
  output signed [DWIDTH-1:0] buf_output1_2;
  output signed [DWIDTH-1:0] buf_output1_3;
  output signed [DWIDTH-1:0] buf_output1_4;
  output signed [DWIDTH-1:0] buf_output2_0;
  output signed [DWIDTH-1:0] buf_output2_1;
  output signed [DWIDTH-1:0] buf_output2_2;
  output signed [DWIDTH-1:0] buf_output2_3;
  output signed [DWIDTH-1:0] buf_output2_4;
  output signed [DWIDTH-1:0] buf_output3_0;
  output signed [DWIDTH-1:0] buf_output3_1;
  output signed [DWIDTH-1:0] buf_output3_2;
  output signed [DWIDTH-1:0] buf_output3_3;
  output signed [DWIDTH-1:0] buf_output3_4;
  output signed [DWIDTH-1:0] buf_output4_0;
  output signed [DWIDTH-1:0] buf_output4_1;
  output signed [DWIDTH-1:0] buf_output4_2;
  output signed [DWIDTH-1:0] buf_output4_3;
  output signed [DWIDTH-1:0] buf_output4_4;

  /*AUTOWIRE*/
  wire                      s_charge_end;
  wire                      s_active_end;
  wire [8-1:0]              mem_linebuf_we;
  wire [_BUFSIZE-1:0]          mem_linebuf_addr;
  wire signed [DWIDTH-1:0]  read_mem0;
  wire signed [DWIDTH-1:0]  read_mem1;
  wire signed [DWIDTH-1:0]  read_mem2;
  wire signed [DWIDTH-1:0]  read_mem3;
  wire signed [DWIDTH-1:0]  read_mem4;
  wire signed [DWIDTH-1:0]  read_mem5;

  /*AUTOREG*/
  reg [4-1:0]             r_select;
  reg [2-1:0]             r_state;
  reg [_BUFSIZE-1:0]         r_addr_count;
  reg [3-1:0]             r_mem_count;
  reg [LWIDTH-1:0]        r_line_count;
  reg [8-1:0]             r_linebuf_we;
  reg signed [DWIDTH-1:0] r_buf_input;
  reg signed [DWIDTH-1:0] r_pixel0_0;
  reg signed [DWIDTH-1:0] r_pixel0_1;
  reg signed [DWIDTH-1:0] r_pixel0_2;
  reg signed [DWIDTH-1:0] r_pixel0_3;
  reg signed [DWIDTH-1:0] r_pixel0_4;
  reg signed [DWIDTH-1:0] r_pixel1_0;
  reg signed [DWIDTH-1:0] r_pixel1_1;
  reg signed [DWIDTH-1:0] r_pixel1_2;
  reg signed [DWIDTH-1:0] r_pixel1_3;
  reg signed [DWIDTH-1:0] r_pixel1_4;
  reg signed [DWIDTH-1:0] r_pixel2_0;
  reg signed [DWIDTH-1:0] r_pixel2_1;
  reg signed [DWIDTH-1:0] r_pixel2_2;
  reg signed [DWIDTH-1:0] r_pixel2_3;
  reg signed [DWIDTH-1:0] r_pixel2_4;
  reg signed [DWIDTH-1:0] r_pixel3_0;
  reg signed [DWIDTH-1:0] r_pixel3_1;
  reg signed [DWIDTH-1:0] r_pixel3_2;
  reg signed [DWIDTH-1:0] r_pixel3_3;
  reg signed [DWIDTH-1:0] r_pixel3_4;
  reg signed [DWIDTH-1:0] r_pixel4_0;
  reg signed [DWIDTH-1:0] r_pixel4_1;
  reg signed [DWIDTH-1:0] r_pixel4_2;
  reg signed [DWIDTH-1:0] r_pixel4_3;
  reg signed [DWIDTH-1:0] r_pixel4_4;

  assign mem_linebuf_addr = r_addr_count;

  assign mem_linebuf_we = (r_state == S_CHARGE || r_state == S_ACTIVE)
                        ? (1 << r_mem_count)
                        : 1'b0;

  assign buf_output0_0 = r_pixel0_0;
  assign buf_output0_1 = r_pixel0_1;
  assign buf_output0_2 = r_pixel0_2;
  assign buf_output0_3 = r_pixel0_3;
  assign buf_output0_4 = r_pixel0_4;
  assign buf_output1_0 = r_pixel1_0;
  assign buf_output1_1 = r_pixel1_1;
  assign buf_output1_2 = r_pixel1_2;
  assign buf_output1_3 = r_pixel1_3;
  assign buf_output1_4 = r_pixel1_4;
  assign buf_output2_0 = r_pixel2_0;
  assign buf_output2_1 = r_pixel2_1;
  assign buf_output2_2 = r_pixel2_2;
  assign buf_output2_3 = r_pixel2_3;
  assign buf_output2_4 = r_pixel2_4;
  assign buf_output3_0 = r_pixel3_0;
  assign buf_output3_1 = r_pixel3_1;
  assign buf_output3_2 = r_pixel3_2;
  assign buf_output3_3 = r_pixel3_3;
  assign buf_output3_4 = r_pixel3_4;
  assign buf_output4_0 = r_pixel4_0;
  assign buf_output4_1 = r_pixel4_1;
  assign buf_output4_2 = r_pixel4_2;
  assign buf_output4_3 = r_pixel4_3;
  assign buf_output4_4 = r_pixel4_4;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_state <= S_WAIT;
    else
      case (r_state)
        S_WAIT:
          if (buf_en)
            r_state <= S_CHARGE;
        S_CHARGE:
          if (s_charge_end)
            r_state <= S_ACTIVE;
        S_ACTIVE:
          if (s_active_end)
            r_state <= S_WAIT;
        default:
          r_state <= S_WAIT;
      endcase

  assign s_charge_end = r_mem_count == fil_size - 1
                        && r_addr_count == img_size - 1;

  assign s_active_end = r_line_count == img_size
                        && r_addr_count == img_size - 1;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_buf_input <= 0;
    else
      r_buf_input <= buf_input;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_addr_count <= 0;
    else if (r_state == S_WAIT)
      r_addr_count <= 0;
    else if (r_state == S_CHARGE || r_state == S_ACTIVE)
      if (r_addr_count == img_size - 1)
        r_addr_count <= 0;
      else
        r_addr_count <= r_addr_count + 1;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_mem_count <= 0;
    else if  (r_state == S_WAIT)
      r_mem_count <= 0;
    else if (r_state == S_CHARGE || r_state == S_ACTIVE)
      if ((r_line_count == img_size || r_mem_count == 5)
            && r_addr_count == img_size - 1)
        r_mem_count <= 0;
      else if (r_addr_count == img_size - 1)
        r_mem_count <= r_mem_count + 1;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_line_count <= 0;
    else if  (r_state == S_WAIT)
      r_line_count <= 0;
    else if (r_state == S_CHARGE || r_state == S_ACTIVE)
      if (r_line_count == img_size && r_addr_count == img_size - 1)
        r_line_count <= 0;
      else if (r_addr_count == img_size - 1)
        r_line_count <= r_line_count + 1;

  always @(posedge clk)
    if (!xrst)
      r_select <= 0;
    else if (r_state == S_WAIT)
      r_select <= 0;
    else if (r_state == S_ACTIVE)
      if (r_mem_count == fil_size && r_addr_count == 0)
        r_select <= 1;
      else if (r_addr_count == 0)
        r_select <= r_select+1;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel0_0 <= 0;
    else
      r_pixel0_0 <= r_pixel0_1;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel0_1 <= 0;
    else
      r_pixel0_1 <= r_pixel0_2;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel0_2 <= 0;
    else
      r_pixel0_2 <= r_pixel0_3;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel0_3 <= 0;
    else
      r_pixel0_3 <= r_pixel0_4;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel0_4 <= 0;
    else
      case (r_select)
        4'd0:    r_pixel0_4 <= 0;
        4'd1:    r_pixel0_4 <= read_mem0;
        4'd2:    r_pixel0_4 <= read_mem1;
        4'd3:    r_pixel0_4 <= read_mem2;
        4'd4:    r_pixel0_4 <= read_mem3;
        4'd5:    r_pixel0_4 <= read_mem4;
        4'd6:    r_pixel0_4 <= read_mem5;
        default: r_pixel0_4 <= 0;
      endcase

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel1_0 <= 0;
    else
      r_pixel1_0 <= r_pixel1_1;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel1_1 <= 0;
    else
      r_pixel1_1 <= r_pixel1_2;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel1_2 <= 0;
    else
      r_pixel1_2 <= r_pixel1_3;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel1_3 <= 0;
    else
      r_pixel1_3 <= r_pixel1_4;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel1_4 <= 0;
    else
      case (r_select)
        4'd0:    r_pixel1_4 <= 0;
        4'd1:    r_pixel1_4 <= read_mem1;
        4'd2:    r_pixel1_4 <= read_mem2;
        4'd3:    r_pixel1_4 <= read_mem3;
        4'd4:    r_pixel1_4 <= read_mem4;
        4'd5:    r_pixel1_4 <= read_mem5;
        4'd6:    r_pixel1_4 <= read_mem0;
        default: r_pixel1_4 <= 0;
      endcase

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel2_0 <= 0;
    else
      r_pixel2_0 <= r_pixel2_1;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel2_1 <= 0;
    else
      r_pixel2_1 <= r_pixel2_2;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel2_2 <= 0;
    else
      r_pixel2_2 <= r_pixel2_3;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel2_3 <= 0;
    else
      r_pixel2_3 <= r_pixel2_4;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel2_4 <= 0;
    else
      case (r_select)
        4'd0:    r_pixel2_4 <= 0;
        4'd1:    r_pixel2_4 <= read_mem2;
        4'd2:    r_pixel2_4 <= read_mem3;
        4'd3:    r_pixel2_4 <= read_mem4;
        4'd4:    r_pixel2_4 <= read_mem5;
        4'd5:    r_pixel2_4 <= read_mem0;
        4'd6:    r_pixel2_4 <= read_mem1;
        default: r_pixel2_4 <= 0;
      endcase

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel3_0 <= 0;
    else
      r_pixel3_0 <= r_pixel3_1;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel3_1 <= 0;
    else
      r_pixel3_1 <= r_pixel3_2;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel3_2 <= 0;
    else
      r_pixel3_2 <= r_pixel3_3;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel3_3 <= 0;
    else
      r_pixel3_3 <= r_pixel3_4;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel3_4 <= 0;
    else
      case (r_select)
        4'd0:    r_pixel3_4 <= 0;
        4'd1:    r_pixel3_4 <= read_mem3;
        4'd2:    r_pixel3_4 <= read_mem4;
        4'd3:    r_pixel3_4 <= read_mem5;
        4'd4:    r_pixel3_4 <= read_mem0;
        4'd5:    r_pixel3_4 <= read_mem1;
        4'd6:    r_pixel3_4 <= read_mem2;
        default: r_pixel3_4 <= 0;
      endcase

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel4_0 <= 0;
    else
      r_pixel4_0 <= r_pixel4_1;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel4_1 <= 0;
    else
      r_pixel4_1 <= r_pixel4_2;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel4_2 <= 0;
    else
      r_pixel4_2 <= r_pixel4_3;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel4_3 <= 0;
    else
      r_pixel4_3 <= r_pixel4_4;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_pixel4_4 <= 0;
    else
      case (r_select)
        4'd0:    r_pixel4_4 <= 0;
        4'd1:    r_pixel4_4 <= read_mem4;
        4'd2:    r_pixel4_4 <= read_mem5;
        4'd3:    r_pixel4_4 <= read_mem0;
        4'd4:    r_pixel4_4 <= read_mem1;
        4'd5:    r_pixel4_4 <= read_mem2;
        4'd6:    r_pixel4_4 <= read_mem3;
        default: r_pixel4_4 <= 0;
      endcase


  /* renkon_mem_linebuf AUTO_TEMPLATE (
      .mem_we     (mem_linebuf_we[0]),
      .mem_addr   (mem_linebuf_addr[_BUFSIZE-1:0]),
      .write_data (r_buf_input[DWIDTH-1:0]),
      .read_data  (read_mem0[DWIDTH-1:0]),
  ); */
  renkon_mem_linebuf buff0(/*AUTOINST*/
			   // Outputs
			   .read_data		(read_mem0[DWIDTH-1:0]), // Templated
			   // Inputs
			   .clk			(clk),
			   .mem_we		(mem_linebuf_we[0]), // Templated
			   .mem_addr		(mem_linebuf_addr[_BUFSIZE-1:0]), // Templated
			   .write_data		(r_buf_input[DWIDTH-1:0])); // Templated

  /* renkon_mem_linebuf AUTO_TEMPLATE (
      .mem_we     (mem_linebuf_we[1]),
      .mem_addr   (mem_linebuf_addr[_BUFSIZE-1:0]),
      .write_data (r_buf_input[DWIDTH-1:0]),
      .read_data  (read_mem1[DWIDTH-1:0]),
  ); */
  renkon_mem_linebuf buff1(/*AUTOINST*/
			   // Outputs
			   .read_data		(read_mem1[DWIDTH-1:0]), // Templated
			   // Inputs
			   .clk			(clk),
			   .mem_we		(mem_linebuf_we[1]), // Templated
			   .mem_addr		(mem_linebuf_addr[_BUFSIZE-1:0]), // Templated
			   .write_data		(r_buf_input[DWIDTH-1:0])); // Templated

  /* renkon_mem_linebuf AUTO_TEMPLATE (
      .mem_we     (mem_linebuf_we[2]),
      .mem_addr   (mem_linebuf_addr[_BUFSIZE-1:0]),
      .write_data (r_buf_input[DWIDTH-1:0]),
      .read_data  (read_mem2[DWIDTH-1:0]),
  ); */
  renkon_mem_linebuf buff2(/*AUTOINST*/
			   // Outputs
			   .read_data		(read_mem2[DWIDTH-1:0]), // Templated
			   // Inputs
			   .clk			(clk),
			   .mem_we		(mem_linebuf_we[2]), // Templated
			   .mem_addr		(mem_linebuf_addr[_BUFSIZE-1:0]), // Templated
			   .write_data		(r_buf_input[DWIDTH-1:0])); // Templated

  /* renkon_mem_linebuf AUTO_TEMPLATE (
      .mem_we     (mem_linebuf_we[3]),
      .mem_addr   (mem_linebuf_addr[_BUFSIZE-1:0]),
      .write_data (r_buf_input[DWIDTH-1:0]),
      .read_data  (read_mem3[DWIDTH-1:0]),
  ); */
  renkon_mem_linebuf buff3(/*AUTOINST*/
			   // Outputs
			   .read_data		(read_mem3[DWIDTH-1:0]), // Templated
			   // Inputs
			   .clk			(clk),
			   .mem_we		(mem_linebuf_we[3]), // Templated
			   .mem_addr		(mem_linebuf_addr[_BUFSIZE-1:0]), // Templated
			   .write_data		(r_buf_input[DWIDTH-1:0])); // Templated

  /* renkon_mem_linebuf AUTO_TEMPLATE (
      .mem_we     (mem_linebuf_we[4]),
      .mem_addr   (mem_linebuf_addr[_BUFSIZE-1:0]),
      .write_data (r_buf_input[DWIDTH-1:0]),
      .read_data  (read_mem4[DWIDTH-1:0]),
  ); */
  renkon_mem_linebuf buff4(/*AUTOINST*/
			   // Outputs
			   .read_data		(read_mem4[DWIDTH-1:0]), // Templated
			   // Inputs
			   .clk			(clk),
			   .mem_we		(mem_linebuf_we[4]), // Templated
			   .mem_addr		(mem_linebuf_addr[_BUFSIZE-1:0]), // Templated
			   .write_data		(r_buf_input[DWIDTH-1:0])); // Templated

  /* renkon_mem_linebuf AUTO_TEMPLATE (
      .mem_we     (mem_linebuf_we[5]),
      .mem_addr   (mem_linebuf_addr[_BUFSIZE-1:0]),
      .write_data (r_buf_input[DWIDTH-1:0]),
      .read_data  (read_mem5[DWIDTH-1:0]),
  ); */
  renkon_mem_linebuf buff5(/*AUTOINST*/
			   // Outputs
			   .read_data		(read_mem5[DWIDTH-1:0]), // Templated
			   // Inputs
			   .clk			(clk),
			   .mem_we		(mem_linebuf_we[5]), // Templated
			   .mem_addr		(mem_linebuf_addr[_BUFSIZE-1:0]), // Templated
			   .write_data		(r_buf_input[DWIDTH-1:0])); // Templated


endmodule
