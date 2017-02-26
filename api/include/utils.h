#ifndef _UTILS_H_
#define _UTILS_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "types.h"

u16 concat8_16(u8 data0, u8 data1);
u32 concat8_32(u8 data0, u8 data1, u8 data2, u8 data3);
u32 concat16_32(u16 data0, u16 data1);
u64 concat8_64(u8 data0, u8 data1, u8 data2, u8 data3,
               u8 data4, u8 data5, u8 data6, u8 data7);
u64 concat16_64(u16 data0, u16 data1, u16 data2, u16 data3);
u64 concat32_64(u32 data0, u32 data1);

void print_result(i16 *output);

#ifdef __cplusplus
}
#endif

#endif
