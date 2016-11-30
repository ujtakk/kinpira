
module gobou_ctrl_core(/*AUTOARG*/
   // Outputs
   ack, out_begin, out_valid, out_end, mem_img_we, mem_img_addr,
   write_mem_img, mem_net_we, mem_net_addr, breg_we, serial_we,
   // Inputs
   clk, xrst, req, in_begin, in_valid, in_end, img_we, input_addr,
   output_addr, write_img, write_result, net_we, net_addr, total_out,
   total_in
   );
`include "gobou.vh"

  parameter S_WAIT    = 'd0;
  parameter S_WEIGHT  = 'd1;
  parameter S_BIAS    = 'd2;
  parameter S_OUTPUT  = 'd3;

  /*AUTOINPUT*/
  input                     clk;
  input                     xrst;
  input                     req;
  input                     in_begin;
  input                     in_valid;
  input                     in_end;
  input                     img_we;
  input [IMGSIZE-1:0]       input_addr;
  input [IMGSIZE-1:0]       output_addr;
  input signed [DWIDTH-1:0] write_img;
  input signed [DWIDTH-1:0] write_result;
  input [CORELOG:0]         net_we;
  input [NETSIZE-1:0]       net_addr;
  input [LWIDTH-1:0]        total_out;
  input [LWIDTH-1:0]        total_in;

  /*AUTOOUTPUT*/
  output                      ack;
  output                      out_begin;
  output                      out_valid;
  output                      out_end;
  output                      mem_img_we;
  output [IMGSIZE-1:0]        mem_img_addr;
  output signed [DWIDTH-1:0]  write_mem_img;
  output [CORE-1:0]           mem_net_we;
  output [NETSIZE-1:0]        mem_net_addr;
  output                      breg_we;
  output                      serial_we;

  /*AUTOWIRE*/
  wire                s_weight_end;
  wire                s_bias_end;
  wire                s_output_end;
  wire                final_iter;
  wire [IMGSIZE-1:0]  w_img_addr;
  wire [IMGSIZE-1:0]  w_img_offset;

  /*AUTOREG*/
  reg [2-1:0]       r_state;
  reg               r_ack;
  reg [LWIDTH-1:0]  r_total_out;
  reg [LWIDTH-1:0]  r_total_in;
  reg [LWIDTH-1:0]  r_count_out;
  reg [LWIDTH-1:0]  r_count_in;
  reg               r_img_we;
  reg [IMGSIZE-1:0] r_input_offset;
  reg [IMGSIZE-1:0] r_output_offset;
  reg [IMGSIZE-1:0] r_input_addr;
  reg [IMGSIZE-1:0] r_output_addr;
  reg [CORE-1:0]    r_net_we;
  reg [NETSIZE-1:0] r_net_addr;
  reg [NETSIZE-1:0] r_net_offset;
  reg               r_breg_we;
  reg               r_serial_we;
  reg [LWIDTH-1:0]  r_serial_cnt;
  reg               r_out_begin;
  reg               r_out_valid;
  reg               r_out_end;

  assign final_iter = r_count_in == r_total_in - 1
                   && r_count_out >= r_total_out - CORE;

  always @(posedge clk)
    if (!xrst)
    begin
      r_state <= S_WAIT;
      r_count_out <= 0;
      r_count_in <= 0;
    end
    else
      case (r_state)
        S_WAIT:
          if (req)
            r_state <= S_WEIGHT;

        S_WEIGHT:
          if (s_weight_end)
          begin
            r_state <= S_BIAS;
            r_count_in <= 0;
          end
          else
            r_count_in <= r_count_in + 1;

        S_BIAS:
          if (s_bias_end)
            r_state <= S_OUTPUT;

        S_OUTPUT:
          if (s_output_end)
            if (r_count_out >= r_total_out - CORE)
            begin
              r_state <= S_WAIT;
              r_count_out <= 0;
            end
            else
            begin
              r_state <= S_WEIGHT;
              r_count_out <= r_count_out + CORE;
            end

        default:
          r_state <= S_WAIT;
      endcase

  always @(posedge clk)
    if (!xrst)
    begin
      r_total_in    <= 0;
      r_total_out   <= 0;
    end
    else if (r_state == S_WAIT && req)
    begin
      r_total_in    <= total_in;
      r_total_out   <= total_out;
    end

//==========================================================
// image control
//==========================================================

  assign mem_img_we = r_img_we;

  always @(posedge clk)
    if (!xrst)
      r_img_we <= 0;
    else
      case (r_state)
        S_WAIT:
          r_img_we <= img_we;
        S_OUTPUT:
          r_img_we <= r_serial_we
                   || (0 < r_serial_cnt && r_serial_cnt < CORE);
        default:
          r_img_we <= 0;
      endcase

  assign mem_img_addr = w_img_addr + w_img_offset;

  assign write_mem_img = r_state == S_OUTPUT
                       ? write_result
                       : write_img;

  assign w_img_addr = r_state == S_OUTPUT
                    ? r_output_addr
                    : r_input_addr;

  assign w_img_offset = r_state == S_OUTPUT
                      ? r_output_offset
                      : r_input_offset;

  always @(posedge clk)
    if (!xrst)
      r_input_addr <= 0;
    else if (r_state == S_BIAS)
      r_input_addr <= 0;
    else if (r_state == S_WEIGHT && !s_weight_end)
      r_input_addr <= r_input_addr + 1;

  always @(posedge clk)
    if (!xrst)
      r_output_addr <= 0;
    else if (ack)
      r_output_addr <= 0;
    else if (r_img_we)
      r_output_addr <= r_output_addr + 1;

  always @(posedge clk)
    if (!xrst)
    begin
      r_input_offset <= 0;
      r_output_offset <= 0;
    end
    else if (req || ack)
    begin
      r_input_offset <= input_addr;
      r_output_offset <= output_addr;
    end

//==========================================================
// network control
//==========================================================

  assign s_weight_end = r_state == S_WEIGHT && r_count_in == r_total_in - 1;
  assign s_bias_end   = r_state == S_BIAS;

  assign mem_net_we   = r_net_we;
  assign mem_net_addr = r_net_addr + r_net_offset;
  assign breg_we      = r_breg_we;

  always @(posedge clk)
    if (!xrst)
      r_net_we <= 0;
    else
      case (net_we)
        5'd0:    r_net_we <= 16'b0000000000000000;
        5'd1:    r_net_we <= 16'b0000000000000001;
        5'd2:    r_net_we <= 16'b0000000000000010;
        5'd3:    r_net_we <= 16'b0000000000000100;
        5'd4:    r_net_we <= 16'b0000000000001000;
        5'd5:    r_net_we <= 16'b0000000000010000;
        5'd6:    r_net_we <= 16'b0000000000100000;
        5'd7:    r_net_we <= 16'b0000000001000000;
        5'd8:    r_net_we <= 16'b0000000010000000;
        5'd9:    r_net_we <= 16'b0000000100000000;
        5'd10:    r_net_we <= 16'b0000001000000000;
        5'd11:    r_net_we <= 16'b0000010000000000;
        5'd12:    r_net_we <= 16'b0000100000000000;
        5'd13:    r_net_we <= 16'b0001000000000000;
        5'd14:    r_net_we <= 16'b0010000000000000;
        5'd15:    r_net_we <= 16'b0100000000000000;
        5'd16:    r_net_we <= 16'b1000000000000000;
        default: r_net_we <= 16'b0000000000000000;
      endcase

  always @(posedge clk)
    if (!xrst)
      r_net_addr <= 0;
    else if (final_iter)
      r_net_addr <= 0;
    else if (r_state == S_WEIGHT)
      r_net_addr <= r_net_addr + 1;
    else if (r_state == S_BIAS)
      r_net_addr <= r_net_addr + 1;

  always @(posedge clk)
    if (!xrst)
      r_net_offset <= 0;
    else if (req || ack)
      r_net_offset <= net_addr;

  always @(posedge clk)
    if (!xrst)
      r_breg_we <= 0;
    else
      r_breg_we <= r_state == S_BIAS;

//==========================================================
// output control
//==========================================================

  assign s_output_end = r_state == S_OUTPUT && r_serial_cnt == CORE;

  assign out_begin = r_out_begin;
  assign out_valid = r_out_valid;
  assign out_end = r_out_end;

  always @(posedge clk)
    if (!xrst)
      r_out_begin <= 0;
    else
      r_out_begin <= req
                  || s_output_end && (r_count_out < r_total_out - CORE);
  always @(posedge clk)
    if (!xrst)
      r_out_valid <= 0;
    else
      r_out_valid <= (r_state == S_BIAS || r_state == S_WEIGHT);
  always @(posedge clk)
    if (!xrst)
      r_out_end <= 0;
    else
      r_out_end   <= s_bias_end;

  assign ack = r_ack;

  always @(posedge clk)
    if (!xrst)
      r_ack <= 1;
    else if (req)
      r_ack <= 0;
    else if (s_output_end && r_count_out >= r_total_out - CORE)
      r_ack <= 1;

  assign serial_we = r_serial_we;

  always @(posedge clk)
    if (!xrst)
      r_serial_we <= 0;
    else
      r_serial_we <= in_begin;

  always @(posedge clk)
    if (!xrst)
      r_serial_cnt <= 0;
    else if (serial_we)
      r_serial_cnt <= 1;
    else if (r_serial_cnt > 0)
      if (r_serial_cnt == CORE)
        r_serial_cnt <= 0;
      else
        r_serial_cnt <= r_serial_cnt + 1;

endmodule
