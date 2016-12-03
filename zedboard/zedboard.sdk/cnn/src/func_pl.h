/*
 * This source declares functions to work on PL
 */

#ifndef __FUNC_PL_H_
#define __FUNC_PL_H_

#include "xil_types.h"
#include "xparameters.h"
#include "kinpira.h"
#include "cnn.h"

// reg macro
#define REG_BASE          XPAR_KINPIRA_0_S_AXI_BASEADDR
#define REG_COPRO(num)    REG_BASE + KINPIRA_s_axi_SLV_REG##num##_OFFSET

// input reg
#define reg_which         REG_COPRO(0)
#define reg_req           REG_COPRO(1)
#define reg_img_we        REG_COPRO(2)
#define reg_input_addr    REG_COPRO(3)
#define reg_output_addr   REG_COPRO(4)
#define reg_write_img     REG_COPRO(5)
#define reg_net_we        REG_COPRO(6)
#define reg_net_addr      REG_COPRO(7)
#define reg_write_net     REG_COPRO(8)
#define reg_total_out     REG_COPRO(9)
#define reg_total_in      REG_COPRO(10)
#define reg_img_size      REG_COPRO(11)
#define reg_fil_size      REG_COPRO(12)
#define reg_pool_size     REG_COPRO(13)

// output reg
#define reg_r_which       REG_COPRO(31)
#define reg_ack           REG_COPRO(30)
#define reg_read_img      REG_COPRO(29)

typedef struct {
  u32 which;
  u32 input_offset;
  u32 output_offset;
  u32 net_offset;
  u32 total_out;
  u32 total_in;
  u32 img_size;
  u32 fil_size;
  u32 pool_size;
} layer;

void post_image(s16 *image, const u16 offset, const u16 length);
void define_2d(layer *l,
  u32 input_offset, u32 output_offset, u32 net_offset,
  u32 total_out, u32 total_in,
  u32 img_size, u32 fil_size, u32 pool_size
);
void assign_2d(layer *l, s16 *weight, s16 *bias);
void define_1d(layer *l,
  u32 input_offset, u32 output_offset, u32 net_offset,
  u32 total_out, u32 total_in
);
void assign_1d(layer *l, s16 *weight, s16 *bias);
void exec_core(layer *l);
void get_image(s16 *image, const u16 offset, const u16 length);

#endif
