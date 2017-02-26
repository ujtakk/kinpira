#ifdef _BARE_H_

#include <math.h>
#include <limits.h>

#include "xil_io.h"
#include "xil_printf.h"
#include "xil_types.h"

#include "kinpira.h"
#include "bare.h"

#define SHIFT 256



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



/*
 * TODO: We use stupid loading method (array initialization for specific data)
 *     for temporal working.
 * TODO: Therefore, high dimentional load functions are not implemented.
 */




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
      s32 pro = mul(input[j], weight[base+j]);
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



u32 concat8_32(u8 data0, u8 data1, u8 data2, u8 data3)
{
  u32 total = (data0 << 24) | (data1 << 16) | (data2 << 8) | data3;

  return total;
}



u32 concat16_32(u16 upper, u16 lower)
{
  u32 total = (upper << 16) | lower;

  return total;
}



u32 concat32_64(u16 upper, u16 lower)
{
  u32 total = (upper << 16) | lower;

  return total;
}



/*
void probe_in(s16 *input_true, int total_in, int img_size)
{
  const int in_size = total_in * img_size * img_size;
  int probe;
  for (int i = 0; i < in_size; i++) {
    Xil_Out32(reg_input_addr, i);
    probe = Xil_In32(reg_probe_in);
    if (probe != input_true[i])
      xil_printf("fail_in: %d\t%d\t%d\n\r", i, probe, input_true[i]);
  }
  Xil_Out32(reg_input_addr, 0x0);
  xil_printf("probe_in done\n\r");
}



void probe_w(s16 *weight_true, int total_out, int total_in, int fil_size)
{
  int w_mem_addr    = 0;
  int core_num      = 0;
  const int w_unit  = total_in * fil_size * fil_size;
  const int w_size  = total_out * w_unit;
  int probe;

  for (int i = 0; i < w_size; i++) {
    if (i % w_unit == 0)
      core_num = (i / w_unit) % CORE + 1;
    w_mem_addr = (i / (w_unit * CORE)) * w_unit + i % w_unit;

    Xil_Out32(reg_weight_addr, w_mem_addr);

    switch (core_num) {
      case 1: probe = Xil_In32(reg_probe_w0); break;
      case 2: probe = Xil_In32(reg_probe_w1); break;
      case 3: probe = Xil_In32(reg_probe_w2); break;
      case 4: probe = Xil_In32(reg_probe_w3); break;
      case 5: probe = Xil_In32(reg_probe_w4); break;
      case 6: probe = Xil_In32(reg_probe_w5); break;
      case 7: probe = Xil_In32(reg_probe_w6); break;
      case 8: probe = Xil_In32(reg_probe_w7); break;
      default: probe = 0; break;
    }

    if (probe != weight_true[i])
      xil_printf("fail_w: %d\t%d\t%d\n\r",
                    i, probe, weight_true[i]);
  }
  Xil_Out32(reg_weight_addr, 0x0);
  xil_printf("probe_w done\n\r");
}
*/



/*
void print_port(void)
{
  int port[256];

  port[0]  = Xil_In32(reg_req);
  port[1]  = Xil_In32(reg_output_re);
  port[2]  = Xil_In32(reg_weight_we);
  port[3]  = Xil_In32(reg_input_we);
  port[4]  = Xil_In32(reg_total_out);
  port[5]  = Xil_In32(reg_total_in);
  port[6]  = Xil_In32(reg_img_size);
  port[7]  = Xil_In32(reg_fil_size);
  port[8]  = Xil_In32(reg_pool_size);
  port[9]  = Xil_In32(reg_input_addr);
  port[10]  = Xil_In32(reg_write_input);
  port[11] = Xil_In32(reg_weight_addr);
  port[12] = Xil_In32(reg_write_weight);
  port[13] = Xil_In32(reg_output_addr);

  port[255] = Xil_In32(reg_ack);
  port[254] = Xil_In32(reg_read_output);
//  port[253] = Xil_In32(reg_probe_in);

  xil_printf(
      "%x : %x : %x : %x : %x : %x : %x : %x : %x : %x : %x : %x : %x : %x @@ %x : %x : %x\n\r",
      port[0], port[1], port[2], port[3], port[4], port[5], port[6], port[7], port[8],
      port[9], port[10], port[11], port[12], port[13], port[255], port[254], port[253]
  );
}
*/



void print_result(s16 *output)
{
  int number  = -1;
  int max     = INT_MIN;

  for (int i = 0; i < LABEL; i++) {
    printf("%d\n",output[i]);

    if (max < output[i]) {
      max = output[i];
      number = i;
    }
  }

  printf("the answer is %d.\n", number);
}



#endif
