#ifndef __MISC_H_
#define __MISC_H_

#include "xil_types.h"

u32 concat8_32(u8 data0, u8 data1, u8 data2, u8 data3);
u32 concat16_32(u16 upper, u16 lower);
u32 concat32_64(u16 upper, u16 lower);

#endif
