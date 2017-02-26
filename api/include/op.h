#ifndef _OP_H_
#define _OP_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "types.h"
#include "layer.h"

typedef struct {
  u8 which;
  u16 input_offset;
  u16 output_offset;
  u16 net_offset;
  u16 total_out;
  u16 total_in;
  u16 img_size;
  u16 pool_size;
} kpr_op;

void post_image(int fd, kpr_layer *image, const u16 offset);

void define_op(int fd, kpr_op *op, kpr_layer *l,
  u16 in_offset, u16 out_offset, u16 net_offset
);

void exec_core(kpr_op *op);

void get_image(int fd, kpr_layer *image, const u16 offset);

#ifdef __cplusplus
}
#endif

#endif
