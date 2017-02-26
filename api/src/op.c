#ifdef _OP_H_

#include "types.h"
#include "op.h"

void post_image(int fd, kpr_layer *image, const u16 offset)
{
}

void define_op(int fd, kpr_op *op, kpr_layer *l,
  u16 in_offset, u16 out_offset, u16 net_offset
)
{
}

void exec_core(kpr_op *op)
{
}

void get_image(int fd, kpr_layer *image, const u16 offset)
{
}

#endif
