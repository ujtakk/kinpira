#ifndef _UIO_H_
#define _UIO_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "types.h"

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

////////////////////////////////////////////////////////////
// PL Functions
////////////////////////////////////////////////////////////

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

////////////////////////////////////////////////////////////
// Load Functions
////////////////////////////////////////////////////////////

// load
void load_images(s16 ***image_map,
         const int i1, const int i2, const int i3);

void load_images_flat(s16 *image_map,
         const int i1, const int i2, const int i3);

void load_weight(s16 **weight_matrix,
         const int i1, const int i2);

void load_weight_flat(s16 *weight_matrix,
         const int i1, const int i2, const int i3, const int i4);

void load_bias(s16 *bias_vector,
         const int i1);

////////////////////////////////////////////////////////////
// Operations
////////////////////////////////////////////////////////////

// linear ops
void full_connect(s16 *input, s16 *output, s16 *weight,
          s16 *bias, const int ilen, const int olen);
void activate_1d(s16 *input, const int ilen);
int softmax(double *output, const int len);

// misc
s16 mul(s16 input, s16 weight);

u32 concat8_32(u8 data0, u8 data1, u8 data2, u8 data3);
u32 concat16_32(u16 upper, u16 lower);
u32 concat32_64(u16 upper, u16 lower);

////////////////////////////////////////////////////////////
// Show Functions
////////////////////////////////////////////////////////////

void probe_in(s16 *input_true, int total_in, int img_size);
void probe_w(s16 *weight_true, int total_out, int total_in, int fil_size);
void print_port(void);
void print_result(s16 *output);

#ifdef __cplusplus
}
#endif

#endif
