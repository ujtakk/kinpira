#ifndef _LAYER_H_
#define _LAYER_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "types.h"

// total number of defined layer types
#define N_TYPE 6

char layer_type[N_TYPE][32] = {
  "image",
  "convolution_2d",
  "max_pooling_2d",
  "batch_normalization",
  "fully_connected",
  "relu",
};

typedef struct {
  char type[32];
  char name[32];
  union {
    struct {
      u16 shape[3];
      u16 *data;
    } image;

    struct {
      u16 shape[4];
      u16 *data;
    } convolution_2d;

    struct {
      u16 kernel;
    } max_pooling_2d;

    // preprocessing is needed to compress
    // 5-params w/ div to 2-params w/o div (TODO: see doc)
    struct {
      u16 alpha;
      u16 beta;
    } batch_normalization;

    struct {
      u16 shape[2];
      u16 *data;
    } fully_connected;
  };
} kpr_layer;

void load_kpr();

#ifdef __cplusplus
}
#endif

#endif
