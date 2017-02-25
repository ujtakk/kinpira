
module renkon_ctrl_conv(/*AUTOARG*/
   // Outputs
   out_begin, out_valid, out_end, mem_feat_we, mem_feat_rst,
   mem_feat_addr, mem_feat_addr_d1, conv_oe, w_fea_size,
   // Inputs
   clk, xrst, in_begin, in_valid, in_end, core_state, w_img_size,
   w_fil_size, first_input, last_input
   );
`include "ninjin.vh"
`include "renkon.vh"

  parameter S_CORE_WAIT     = 'd0;
  parameter S_CORE_NETWORK  = 'd1;
  parameter S_CORE_INPUT    = 'd2;
  parameter S_CORE_OUTPUT   = 'd3;

  parameter S_WAIT        = 'd0;
  parameter S_ACTIVE      = 'd1;

  /*AUTOINPUT*/
  input               clk;
  input               xrst;
  input               in_begin;
  input               in_valid;
  input               in_end;
  input [2-1:0]       core_state;
  input [LWIDTH-1:0]  w_img_size;
  input [LWIDTH-1:0]  w_fil_size;
  input               first_input;
  input               last_input;

  /*AUTOOUTPUT*/
  output              out_begin;
  output              out_valid;
  output              out_end;
  output              mem_feat_we;
  output              mem_feat_rst;
  output [FACCUM-1:0] mem_feat_addr;
  output [FACCUM-1:0] mem_feat_addr_d1;
  output              conv_oe;
  output [LWIDTH-1:0] w_fea_size;

  /*AUTOWIRE*/
  wire conv_begin;
  wire conv_vaild;
  wire conv_end;

  /*AUTOREG*/
  reg               r_state;
  reg [2-1:0]       r_core_state;
  reg [LWIDTH-1:0]  r_img_size;
  reg [LWIDTH-1:0]  r_fil_size;
  reg [LWIDTH-1:0]  r_fea_size;
  reg [LWIDTH-1:0]  r_conv_x;
  reg [LWIDTH-1:0]  r_conv_y;
  reg               r_first_input;
  reg               r_last_input;
  reg               r_conv_begin;
  reg               r_conv_valid;
  reg               r_conv_end;
  reg               r_out_begin;
  reg               r_out_valid;
  reg               r_out_end;
  reg               r_feat_we_d0;
  reg               r_feat_rst_d0;
  reg               r_feat_we_d1;
  reg               r_feat_rst_d1;
  reg               r_feat_we_d2;
  reg               r_feat_rst_d2;
  reg               r_feat_we_d3;
  reg               r_feat_rst_d3;
  reg               r_feat_we_d4;
  reg               r_feat_rst_d4;
  reg               r_out_begin_d0;
  reg               r_out_valid_d0;
  reg               r_out_end_d0;
  reg               r_out_begin_d1;
  reg               r_out_valid_d1;
  reg               r_out_end_d1;
  reg               r_out_begin_d2;
  reg               r_out_valid_d2;
  reg               r_out_end_d2;
  reg               r_out_begin_d3;
  reg               r_out_valid_d3;
  reg               r_out_end_d3;
  reg               r_out_begin_d4;
  reg               r_out_valid_d4;
  reg               r_out_end_d4;
  reg               r_out_begin_d5;
  reg               r_out_valid_d5;
  reg               r_out_end_d5;
  reg [FACCUM-1:0]  r_feat_addr_d0;
  reg [FACCUM-1:0]  r_feat_addr_d1;
  reg [FACCUM-1:0]  r_feat_addr_d2;
  reg [FACCUM-1:0]  r_feat_addr_d3;
  reg [FACCUM-1:0]  r_feat_addr_d4;
  reg [FACCUM-1:0]  r_feat_addr_d5;
  reg               r_wait_back;

//==========================================================
// main FSM
//==========================================================

  always @(posedge clk)
    if (!xrst)
      r_state <= S_WAIT;
    else
      case (r_state)
        S_WAIT:
          if (in_begin)
            r_state <= S_ACTIVE;
        S_ACTIVE:
          if (out_end)
            r_state <= S_WAIT;
      endcase

  always @(posedge clk)
    if (!xrst)
      r_core_state <= S_CORE_WAIT;
    else
      r_core_state <= core_state;

  assign w_fea_size = r_fea_size;

  always @(posedge clk)
    if (!xrst)
    begin
      r_img_size  <= 0;
      r_fil_size  <= 0;
      r_fea_size  <= 0;
    end
    else if (r_state == S_WAIT && in_begin)
    begin
      r_img_size  <= w_img_size;
      r_fil_size  <= w_fil_size;
      r_fea_size  <= w_img_size - w_fil_size + 1;
    end

  always @(posedge clk)
    if (!xrst)
    begin
      r_conv_x <= 0;
      r_conv_y <= 0;
    end
    else
      case (r_state)
        S_WAIT:
        begin
          r_conv_x <= 0;
          r_conv_y <= 0;
        end

        S_ACTIVE:
          if (r_core_state == S_CORE_INPUT && in_valid)
            if (r_conv_x == r_img_size - 1)
            begin
              r_conv_x <= 0;
              if (r_conv_y == r_img_size - 1)
                r_conv_y <= 0;
              else
                r_conv_y <= r_conv_y + 1;
            end
            else
              r_conv_x <= r_conv_x + 1;

          else if (r_core_state == S_CORE_OUTPUT && !r_wait_back)
            if (r_conv_x == r_fea_size - 1)
            begin
              r_conv_x <= 0;
              if (r_conv_y == r_fea_size - 1)
                r_conv_y <= 0;
              else
                r_conv_y <= r_conv_y + 1;
            end
            else
              r_conv_x <= r_conv_x + 1;
      endcase

//==========================================================
// conv control
//==========================================================

  assign conv_begin = r_conv_begin;
  assign conv_valid = r_conv_valid;
  assign conv_end   = r_conv_end;

  always @(posedge clk)
    if (!xrst)
    begin
      r_conv_begin <= 0;
      r_conv_valid <= 0;
      r_conv_end   <= 0;
    end
    else
    begin
      r_conv_begin <= (r_state == S_ACTIVE)
                        && (r_core_state == S_CORE_INPUT)
                        && r_conv_x == r_fil_size - 2
                        && r_conv_y == r_fil_size - 1;
      r_conv_valid <= (r_state == S_ACTIVE)
                        && (r_core_state == S_CORE_INPUT)
                        && r_conv_x >= r_fil_size - 1
                        && r_conv_y >= r_fil_size - 1;
      r_conv_end   <= (r_state == S_ACTIVE)
                        && (r_core_state == S_CORE_INPUT)
                        && r_conv_x == r_img_size - 1
                        && r_conv_y == r_img_size - 1;
    end

  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input <= 0;
      r_last_input  <= 0;
    end
    else
    begin
      r_first_input <= first_input;
      r_last_input  <= last_input;
    end

//==========================================================
// feat-accum control
//==========================================================

  assign mem_feat_we      = r_feat_we_d4;
  assign mem_feat_rst     = r_feat_rst_d4;
  assign mem_feat_addr    = r_feat_addr_d4;
  assign mem_feat_addr_d1 = r_feat_addr_d5;

  always @(posedge clk)
    if (!xrst)
      r_feat_we_d0 <= 0;
    else
      r_feat_we_d0 <= conv_valid;
  always @(posedge clk)
    if (!xrst)
      r_feat_we_d1 <= 0;
    else
      r_feat_we_d1 <= r_feat_we_d0;
  always @(posedge clk)
    if (!xrst)
      r_feat_we_d2 <= 0;
    else
      r_feat_we_d2 <= r_feat_we_d1;
  always @(posedge clk)
    if (!xrst)
      r_feat_we_d3 <= 0;
    else
      r_feat_we_d3 <= r_feat_we_d2;
  always @(posedge clk)
    if (!xrst)
      r_feat_we_d4 <= 0;
    else
      r_feat_we_d4 <= r_feat_we_d3;

  always @(posedge clk)
    if (!xrst)
      r_feat_rst_d0 <= 0;
    else
      r_feat_rst_d0 <= conv_valid && r_first_input;
  always @(posedge clk)
    if (!xrst)
      r_feat_rst_d1 <= 0;
    else
      r_feat_rst_d1 <= r_feat_rst_d0;
  always @(posedge clk)
    if (!xrst)
      r_feat_rst_d2 <= 0;
    else
      r_feat_rst_d2 <= r_feat_rst_d1;
  always @(posedge clk)
    if (!xrst)
      r_feat_rst_d3 <= 0;
    else
      r_feat_rst_d3 <= r_feat_rst_d2;
  always @(posedge clk)
    if (!xrst)
      r_feat_rst_d4 <= 0;
    else
      r_feat_rst_d4 <= r_feat_rst_d3;

  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d0 <= 0;
    else if (conv_end || r_wait_back)
      r_feat_addr_d0 <= 0;
    else if (conv_valid
              || (r_core_state == S_CORE_OUTPUT
                    && r_conv_x <= r_fea_size - 1
                    && r_conv_y <= r_fea_size - 1))
      r_feat_addr_d0 <= r_feat_addr_d0 + 1;
  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d1 <= 0;
    else
      r_feat_addr_d1 <= r_feat_addr_d0;
  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d2 <= 0;
    else
      r_feat_addr_d2 <= r_feat_addr_d1;
  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d3 <= 0;
    else
      r_feat_addr_d3 <= r_feat_addr_d2;
  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d4 <= 0;
    else
      r_feat_addr_d4 <= r_feat_addr_d3;
  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d5 <= 0;
    else
      r_feat_addr_d5 <= r_feat_addr_d4;

//==========================================================
// output control
//==========================================================

  assign out_begin  = r_out_begin_d5;
  assign out_valid  = r_out_valid_d5;
  assign out_end    = r_out_end_d5;

  assign conv_oe    = r_out_valid_d4;

  always @(posedge clk)
    if (!xrst)
    begin
      r_out_begin <= 0;
      r_out_valid <= 0;
      r_out_end   <= 0;
    end
    else
    begin
      r_out_begin <= (r_state == S_ACTIVE)
                        && (r_core_state == S_CORE_INPUT)
                        && r_last_input
                        && r_conv_x == r_img_size - 1
                        && r_conv_y == r_img_size - 1;
      r_out_valid <= (r_state == S_ACTIVE)
                        && (r_core_state == S_CORE_OUTPUT)
                        && r_conv_x <= r_fea_size - 1
                        && r_conv_y <= r_fea_size - 1
                        && !r_wait_back;
      r_out_end   <= (r_state == S_ACTIVE)
                        && (r_core_state == S_CORE_OUTPUT)
                        && r_conv_x == r_fea_size - 1
                        && r_conv_y == r_fea_size - 1;
    end

  always @(posedge clk)
    if (!xrst)
      r_out_begin_d0 <= 0;
    else
      r_out_begin_d0 <= r_out_begin;
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d1 <= 0;
    else
      r_out_begin_d1 <= r_out_begin_d0;
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d2 <= 0;
    else
      r_out_begin_d2 <= r_out_begin_d1;
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d3 <= 0;
    else
      r_out_begin_d3 <= r_out_begin_d2;
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d4 <= 0;
    else
      r_out_begin_d4 <= r_out_begin_d3;
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d5 <= 0;
    else
      r_out_begin_d5 <= r_out_begin_d4;
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d0 <= 0;
    else
      r_out_valid_d0 <= r_out_valid;
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d1 <= 0;
    else
      r_out_valid_d1 <= r_out_valid_d0;
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d2 <= 0;
    else
      r_out_valid_d2 <= r_out_valid_d1;
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d3 <= 0;
    else
      r_out_valid_d3 <= r_out_valid_d2;
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d4 <= 0;
    else
      r_out_valid_d4 <= r_out_valid_d3;
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d5 <= 0;
    else
      r_out_valid_d5 <= r_out_valid_d4;
  always @(posedge clk)
    if (!xrst)
      r_out_end_d0 <= 0;
    else
      r_out_end_d0 <= r_out_end;
  always @(posedge clk)
    if (!xrst)
      r_out_end_d1 <= 0;
    else
      r_out_end_d1 <= r_out_end_d0;
  always @(posedge clk)
    if (!xrst)
      r_out_end_d2 <= 0;
    else
      r_out_end_d2 <= r_out_end_d1;
  always @(posedge clk)
    if (!xrst)
      r_out_end_d3 <= 0;
    else
      r_out_end_d3 <= r_out_end_d2;
  always @(posedge clk)
    if (!xrst)
      r_out_end_d4 <= 0;
    else
      r_out_end_d4 <= r_out_end_d3;
  always @(posedge clk)
    if (!xrst)
      r_out_end_d5 <= 0;
    else
      r_out_end_d5 <= r_out_end_d4;

  always @(posedge clk)
    if (!xrst)
      r_wait_back <= 0;
    else if (in_begin)
      r_wait_back <= 0;
    else if ((r_state == S_ACTIVE)
                && (r_core_state == S_CORE_OUTPUT)
                && r_conv_x == r_fea_size - 1
                && r_conv_y == r_fea_size - 1)
      r_wait_back <= 1;

endmodule
