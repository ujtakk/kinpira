
module renkon_ctrl_pool(/*AUTOARG*/
   // Outputs
   buf_feat_en, out_begin, out_valid, out_end, pool_oe, w_pool_size,
   // Inputs
   clk, xrst, in_begin, in_valid, in_end, w_fea_size, pool_size
   );
`include "renkon.vh"

  parameter S_WAIT        = 'd0;
  parameter S_ACTIVE      = 'd1;

  /*AUTOINPUT*/
  input               clk;
  input               xrst;
  input               in_begin;
  input               in_valid;
  input               in_end;
  input [LWIDTH-1:0]  w_fea_size;
  input [LWIDTH-1:0]  pool_size;

  /*AUTOOUTPUT*/
  output              buf_feat_en;
  output              out_begin;
  output              out_valid;
  output              out_end;
  output              pool_oe;
  output [LWIDTH-1:0] w_pool_size;

  /*AUTOWIRE*/
  wire pool_begin;
  wire pool_valid;
  wire pool_end;

  /*AUTOREG*/
  reg               r_state;
  reg [LWIDTH-1:0]  r_fea_size;
  reg [LWIDTH-1:0]  r_pool_size;
  reg [LWIDTH-1:0]  r_d_poolbuf;
  reg [LWIDTH-1:0]  r_pool_x;
  reg [LWIDTH-1:0]  r_pool_y;
  reg [LWIDTH-1:0]  r_pool_exec_x;
  reg [LWIDTH-1:0]  r_pool_exec_y;
  reg [32-1:0]  r_pool_begin_d;
  reg [32-1:0]  r_pool_valid_d;
  reg [32-1:0]  r_pool_end_d;
  reg               r_out_begin_d0;
  reg               r_out_valid_d0;
  reg               r_out_end_d0;
  reg               r_out_begin_d1;
  reg               r_out_valid_d1;
  reg               r_out_end_d1;
  reg r_buf_feat_en;

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

  assign w_pool_size = r_pool_size;

  always @(posedge clk)
    if (!xrst)
    begin
      r_fea_size  <= 0;
      r_pool_size <= 0;
      r_d_poolbuf <= 0;
    end
    else if (r_state == S_WAIT && in_begin)
    begin
      r_fea_size  <= w_fea_size;
      r_pool_size <= pool_size;
      r_d_poolbuf <= w_fea_size - pool_size + 8 - 1;
    end

  always @(posedge clk)
    if (!xrst)
    begin
      r_pool_x <= 0;
      r_pool_y <= 0;
      r_pool_exec_x <= 0;
      r_pool_exec_y <= 0;
    end
    else
      case (r_state)
        S_WAIT:
        begin
          r_pool_x <= 0;
          r_pool_y <= 0;
          r_pool_exec_x <= 0;
          r_pool_exec_y <= 0;
        end

        S_ACTIVE:
          if (in_valid)
          begin
            if (r_pool_x == r_fea_size - 1)
            begin
              r_pool_x <= 0;
              if (r_pool_y == r_fea_size - 1)
                r_pool_y <= 0;
              else
                r_pool_y <= r_pool_y + 1;

              if (r_pool_exec_y == r_pool_size - 1)
                r_pool_exec_y <= 0;
              else
                r_pool_exec_y <= r_pool_exec_y + 1;
            end
            else
              r_pool_x <= r_pool_x + 1;

            if (r_pool_exec_x == r_pool_size - 1)
              r_pool_exec_x <= 0;
            else
              r_pool_exec_x <= r_pool_exec_x + 1;
          end
      endcase

//==========================================================
// pool control
//==========================================================

  assign buf_feat_en = r_buf_feat_en;

  always @(posedge clk)
    if (!xrst)
      r_buf_feat_en <= 0;
    else
      r_buf_feat_en <= in_begin;

  assign pool_begin = r_pool_begin_d[r_d_poolbuf];
  assign pool_valid = r_pool_valid_d[r_d_poolbuf];
  assign pool_end   =   r_pool_end_d[r_d_poolbuf];

  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[0] <= 0;
    else
      r_pool_begin_d[0] <= (r_state == S_ACTIVE)
                            && r_pool_x == r_pool_size - 2
                            && r_pool_y == r_pool_size - 1;
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[1] <= 0;
    else
      r_pool_begin_d[1] <= r_pool_begin_d[0];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[2] <= 0;
    else
      r_pool_begin_d[2] <= r_pool_begin_d[1];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[3] <= 0;
    else
      r_pool_begin_d[3] <= r_pool_begin_d[2];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[4] <= 0;
    else
      r_pool_begin_d[4] <= r_pool_begin_d[3];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[5] <= 0;
    else
      r_pool_begin_d[5] <= r_pool_begin_d[4];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[6] <= 0;
    else
      r_pool_begin_d[6] <= r_pool_begin_d[5];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[7] <= 0;
    else
      r_pool_begin_d[7] <= r_pool_begin_d[6];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[8] <= 0;
    else
      r_pool_begin_d[8] <= r_pool_begin_d[7];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[9] <= 0;
    else
      r_pool_begin_d[9] <= r_pool_begin_d[8];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[10] <= 0;
    else
      r_pool_begin_d[10] <= r_pool_begin_d[9];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[11] <= 0;
    else
      r_pool_begin_d[11] <= r_pool_begin_d[10];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[12] <= 0;
    else
      r_pool_begin_d[12] <= r_pool_begin_d[11];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[13] <= 0;
    else
      r_pool_begin_d[13] <= r_pool_begin_d[12];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[14] <= 0;
    else
      r_pool_begin_d[14] <= r_pool_begin_d[13];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[15] <= 0;
    else
      r_pool_begin_d[15] <= r_pool_begin_d[14];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[16] <= 0;
    else
      r_pool_begin_d[16] <= r_pool_begin_d[15];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[17] <= 0;
    else
      r_pool_begin_d[17] <= r_pool_begin_d[16];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[18] <= 0;
    else
      r_pool_begin_d[18] <= r_pool_begin_d[17];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[19] <= 0;
    else
      r_pool_begin_d[19] <= r_pool_begin_d[18];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[20] <= 0;
    else
      r_pool_begin_d[20] <= r_pool_begin_d[19];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[21] <= 0;
    else
      r_pool_begin_d[21] <= r_pool_begin_d[20];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[22] <= 0;
    else
      r_pool_begin_d[22] <= r_pool_begin_d[21];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[23] <= 0;
    else
      r_pool_begin_d[23] <= r_pool_begin_d[22];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[24] <= 0;
    else
      r_pool_begin_d[24] <= r_pool_begin_d[23];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[25] <= 0;
    else
      r_pool_begin_d[25] <= r_pool_begin_d[24];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[26] <= 0;
    else
      r_pool_begin_d[26] <= r_pool_begin_d[25];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[27] <= 0;
    else
      r_pool_begin_d[27] <= r_pool_begin_d[26];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[28] <= 0;
    else
      r_pool_begin_d[28] <= r_pool_begin_d[27];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[29] <= 0;
    else
      r_pool_begin_d[29] <= r_pool_begin_d[28];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[30] <= 0;
    else
      r_pool_begin_d[30] <= r_pool_begin_d[29];
  always @(posedge clk)
    if (!xrst)
      r_pool_begin_d[31] <= 0;
    else
      r_pool_begin_d[31] <= r_pool_begin_d[30];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[0] <= 0;
    else
      r_pool_valid_d[0] <= (r_state == S_ACTIVE)
                            && r_pool_exec_x == r_pool_size - 1
                            && r_pool_exec_y == r_pool_size - 1;
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[1] <= 0;
    else
      r_pool_valid_d[1] <= r_pool_valid_d[0];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[2] <= 0;
    else
      r_pool_valid_d[2] <= r_pool_valid_d[1];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[3] <= 0;
    else
      r_pool_valid_d[3] <= r_pool_valid_d[2];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[4] <= 0;
    else
      r_pool_valid_d[4] <= r_pool_valid_d[3];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[5] <= 0;
    else
      r_pool_valid_d[5] <= r_pool_valid_d[4];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[6] <= 0;
    else
      r_pool_valid_d[6] <= r_pool_valid_d[5];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[7] <= 0;
    else
      r_pool_valid_d[7] <= r_pool_valid_d[6];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[8] <= 0;
    else
      r_pool_valid_d[8] <= r_pool_valid_d[7];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[9] <= 0;
    else
      r_pool_valid_d[9] <= r_pool_valid_d[8];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[10] <= 0;
    else
      r_pool_valid_d[10] <= r_pool_valid_d[9];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[11] <= 0;
    else
      r_pool_valid_d[11] <= r_pool_valid_d[10];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[12] <= 0;
    else
      r_pool_valid_d[12] <= r_pool_valid_d[11];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[13] <= 0;
    else
      r_pool_valid_d[13] <= r_pool_valid_d[12];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[14] <= 0;
    else
      r_pool_valid_d[14] <= r_pool_valid_d[13];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[15] <= 0;
    else
      r_pool_valid_d[15] <= r_pool_valid_d[14];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[16] <= 0;
    else
      r_pool_valid_d[16] <= r_pool_valid_d[15];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[17] <= 0;
    else
      r_pool_valid_d[17] <= r_pool_valid_d[16];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[18] <= 0;
    else
      r_pool_valid_d[18] <= r_pool_valid_d[17];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[19] <= 0;
    else
      r_pool_valid_d[19] <= r_pool_valid_d[18];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[20] <= 0;
    else
      r_pool_valid_d[20] <= r_pool_valid_d[19];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[21] <= 0;
    else
      r_pool_valid_d[21] <= r_pool_valid_d[20];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[22] <= 0;
    else
      r_pool_valid_d[22] <= r_pool_valid_d[21];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[23] <= 0;
    else
      r_pool_valid_d[23] <= r_pool_valid_d[22];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[24] <= 0;
    else
      r_pool_valid_d[24] <= r_pool_valid_d[23];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[25] <= 0;
    else
      r_pool_valid_d[25] <= r_pool_valid_d[24];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[26] <= 0;
    else
      r_pool_valid_d[26] <= r_pool_valid_d[25];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[27] <= 0;
    else
      r_pool_valid_d[27] <= r_pool_valid_d[26];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[28] <= 0;
    else
      r_pool_valid_d[28] <= r_pool_valid_d[27];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[29] <= 0;
    else
      r_pool_valid_d[29] <= r_pool_valid_d[28];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[30] <= 0;
    else
      r_pool_valid_d[30] <= r_pool_valid_d[29];
  always @(posedge clk)
    if (!xrst)
      r_pool_valid_d[31] <= 0;
    else
      r_pool_valid_d[31] <= r_pool_valid_d[30];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[0] <= 0;
    else
      r_pool_end_d[0]   <= (r_state == S_ACTIVE)
                            && r_pool_x == r_fea_size - 1
                            && r_pool_y == r_fea_size - 1;
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[1] <= 0;
    else
      r_pool_end_d[1] <= r_pool_end_d[0];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[2] <= 0;
    else
      r_pool_end_d[2] <= r_pool_end_d[1];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[3] <= 0;
    else
      r_pool_end_d[3] <= r_pool_end_d[2];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[4] <= 0;
    else
      r_pool_end_d[4] <= r_pool_end_d[3];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[5] <= 0;
    else
      r_pool_end_d[5] <= r_pool_end_d[4];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[6] <= 0;
    else
      r_pool_end_d[6] <= r_pool_end_d[5];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[7] <= 0;
    else
      r_pool_end_d[7] <= r_pool_end_d[6];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[8] <= 0;
    else
      r_pool_end_d[8] <= r_pool_end_d[7];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[9] <= 0;
    else
      r_pool_end_d[9] <= r_pool_end_d[8];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[10] <= 0;
    else
      r_pool_end_d[10] <= r_pool_end_d[9];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[11] <= 0;
    else
      r_pool_end_d[11] <= r_pool_end_d[10];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[12] <= 0;
    else
      r_pool_end_d[12] <= r_pool_end_d[11];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[13] <= 0;
    else
      r_pool_end_d[13] <= r_pool_end_d[12];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[14] <= 0;
    else
      r_pool_end_d[14] <= r_pool_end_d[13];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[15] <= 0;
    else
      r_pool_end_d[15] <= r_pool_end_d[14];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[16] <= 0;
    else
      r_pool_end_d[16] <= r_pool_end_d[15];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[17] <= 0;
    else
      r_pool_end_d[17] <= r_pool_end_d[16];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[18] <= 0;
    else
      r_pool_end_d[18] <= r_pool_end_d[17];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[19] <= 0;
    else
      r_pool_end_d[19] <= r_pool_end_d[18];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[20] <= 0;
    else
      r_pool_end_d[20] <= r_pool_end_d[19];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[21] <= 0;
    else
      r_pool_end_d[21] <= r_pool_end_d[20];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[22] <= 0;
    else
      r_pool_end_d[22] <= r_pool_end_d[21];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[23] <= 0;
    else
      r_pool_end_d[23] <= r_pool_end_d[22];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[24] <= 0;
    else
      r_pool_end_d[24] <= r_pool_end_d[23];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[25] <= 0;
    else
      r_pool_end_d[25] <= r_pool_end_d[24];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[26] <= 0;
    else
      r_pool_end_d[26] <= r_pool_end_d[25];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[27] <= 0;
    else
      r_pool_end_d[27] <= r_pool_end_d[26];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[28] <= 0;
    else
      r_pool_end_d[28] <= r_pool_end_d[27];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[29] <= 0;
    else
      r_pool_end_d[29] <= r_pool_end_d[28];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[30] <= 0;
    else
      r_pool_end_d[30] <= r_pool_end_d[29];
  always @(posedge clk)
    if (!xrst)
      r_pool_end_d[31] <= 0;
    else
      r_pool_end_d[31] <= r_pool_end_d[30];

//==========================================================
// output control
//==========================================================

  assign out_begin  = r_out_begin_d1;
  assign out_valid  = r_out_valid_d1;
  assign out_end    = r_out_end_d1;

  assign pool_oe    = r_out_valid_d0;

  always @(posedge clk)
    if (!xrst)
      r_out_begin_d0 <= 0;
    else
      r_out_begin_d0 <= pool_begin;
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d1 <= 0;
    else
      r_out_begin_d1 <= r_out_begin_d0;
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d0 <= 0;
    else
      r_out_valid_d0 <= pool_valid;
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d1 <= 0;
    else
      r_out_valid_d1 <= r_out_valid_d0;
  always @(posedge clk)
    if (!xrst)
      r_out_end_d0 <= 0;
    else
      r_out_end_d0 <= pool_end;
  always @(posedge clk)
    if (!xrst)
      r_out_end_d1 <= 0;
    else
      r_out_end_d1 <= r_out_end_d0;

  assign buf_feat_en = r_buf_feat_en;

  always @(posedge clk)
    if (!xrst)
      r_buf_feat_en <= 0;
    else
      r_buf_feat_en <= in_begin;

endmodule
