#ifndef _LENET_H_
#define _LENET_H_

#define FWID    5
#define FHEI    5
#define IMWID   28
#define IMHEI   28
#define PWID    2
#define PHEI    2
#define N_IN    1
#define N_F1    16
#define N_F2    32
#define N_HL    256
#define LABEL   10

#define FSIZE   5
#define PSIZE   2

#define FM1HEI (IMHEI-FHEI+1)
#define FM1WID (IMWID-FWID+1)
#define PM1HEI FM1HEI/PHEI
#define PM1WID FM1WID/PWID
#define FM2HEI (PM1HEI-FHEI+1)
#define FM2WID (PM1WID-FWID+1)
#define PM2HEI FM2HEI/PHEI
#define PM2WID FM2WID/PWID

#endif
