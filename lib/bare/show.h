#ifndef __SHOW_H_
#define __SHOW_H_

#include "xil_types.h"

void probe_in(s16 *input_true, int total_in, int img_size);
void probe_w(s16 *weight_true, int total_out, int total_in, int fil_size);
void print_port(void);
void print_result(s16 *output);

#endif
