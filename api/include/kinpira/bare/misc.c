#ifdef __MISC_H_

#include "misc.h"



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



#endif
