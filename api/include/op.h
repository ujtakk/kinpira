#ifndef _OP_H_
#define _OP_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "types.h"
#include "layer.h"

typedef struct {
  u32 which;
  u32 in_offset;
  u32 out_offset;
  u32 net_offset;
  u32 total_out;
  u32 total_in;
  u32 img_size;
  u32 pool_size;
} kpr_op;

void post_image(kpr_layer *image, const u16 offset);

void define_op(kpr_op *op, kpr_layer *l,
  u16 in_offset, u16 out_offset, u16 net_offset
);

void exec_core(kpr_op *op);

void get_image(kpr_layer *image, const u16 offset);

#ifdef __cplusplus
}
#endif

#endif
