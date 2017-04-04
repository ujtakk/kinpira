#ifdef _UIO_H_

#include <sys/mman.h>
#include <errno.h>

#include "kinpira.h"
#include "uio.h"

int __kpr_uiofd;
u32 *__kpr_port;

int init_kinpira(void)
{
  // Open Kinpira as UIO Driver
  __kpr_uiofd = open("/dev/uio0", O_RDWR);
  if (__kpr_uiofd < 0) {
    perror("uio open: ");
    return errno;
  }

  __kpr_port = (u32 *)mmap(NULL, REG_SIZE, PROT_READ | PROT_WRITE,
                           MAP_SHARED, __kpr_uiofd, 0);
  if (!__kpr_port) {
    fprintf(stderr, "mmap failed\n");
    return errno;
  }

  return 0;
}

void post_image(s16 *image, const u16 offset, const u16 length)
{
  u16 index = offset;
  reg_img_we = 0x1;
  for (u16 i = 0; i < length; i++) {
    // Order "addr -> write_input" is important.
    reg_input_addr  = index;
    reg_write_img   = image[i];
    index++;
  }
  reg_img_we      = 0x0;
  reg_input_addr  = 0x0;
  reg_write_img   = 0x0;
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

  reg_which = RENKON;

  for (u16 i = 0; i < total_out; i++) {
    core_num = i % RENKON_CORE + 1;
    w_offset = (w_unit + 1) * (i / RENKON_CORE) + offset;
    for (u16 j = 0; j < total_in; j++) {
      for (u16 k = 0; k < fil_size; k++) {
        for (u16 l = 0; l < fil_size; l++) {
          w_index = fil_size * fil_size * j + fil_size * k + l;
          mem_addr = w_offset + w_index;
          reg_net_addr  = mem_addr;
          reg_write_net = weight[w_cnt];
          reg_net_we    = core_num;
          reg_net_we    = 0x0;
          w_cnt++;
        }
      }
    }
    mem_addr = w_unit + w_offset;
    reg_net_addr  = mem_addr;
    reg_write_net = bias[b_cnt];
    reg_net_we    = core_num;
    reg_net_we    = 0x0;
    b_cnt;
  }
  reg_net_we    = 0x0;
  reg_net_addr  = 0x0;
  reg_write_net = 0x0;
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

  reg_which = GOBOU;

  for (u16 i = 0; i < total_out; i++) {
    core_num = i % GOBOU_CORE + 1;
    w_offset  = (total_in + 1) * (i / GOBOU_CORE) + offset;
    for (u16 j = 0; j < total_in; j++) {
      w_index = j;
      mem_addr = w_offset + w_index;
      reg_net_addr  = mem_addr;
      reg_write_net = weight[w_cnt];
      reg_net_we    = core_num;
      reg_net_we    = 0x0;
      w_cnt++;
    }
    mem_addr = total_in + w_offset;
    reg_net_addr  = mem_addr;
    reg_write_net = bias[b_cnt];
    reg_net_we    = core_num;
    reg_net_we    = 0x0;
    b_cnt++;
  }
  reg_net_we    = 0x0;
  reg_net_addr  = 0x0;
  reg_write_net = 0x0;
}

void exec_core(layer *l)
{
  reg_which       = l->which;
  reg_req         = 0x0;
  reg_img_we      = 0x0;
  reg_input_addr  = l->input_offset;
  reg_output_addr = l->output_offset;
  reg_write_img   = 0x0;
  reg_net_we      = 0x0;
  reg_net_addr    = l->net_offset;
  reg_write_net   = 0x0;
  reg_total_out   = l->total_out;
  reg_total_in    = l->total_in;
  reg_img_size    = l->img_size;
  reg_fil_size    = l->fil_size;
  reg_pool_size   = l->pool_size;

  reg_req = 0x1;
  reg_req = 0x0;
  // Blocking till PL finishing the operation
  do {
    // Nop
  } while (!reg_ack);
}

void get_image(s16 *image, const u16 offset, const u16 length)
{
  u16 index = offset;
  for (u16 i = 0; i < length; i++) {
    // Order "addr -> write_input" is important.
    reg_input_addr = index;
    image[index] = reg_read_img;
    index++;
  }
  reg_input_addr = 0x0;
}

int cleanup_kinpira(void)
{
  munmap(__kpr_port, REG_SIZE);
  close(__kpr_uiofd);

  return 0;
}

#endif
