#define ENABLE_COPRO

#include <stdio.h>
#include <limits.h>
#include <unistd.h>

#include <xparameters.h>
#include <xil_printf.h>

#include <kinpira.h>
#include <kinpira/bare.h>

#include "platform.h"
#include "lenet.h"

// These arrays are defined as global variables.
/*
 * s16 input_flat[IMHEI*IMWID];
 * s16 pmap1_flat[N_F1*PM1HEI*PM1WID];
 * s16 w_conv1_flat[N_F1*1*FHEI*FWID];
 * s16 b_conv1[N_F1]
 * s16 w_conv2_flat[N_F2*N_F1*FHEI*FWID];
 * s16 b_conv2[N_F2]
 * s16 w_hidden[N_HL][PM2HEI*PM2WID*N_F2];
 * s16 b_hidden[N_HL];
 * s16 w_output[LABEL][N_HL];
 * s16 b_output[LABEL];
 */

// #include "data/pmap1_flat.h"
// #include "data/pmap1_flat_true.h"
// #include "data/pmap2_flat_true.h"
#include "data/input.h"
#include "data/input_flat.h"
#include "data/w_conv1.h"
#include "data/w_conv1_flat.h"
#include "data/b_conv1.h"
#include "data/w_conv2.h"
#include "data/w_conv2_flat.h"
#include "data/b_conv2.h"
#include "data/w_hidden.h"
#include "data/b_hidden.h"
#include "data/w_output.h"
#include "data/b_output.h"

// latency analysis
#include "xtime_l.h"
#define INIT  XTime begin, end;
#define BEGIN XTime_GetTime(&begin);
#define END   XTime_GetTime(&end);        \
  printf("%10.6f [ms]\n\n", \
      (double)(end-begin) / COUNTS_PER_SECOND * 1000);

#include "xgpiops.h"
#define GPIO_DEVICE_ID  XPAR_XGPIOPS_0_DEVICE_ID
#define OUTPUT_PIN    13
XGpioPs Gpio; /* The Instance of the GPIO Driver */

int main(void)
{
  INIT

  // TODO: load data from the SD card using Linux
  //        => (standalone may be enough)

  // u32 Data;
  // int Status;
  // XGpioPs_Config *ConfigPtr;
  //
  // ConfigPtr = XGpioPs_LookupConfig(GPIO_DEVICE_ID);
  // Status = XGpioPs_CfgInitialize(&Gpio, ConfigPtr, ConfigPtr->BaseAddr);
  //
  // if (Status != XST_SUCCESS)
  //   return XST_FAILURE;
  //
  // XGpioPs_SetDirectionPin(&Gpio, OUTPUT_PIN, 1);
  // XGpioPs_SetOutputEnablePin(&Gpio, OUTPUT_PIN, 1);

  // for (int p=9; p<16; p++) {
  //   XGpioPs_SetDirectionPin(&Gpio, p, 1);
  //   XGpioPs_SetOutputEnablePin(&Gpio, p, 1);
  //   XGpioPs_WritePin(&Gpio, p, 0x1);
  // }

#ifdef ENABLE_COPRO
  layer conv1, conv2;
  layer hidden, output;
  s16 output_flat[LABEL];
#else
  s16 fmap1[N_F1][FM1HEI][FM1WID];
  s16 pmap1[N_F1][PM1HEI][PM1WID];
  s16 fmap2[N_F2][FM2HEI][FM2WID];
  s16 pmap2[N_F2][PM2HEI][PM2WID];
  s16 pmap2_flat[N_F2*PM2HEI*PM2WID];
  s16 hidden[N_HL];
  s16 output[LABEL];
#endif

  init_platform();

  // Clear the screen
  for (int i = 0; i < 100; i++) xil_printf("\r\n");

#ifdef SDCARD
  // XGpioPs_WritePin(&Gpio, OUTPUT_PIN, 0x1);
  // Data = XGpioPs_ReadPin(&Gpio, OUTPUT_PIN);
  // if (Data != 1)
  //   return XST_FAILURE;
#endif

#ifdef ENABLE_COPRO
  define_2d(&conv1,  0, 784, 0, N_F1, N_IN,  IMHEI, FHEI, PHEI);
  assign_2d(&conv1, w_conv1_flat, b_conv1);

  define_2d(&conv2, 784, 3088, 52, N_F2, N_F1, PM1HEI, FHEI, PHEI);
  assign_2d(&conv2, w_conv2_flat, b_conv2);

  define_1d(&hidden, 3088, 3600, 0, N_HL, N_F2*PM2HEI*PM2WID);
  assign_1d(&hidden, w_hidden, b_hidden);

  define_1d(&output, 3600, 3856, 8208, LABEL, N_HL);
  assign_1d(&output, w_output, b_output);

  printf("post_image(input_flat)\n");
  BEGIN
  post_image(input_flat, 0, 784);
  END

  printf("exec_core(&conv1)\n");
  BEGIN
  exec_core(&conv1);
  END

  printf("exec_core(&conv2)\n");
  BEGIN
  exec_core(&conv2);
  END

  printf("exec_core(&hidden)\n");
  BEGIN
  exec_core(&hidden);
  END

  printf("exec_core(&output)\n");
  BEGIN
  exec_core(&output);
  END

  printf("get_image(output_flat)\n");
  BEGIN
  get_image(output_flat, 3856, 10);
  END

  print_result(output_flat);
#else
  /*
   * For simplication of impl and retainment of performance,
   * we use multi-dimentional fixed-length array.
   * (Therefore iterations are not functionalized.)
   */
  /* layer1 */
  printf("conv(input, w_conv1, fmap1)\n");
  printf("max_pooling(fmap1, pmap1)\n");
  printf("add_bias(pmap1, b_conv1)\n");
  printf("activate(pmap1)\n");
  BEGIN
  for (int i = 0; i < N_F1; i++) {
    // printf("conv(input, w_conv1[i], fmap1[i])\n");
    for (int j = 0; j < 1; j++) {
      for (int k = 0; k < FM1HEI; k++) {
        for (int l = 0; l < FM1WID; l++) {
          s16 sum = 0;
          for (int m = 0; m < FHEI; m++)
            for (int n = 0; n < FWID; n++)
              sum += mul(input[j][k+m][l+n], w_conv1[i][j][m][n]);
          if (j == 0)
            fmap1[i][k][l] = sum;
          else
            fmap1[i][k][l] += sum;
        }
      }
    }
    // printf("max_pooling(fmap1[i], pmap1[i])\n");
    for (int k = 0; k < FM1HEI; k += PHEI) {
      for (int l = 0; l < FM1WID; l += PWID) {
        int max = INT_MIN;
        for (int m = 0;  m < PHEI; m++)
          for (int n = 0; n < PWID; n++)
            if (fmap1[i][k+m][l+n] > max)
              max = fmap1[i][k+m][l+n];
        pmap1[i][k/PHEI][l/PWID] = max;
      }
    }
    // printf("add_bias(pmap1[i], b_conv1[i])\n");
    for (int k = 0; k < PM1HEI; k++)
      for (int l = 0; l < PM1WID; l++)
        pmap1[i][k][l] += b_conv1[i];
    // printf("activate(pmap1[i])\n");
    for (int k = 0; k < PM1HEI; k++)
      for (int l = 0; l < PM1WID; l++)
        if (pmap1[i][k][l] < 0)
          pmap1[i][k][l] = 0;
  }
  END

  /* layer2 */
  printf("conv(pmap1, w_conv2, fmap2)\n");
  printf("max_pooling(fmap2, pmap2)\n");
  printf("add_bias(pmap2, b_conv2)\n");
  printf("activate(pmap2)\n");
  BEGIN
  for (int i = 0; i < N_F2; i++) {
    // printf("conv(pmap1, w_conv2[i], fmap2[i])\n");
    for (int j = 0; j < N_F1; j++) {
      for (int k = 0; k < FM2HEI; k++) {
        for (int l = 0; l < FM2WID; l++) {
          s32 sum = 0;
          for (int m = 0; m < FHEI; m++)
            for (int n = 0; n < FWID; n++)
              sum += mul(pmap1[j][k+m][l+n], w_conv2[i][j][m][n]);
          if (j == 0)
            fmap2[i][k][l] = sum;
          else
            fmap2[i][k][l] += sum;
        }
      }
    }
    // printf("max_pooling(fmap2[i], pmap2[i])\n");
    for (int k = 0; k < FM2HEI; k += PHEI) {
      for (int l = 0; l < FM2WID; l += PWID) {
        int max = INT_MIN;
        for (int m = 0;  m < PHEI; m++)
          for (int n = 0; n < PWID; n++)
            if (fmap2[i][k+m][l+n] > max)
              max = fmap2[i][k+m][l+n];
        pmap2[i][k/PHEI][l/PWID] = max;
      }
    }
    // printf("add_bias(pmap2[i], b_conv2[i])\n");
    for (int k = 0; k < PM2HEI; k++)
      for (int l = 0; l < PM2WID; l++)
        pmap2[i][k][l] += b_conv2[i];
    // printf("activate(pmap2[i])\n");
    for (int k = 0; k < PM2HEI; k++)
      for (int l = 0; l < PM2WID; l++)
        if (pmap2[i][k][l] < 0)
          pmap2[i][k][l] = 0;
  }
  END

  printf("flatten(pmap2, pmap2_flat)\n");
  BEGIN
  for (int i = 0; i < N_F2; i++)
    for (int j = 0; j < PM2HEI; j++)
      for (int k = 0; k < PM2WID; k++)
        pmap2_flat[i*PM2HEI*PM2WID+j*PM2WID+k] = pmap2[i][j][k];
  END

  /************************************************************
   * calculate fully connected layers on CPU
   * because these layers has tendency to be data intensive.
   ************************************************************/
  printf("full_connect(pmap2_flat, hidden)\n");
  BEGIN
  full_connect(pmap2_flat, hidden,
                w_hidden, b_hidden, PM2HEI*PM2WID*N_F2, N_HL);
  END

  printf("activate_1d(hidden)\n");
  BEGIN
  activate_1d(hidden, N_HL);
  END

  printf("full_connect(hidden, output)\n");
  BEGIN
  full_connect(hidden, output,
                w_output, b_output, N_HL, LABEL);
  END

  print_result(output);
#endif

#ifdef SDCARD
  // XGpioPs_WritePin(&Gpio, OUTPUT_PIN, 0x0);
  // Data = XGpioPs_ReadPin(&Gpio, OUTPUT_PIN);
  // if (Data != 0) return XST_FAILURE;
#endif

  cleanup_platform();

  return XST_SUCCESS;
}
