#ifndef _FUNC_PL_H_
#define _FUNC_PL_H_
/*
 * This source declares functions to work on PL
 */

#include "xil_types.h"

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
