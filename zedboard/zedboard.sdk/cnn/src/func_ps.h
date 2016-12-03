/*
 * This source declares functions to work on PS
 */

#ifndef __FUNC_PS_H_
#define __FUNC_PS_H_

#include "xil_types.h"

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

// linear
void full_connect(s16 *input, s16 *output, s16 *weight,
          s16 *bias, const int ilen, const int olen);
void activate_1d(s16 *input, const int ilen);
int softmax(double *output, const int len);

// misc
s16 mul(s16 input, s16 weight);

#endif
