#include <limits.h>
#include "xil_io.h"
#include "xil_printf.h"

#include "show.h"
#include "cnn.h"
#include "func_pl.h"




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





