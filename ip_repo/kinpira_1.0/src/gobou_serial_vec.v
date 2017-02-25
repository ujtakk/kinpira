
module gobou_serial_vec(/*AUTOARG*/
   // Outputs
   out_data,
   // Inputs
   clk, xrst, serial_we, in_data0, in_data1, in_data2, in_data3,
   in_data4, in_data5, in_data6, in_data7, in_data8, in_data9,
   in_data10, in_data11, in_data12, in_data13, in_data14, in_data15
   );
`include "ninjin.vh"
`include "gobou.vh"

  /*AUTOINPUT*/
  input                     clk;
  input                     xrst;
  input                     serial_we;
  input signed [DWIDTH-1:0] in_data0;
  input signed [DWIDTH-1:0] in_data1;
  input signed [DWIDTH-1:0] in_data2;
  input signed [DWIDTH-1:0] in_data3;
  input signed [DWIDTH-1:0] in_data4;
  input signed [DWIDTH-1:0] in_data5;
  input signed [DWIDTH-1:0] in_data6;
  input signed [DWIDTH-1:0] in_data7;
  input signed [DWIDTH-1:0] in_data8;
  input signed [DWIDTH-1:0] in_data9;
  input signed [DWIDTH-1:0] in_data10;
  input signed [DWIDTH-1:0] in_data11;
  input signed [DWIDTH-1:0] in_data12;
  input signed [DWIDTH-1:0] in_data13;
  input signed [DWIDTH-1:0] in_data14;
  input signed [DWIDTH-1:0] in_data15;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0]  out_data;

  /*AUTOWIRE*/

  /*AUTOREG*/
  reg [LWIDTH-1:0]        r_cnt;
  reg signed [DWIDTH-1:0] r_data0;
  reg signed [DWIDTH-1:0] r_data1;
  reg signed [DWIDTH-1:0] r_data2;
  reg signed [DWIDTH-1:0] r_data3;
  reg signed [DWIDTH-1:0] r_data4;
  reg signed [DWIDTH-1:0] r_data5;
  reg signed [DWIDTH-1:0] r_data6;
  reg signed [DWIDTH-1:0] r_data7;
  reg signed [DWIDTH-1:0] r_data8;
  reg signed [DWIDTH-1:0] r_data9;
  reg signed [DWIDTH-1:0] r_data10;
  reg signed [DWIDTH-1:0] r_data11;
  reg signed [DWIDTH-1:0] r_data12;
  reg signed [DWIDTH-1:0] r_data13;
  reg signed [DWIDTH-1:0] r_data14;
  reg signed [DWIDTH-1:0] r_data15;

  assign out_data = r_data0;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_cnt <= 0;
    else if (serial_we)
      r_cnt <= 1;
    else if (r_cnt > 0)
      if (r_cnt == GOBOU_CORE)
        r_cnt <= 0;
      else
        r_cnt <= r_cnt + 1;

  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data0 <= 0;
    else if (serial_we)
      r_data0 <= in_data0;
    else
      r_data0 <= r_data1;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data1 <= 0;
    else if (serial_we)
      r_data1 <= in_data1;
    else
      r_data1 <= r_data2;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data2 <= 0;
    else if (serial_we)
      r_data2 <= in_data2;
    else
      r_data2 <= r_data3;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data3 <= 0;
    else if (serial_we)
      r_data3 <= in_data3;
    else
      r_data3 <= r_data4;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data4 <= 0;
    else if (serial_we)
      r_data4 <= in_data4;
    else
      r_data4 <= r_data5;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data5 <= 0;
    else if (serial_we)
      r_data5 <= in_data5;
    else
      r_data5 <= r_data6;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data6 <= 0;
    else if (serial_we)
      r_data6 <= in_data6;
    else
      r_data6 <= r_data7;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data7 <= 0;
    else if (serial_we)
      r_data7 <= in_data7;
    else
      r_data7 <= r_data8;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data8 <= 0;
    else if (serial_we)
      r_data8 <= in_data8;
    else
      r_data8 <= r_data9;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data9 <= 0;
    else if (serial_we)
      r_data9 <= in_data9;
    else
      r_data9 <= r_data10;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data10 <= 0;
    else if (serial_we)
      r_data10 <= in_data10;
    else
      r_data10 <= r_data11;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data11 <= 0;
    else if (serial_we)
      r_data11 <= in_data11;
    else
      r_data11 <= r_data12;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data12 <= 0;
    else if (serial_we)
      r_data12 <= in_data12;
    else
      r_data12 <= r_data13;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data13 <= 0;
    else if (serial_we)
      r_data13 <= in_data13;
    else
      r_data13 <= r_data14;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data14 <= 0;
    else if (serial_we)
      r_data14 <= in_data14;
    else
      r_data14 <= r_data15;
  always @(posedge clk or negedge xrst)
    if (!xrst)
      r_data15 <= 0;
    else if (serial_we)
      r_data15 <= in_data15;
    else
      r_data15 <= 0;

endmodule
