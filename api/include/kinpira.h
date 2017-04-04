#ifndef _KINPIRA_H_
#define _KINPIRA_H_

// reg macro
#define REG_NUM           32
#define REG_SIZE          4 * REG_NUM

#ifdef XENV_STANDALONE_H
#  include "xparameters.h"
#  define REG_BASE          XPAR_KINPIRA_0_S_AXI_BASEADDR
#  define REG_COPRO(num)    REG_BASE + KINPIRA_s_axi_SLV_REG##num##_OFFSET
#else
#  define REG_BASE          0xA0000000
#  define REG_COPRO(num)    __kpr_port[4*num]
#endif

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

#define RENKON  0
#define GOBOU   1

#define RENKON_CORE 8
#define GOBOU_CORE  8
#define CORE        8
#define DWIDTH      16
#define LWIDTH      8
#define INSIZE      12
#define OUTSIZE     10
#define WSIZE       13
#define IFMSIZE     9
#define FACCUM      7
#define PACCUM      8

#endif
