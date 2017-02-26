#ifdef _FUNC_PL_H_

#include "xil_io.h"
#include "kinpira.h"
#include "func_pl.h"



void post_image(s16 *image, const u16 offset, const u16 length)
{
  u16 index = offset;
  Xil_Out32(reg_img_we, 0x1);
  for (u16 i = 0; i < length; i++) {
    // Order "addr -> write_input" is important.
    Xil_Out32(reg_input_addr,  index);
    Xil_Out32(reg_write_img, image[i]);
    index++;
  }
  Xil_Out32(reg_img_we, 0x0);
  Xil_Out32(reg_input_addr, 0x0);
  Xil_Out32(reg_write_img, 0x0);
}



void define_2d(layer *l,
  u32 input_offset, u32 output_offset, u32 net_offset,
  u32 total_out, u32 total_in,
  u32 img_size, u32 fil_size, u32 pool_size
)
{
  l->which          = RENKON;
  l->input_offset   = input_offset;
  l->output_offset  = output_offset;
  l->net_offset     = net_offset;
  l->total_out      = total_out;
  l->total_in       = total_in;
  l->img_size       = img_size;
  l->fil_size       = fil_size;
  l->pool_size      = pool_size;
}



void assign_2d(layer *l, s16 *weight, s16 *bias)
{
  u16 w_offset  = 0;
  u16 w_index   = 0;
  u16 mem_addr  = 0;
  u16 core_num  = 0;
  u16 w_cnt     = 0;
  u16 b_cnt     = 0;
  u16 offset    = l->net_offset;
  u16 total_out = l->total_out;
  u16 total_in  = l->total_in;
  u16 fil_size  = l->fil_size;
  u16 w_unit    = total_in * fil_size * fil_size;

  Xil_Out32(reg_which, RENKON);

  for (u16 i = 0; i < total_out; i++) {
    core_num = i % RENKON_CORE + 1;
    w_offset  = (w_unit + 1) * (i / RENKON_CORE) + offset;
    for (u16 j = 0; j < total_in; j++) {
      for (u16 k = 0; k < fil_size; k++) {
        for (u16 l = 0; l < fil_size; l++) {
          w_index = fil_size * fil_size * j + fil_size * k + l;
          mem_addr = w_offset + w_index;
          Xil_Out32(reg_net_addr,  mem_addr);
          Xil_Out32(reg_write_net, weight[w_cnt]);
          Xil_Out32(reg_net_we,    core_num);
          Xil_Out32(reg_net_we,    0x0);
          w_cnt++;
        }
      }
    }
    mem_addr = w_unit + w_offset;
    Xil_Out32(reg_net_addr,  mem_addr);
    Xil_Out32(reg_write_net, bias[b_cnt]);
    Xil_Out32(reg_net_we,    core_num);
    Xil_Out32(reg_net_we,    0x0);
    b_cnt;
  }
  Xil_Out32(reg_net_we,    0x0);
  Xil_Out32(reg_net_addr,  0x0);
  Xil_Out32(reg_write_net, 0x0);
}



void define_1d(layer *l,
  u32 input_offset, u32 output_offset, u32 net_offset,
  u32 total_out, u32 total_in
)
{
  l->which          = GOBOU;
  l->input_offset   = input_offset;
  l->output_offset  = output_offset;
  l->net_offset     = net_offset;
  l->total_out      = total_out;
  l->total_in       = total_in;
  l->img_size       = 0;
  l->fil_size       = 0;
  l->pool_size      = 0;
}



void assign_1d(layer *l, s16 *weight, s16 *bias)
{
  u16 w_offset  = 0;
  u16 w_index   = 0;
  u16 mem_addr  = 0;
  u16 core_num  = 0;
  u16 w_cnt     = 0;
  u16 b_cnt     = 0;
  u16 offset    = l->net_offset;
  u16 total_out = l->total_out;
  u16 total_in  = l->total_in;

  Xil_Out32(reg_which, GOBOU);

  for (u16 i = 0; i < total_out; i++) {
    core_num = i % GOBOU_CORE + 1;
    w_offset  = (total_in + 1) * (i / GOBOU_CORE) + offset;
    for (u16 j = 0; j < total_in; j++) {
      w_index = j;
      mem_addr = w_offset + w_index;
      Xil_Out32(reg_net_addr,  mem_addr);
      Xil_Out32(reg_write_net, weight[w_cnt]);
      Xil_Out32(reg_net_we,    core_num);
      Xil_Out32(reg_net_we,    0x0);
      w_cnt++;
    }
    mem_addr = total_in + w_offset;
    Xil_Out32(reg_net_addr,  mem_addr);
    Xil_Out32(reg_write_net, bias[b_cnt]);
    Xil_Out32(reg_net_we,    core_num);
    Xil_Out32(reg_net_we,    0x0);
    b_cnt++;
  }
  Xil_Out32(reg_net_we,    0x0);
  Xil_Out32(reg_net_addr,  0x0);
  Xil_Out32(reg_write_net, 0x0);
}



void exec_core(layer *l)
{
  Xil_Out32(reg_which,        l->which);
  Xil_Out32(reg_req,          0x0);
  Xil_Out32(reg_img_we,       0x0);
  Xil_Out32(reg_input_addr,   l->input_offset);
  Xil_Out32(reg_output_addr,  l->output_offset);
  Xil_Out32(reg_write_img,    0x0);
  Xil_Out32(reg_net_we,       0x0);
  Xil_Out32(reg_net_addr,     l->net_offset);
  Xil_Out32(reg_write_net,    0x0);
  Xil_Out32(reg_total_out,    l->total_out);
  Xil_Out32(reg_total_in,     l->total_in);
  Xil_Out32(reg_img_size,     l->img_size);
  Xil_Out32(reg_fil_size,     l->fil_size);
  Xil_Out32(reg_pool_size,    l->pool_size);

  Xil_Out32(reg_req, 0x1);
  Xil_Out32(reg_req, 0x0);
  // Blocking till PL finishing the operation
  do {
    // Nop
  } while (!Xil_In32(reg_ack));
}



void get_image(s16 *image, const u16 offset, const u16 length)
{
  u16 index = offset;
  for (u16 i = 0; i < length; i++) {
    // Order "addr -> write_input" is important.
    Xil_Out32(reg_input_addr,  index);
    image[index] = Xil_In32(reg_read_img);
    index++;
  }
  Xil_Out32(reg_input_addr, 0x0);
}



#endif
