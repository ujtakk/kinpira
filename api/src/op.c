#ifdef _OP_H_

#include "types.h"
#include "op.h"

void post_image(kpr_layer *image, const u16 offset)
{
  u16 index = offset;
  write(reg_img_we, 0x1, sizeof(u32));
  for (u16 i = 0; i < length; i++) {
    // Order "addr -> write_input" is important.
    write(reg_input_addr, index,    sizeof(u32));
    write(reg_write_img,  image[i], sizeof(u32));
    index++;
  }
  write(reg_img_we,     0x0, sizeof(u32));
  write(reg_input_addr, 0x0, sizeof(u32));
  write(reg_write_img,  0x0, sizeof(u32));
}

void define_op(kpr_op *op, kpr_layer *l,
  u16 in_offset, u16 out_offset, u16 net_offset
)
{
  op->in_offset   = in_offset;
  op->out_offset  = out_offset;
  op->net_offset  = net_offset;

}

void exec_core(kpr_op *op)
{
  u32 ack = 0;

  write(reg_which,       op->which,      sizeof(u32));
  write(reg_req,         0x0,            sizeof(u32));
  write(reg_img_we,      0x0,            sizeof(u32));
  write(reg_input_addr,  op->in_offset,  sizeof(u32));
  write(reg_output_addr, op->out_offset, sizeof(u32));
  write(reg_write_img,   0x0,            sizeof(u32));
  write(reg_net_we,      0x0,            sizeof(u32));
  write(reg_net_addr,    op->net_offset, sizeof(u32));
  write(reg_write_net,   0x0,            sizeof(u32));
  write(reg_total_out,   op->total_out,  sizeof(u32));
  write(reg_total_in,    op->total_in,   sizeof(u32));
  write(reg_img_size,    op->img_size,   sizeof(u32));
  write(reg_fil_size,    op->fil_size,   sizeof(u32));
  write(reg_pool_size,   op->pool_size,  sizeof(u32));

  write(reg_req, 0x1, sizeof(u32));
  write(reg_req, 0x0, sizeof(u32));
  // Blocking till PL finishing the operation
  do {
    read(reg_ack, &ack, sizeof(u32));
  } while (ack == 0);
}

void get_image(kpr_layer *image, const u16 offset)
{
  u16 index = offset;
  for (u16 i = 0; i < length; i++) {
    // Order "addr -> write_input" is important.
    write(reg_input_addr, index, sizeof(u32));
    read(reg_read_img, &image[index], sizeof(u32));
    index++;
  }
  write(reg_input_addr, 0x0, sizeof(u32));
}

#endif
