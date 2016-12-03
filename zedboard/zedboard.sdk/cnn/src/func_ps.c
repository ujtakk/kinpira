/*
 * TODO: We use stupid loading method (array initialization for specific data)
 *     for temporal working.
 * TODO: Therefore, high dimentional load functions are not implemented.
 */
#include <stdio.h>
#include <math.h>
#include <limits.h>
#include "xil_types.h"
#include "func_ps.h"

// latency analysis
#include "xtime_l.h"
#define INIT  XTime begin, end;
#define BEGIN XTime_GetTime(&begin);
#define END   XTime_GetTime(&end); printf("elapsed time: %10.6f [ms]\n\n", (double)(end-begin) / COUNTS_PER_SECOND * 1000);

#define SHIFT 256





void load_images(s16 ***image_map,
         const int i1, const int i2, const int i3)
{
}





void load_images_flat(s16 *image_map,
         const int i1, const int i2, const int i3)
{
}





void load_weight(s16 **weight_matrix,
         const int i1, const int i2)
{
}





void load_weight_flat(s16 *weight_matrix,
         const int i1, const int i2, const int i3, const int i4)
{
}





void load_bias(s16 *bias_vector,
         const int i1)
{
}





// TODO: Give the address of two dim. array To two dim. pointer
//       (Dont want to implement as dynamic array)
//        => flat the array
void full_connect(s16 *input, s16 *output, s16 *weight,
          s16 *bias, const int ilen, const int olen)
{
  int base = 0;

  for (int i = 0; i < olen; i++) {
    s16 sum = bias[i];
    for (int j = 0; j < ilen; j++) {
      s32 pro = input[j] * weight[base+j];
      if (pro >= 0) sum += pro / SHIFT;
      else          sum += pro / SHIFT - 1;
    }
    output[i] = sum;
    base += ilen;
  }
}





void activate_1d(s16 *input, const int ilen)
{
  for (int i = 0; i < ilen; i++)
    if (input[i] < 0)
      input[i] = 0;
}





int softmax(double *output, const int len)
{
  double expsum = 0.0;

  for (int i = 0; i < len; i++)
    expsum += exp(output[i]);

  if (expsum == 0)
    return 1;
  else
    for (int i = 0; i < len; i++)
      output[i] = exp(output[i]) / expsum;

  return 0;
}





s16 mul(s16 input, s16 weight)
{
  s32 pro = input * weight;
  if (pro >= 0)
    return (s16)(pro / SHIFT);
  else
    return (s16)(pro / SHIFT - 1);
}
