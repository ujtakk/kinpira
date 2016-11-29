#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <assert.h>

#define IHUNIT
#define FWID 5 /*filter width*/
#define FHEI 5 /*filter height*/
#define IMWID 28 /*image width*/
#define IMHEI 28 /*image height*/
#define PWID 2 /*pooling rate*/
#define PHEI 2
#define N_F1 20 /*number of feature maps 1*/
#define N_F2 50 /*number of feature maps 2*/
#define N_HL 500 /*number of hidden layer unit*/
#define LABEL 10 /*number of class*/

char *where = "/home/work/takau";
/*read data file and convert to Q8.8*/
int load_image(char *filename,double **d,int **li,
         const int height,const int width)
{
  FILE *fp;
  int i,j;
  fp = fopen(filename,"r");
  if (fp==NULL) return -1;
  else {
    for (i = 0; i < height; i++) {
      for (j = 0; j < width; j++) {
        fscanf(fp,"%lf",&d[i][j]);
        li[i][j] = round(d[i][j]*pow(2,8));
      }
    }
  }
  fclose(fp);
  return 0;
}

int load_data(char *filename,double **d1,int **li1,double *d2,int *li2,
        const int height,const int width)
{
  FILE *fp;
  int i,j;

  fp = fopen(filename,"r");
  if (fp==NULL) {
    return 0;
  } else {
    for (i = 0; i < height; i++) {
      for (j = 0; j < width; j++) {
        fscanf(fp,"%lf",&d1[i][j]);
        li1[i][j] = round(d1[i][j]*pow(2,8));
      }
    }
    fscanf(fp,"%lf",d2);
    *li2 = round(*d2*pow(2,8));
  }
  fclose(fp);

  return 0;
}

int load_w(char *filename,double **d1,int **li1,
        const int height,const int width)
{
  FILE *fp;
  int i,j;
  fp = fopen(filename,"r");
  if (fp==NULL) {
    return 0;
  } else {
    for (i = 0; i < height; i++) {
      for (j = 0; j < width; j++) {
        fscanf(fp,"%lf",&d1[i][j]);
        li1[i][j] = round(d1[i][j]*pow(2,8));
      }
    }
  }
  fclose(fp);
  return 0;
}

int load_b(char *filename,double *d,int *li)
{
  FILE *fp;
  fp = fopen(filename,"r");
  if (fp==NULL) {
    return 0;
  } else {
        fscanf(fp,"%lf",d);
        *li = round(*d*pow(2,8));
  }
  fclose(fp);
  return 0;
}

int load_data_1d(char *filename, double *d1, int *li1, double *d2,
         int *li2, const int length)
{
  FILE *fp;
  int i;
  fp = fopen(filename,"r");
  if (fp==NULL) {
    return 0;
  } else {
    for (i = 0; i < length; i++) {
      fscanf(fp,"%lf",&d1[i]);
      li1[i] = round(d1[i]*pow(2,8));
    }
    fscanf(fp,"%lf",d2);
    *li2 = round(*d2*pow(2,8));
  }
  fclose(fp);
  return 0;
}

/*memory allocation for each type and dimension*/
double **dmalloc_2d(int size1, int size2)
{
  int i;
  double **target;
  target = (double **)malloc(sizeof(double *)*size1);
  if (target==NULL) {
    printf("fail malloc\n");
  }
  for (i = 0; i < size1; i++) {
    target[i] = (double *)malloc(sizeof(double)*size2);
  }
  return target;
}

int **imalloc_2d(int size1,int size2)
{
  int i;
  int **target;
  target = (int **)malloc(sizeof(int *)*size1);
  if (target==NULL) {
    printf("fail malloc\n");
  }
  for (i = 0; i < size1; i++) {
    target[i] = (int *)malloc(sizeof(int)*size2);
    if (target[i]==NULL) {
      printf("fail malloc\n");
      exit(1);
    }
  }
  return target;
}

double ***dmalloc_3d(int size1,int size2,int size3)
{
  int i,j;
  double ***target;
  target = (double ***)malloc(sizeof(double **)*size1);
  if (target==NULL) {
    printf("faile malloc\n");
  }
  for (i = 0; i < size1; i++) {
    target[i] = (double **)malloc(sizeof(double *)*size2);
    for (j = 0; j < size2; j++) {
      target[i][j] = (double *)malloc(sizeof(double)*size3);
    }
  }
  return target;
}

int ***imalloc_3d(int size1,int size2,int size3)
{
  int i,j;
  int ***target;
  target = (int ***)malloc(sizeof(int **)*size1);
  if (target==NULL) {
    printf("faile malloc\n");
  }
  for (i = 0; i < size1; i++) {
    target[i] = (int **)malloc(sizeof(int *)*size2);
    for (j = 0; j < size2; j++) {
      target[i][j] = (int *)malloc(sizeof(int)*size3);
    }
  }
  return target;
}

double ****dmalloc_4d(int size1,int size2,int size3,int size4)
{
  int i,j,k;
  double ****target;
  target = (double ****)malloc(sizeof(double ***)*size1);
  if (target==NULL) {
    printf("faile malloc\n");
  }
  for (i = 0; i < size1; i++) {
    target[i] = (double ***)malloc(sizeof(double **)*size2);
    for (j = 0; j < size2; j++) {
      target[i][j] = (double **)malloc(sizeof(double *)*size3);
      for (k = 0;  k<size3; k++) {
        target[i][j][k] = (double *)malloc(sizeof(double)*size4);
      }
    }
  }
  return target;
}

int ****imalloc_4d(int size1,int size2,int size3,int size4)
{
  int i,j,k;
  int ****target;
  target = (int ****)malloc(sizeof(int ***)*size1);
  if (target==NULL) {
    printf("faile malloc\n");
  }
  for (i = 0; i < size1; i++) {
    target[i] = (int ***)malloc(sizeof(int **)*size2);
    for (j = 0; j < size2; j++) {
      target[i][j] = (int **)malloc(sizeof(int *)*size3);
      for (k = 0;  k<size3; k++) {
        target[i][j][k] = (int *)malloc(sizeof(int)*size4);
      }
    }
  }
  return target;
}

/*free memory*/
void dfree_2d(double **target,int size1)
{
  int i;
  for (i = 0; i < size1; i++) {
    free(target[i]);
  }
  free(target);
}

void ifree_2d(int **target,int size1) {
  int i;
  for (i = 0; i < size1; i++) {
    free(target[i]);
  }
  free(target);
}

void dfree_3d(double ***target,int size1,int size2)
{
  int i,j;
  for (i = 0; i < size1; i++) {
    for (j = 0; j < size2; j++) {
      free(target[i][j]);
    }
    free(target[i]);
  }
  free(target);
}

void ifree_3d(int ***target,int size1,int size2)
{
  int i,j;
  for (i = 0; i < size1; i++) {
    for (j = 0; j < size2; j++) {
      free(target[i][j]);
    }
    free(target[i]);
  }
  free(target);
}

void dfree_4d(double ****target,int size1,int size2,int size3)
{
  int i,j,k;
  for (i = 0; i < size1; i++) {
    for (j = 0; j < size2; j++) {
      for (k = 0;  k<size3; k++) {
        free(target[i][j][k]);
      }
      free(target[i][j]);
    }
    free(target[i]);
  }
  free(target);
}

void ifree_4d(int ****target,int size1,int size2,int size3)
{
  int i,j,k;
  for (i = 0; i < size1; i++) {
    for (j = 0; j < size2; j++) {
      for (k = 0;  k<size3; k++) {
        free(target[i][j][k]);
      }
      free(target[i][j]);
    }
    free(target[i]);
  }
  free(target);
}

/*convolution image to feature map*/
void conv(int **input,int **fweight,int **fmap,const int ihei,
      const int iwid,const int fhei,const int fwid)
{
  int i,j,k,l;
  int pro;
  int sum=0;
  for (i = 0; i < ihei-4; i++) {
    for (j = 0; j < iwid-4; j++) {
      for (k = 0; k < fhei; k++) {
        for (l = 0; l < fwid; l++) {
          pro = input[i+k][j+l] * fweight[k][l];
          if (pro >= 0) pro = pro/(int)pow(2,8);
          else          pro = pro/(int)pow(2,8)-1;
          sum += pro;
        }
      }
      fmap[i][j] = sum;
      sum=0;
    }
  }
}

/*convolution feature map to feature map*/
void fm_fm(int ***infm,int ***outfm,int ****fweight,
       const int n_in,const int n_out,const int ihei,const int iwid,
       const int fhei,const int fwid)
{
  int i,j,k,l,o,p;
  int ***sum;

  sum = imalloc_3d(n_out,ihei-fhei+1,iwid-fwid+1);
  for (i = 0; i < n_out; i++) {
    for (j = 0; j < n_in; j++) {
      conv(infm[j],fweight[j][i],sum[i],ihei,iwid,fhei,fwid);
      for (k = 0;  k<ihei-fhei+1; k++) {
        for (l = 0; l < iwid-fwid+1; l++) {
          outfm[i][k][l] += sum[i][k][l];
        }
      }
    }
  }
  ifree_3d(sum,n_out,ihei-fhei+1);
}

/*max pooling*/
void max_pooling(int **fmap,int **pmap,const int fmhei,const int fmwid)
{
  int i,j,k,l;
  int max = INT_MIN;
  for (i = 0; i < fmhei; i=i+PHEI) {
    for (j = 0; j < fmwid; j=j+PWID) {
      for (k = 0;  k<PHEI; k++) {
        for (l = 0; l < PWID; l++) {
          if (fmap[i+k][j+l]>max) {
            max = fmap[i+k][j+l];
          }
        }
      }
      pmap[i/PHEI][j/PWID] = max;
      max=INT_MIN;
    }
  }
}

/*median pooling*/
void swap(int *input,int i,int j)
{
  int temp;

  temp = input[i];
  input[i] = input[j];
  input[j] = temp;
}

void median_pooling(int **fmap,int **pmap,const int fmhei,const int fmwid)
{
  int cluster[PHEI*PWID];
  int i,j,k,l;
  for (i = 0; i < fmhei; i=i+PHEI) {
    for (j = 0; j < fmwid; j=j+PWID) {
      for (k = 0; k < PHEI; k++) {
        for (l = 0; l < PWID; l++) {
          cluster[k*PWID+l] = fmap[i+k][j+l];
        }
      }
      for (k = 0;  k<PHEI*PWID-1; k++) {
        for (l=PHEI*PWID-1; l>k; l--) {
          if (cluster[l-1]>cluster[l]) {
            swap(cluster,l-1,l);
          }
        }
      }
      pmap[i/PHEI][j/PWID] = (cluster[1]+cluster[2])/2;

    }
  }
}

/*add bias*/
void add_bias(int **input,int bias,int ihei,int iwid)
{
  int i,j;
  for (i = 0; i < ihei; i++) {
    for (j = 0; j < iwid; j++) {
      input[i][j] = input[i][j] + bias;
    }
  }
}

/*activation by hinge function*/
void activate(int **input,const int ihei,const int iwid)
{
  int i,j;
  for (i = 0; i < ihei; i++) {
    for (j = 0; j < iwid; j++) {
      if (input[i][j]<0) {
        input[i][j] = 0;
      }
    }
  }
}

void activate_1d(int *input,const int ilen)
{
  int i;
  for (i = 0; i < ilen; i++) {
    if (input[i]<0) {
      input[i] = 0;
    }
  }
}

/*flatten 3D matrix*/
void flatten(int ***matrix,int *array,const int mdep,const int mhei,
       const int mwid)
{
  int i,j,k;
  for (i = 0; i < mdep; i++) {
    for (j = 0; j < mhei; j++) {
      for (k = 0;  k<mwid; k++) {
        array[i*mhei*mwid+j*mwid+k] = matrix[i][j][k];
      }
    }
  }
}

/*calculation of full connect layer*/
void full_connect(int *input,int *output,int **weight,
          int *bias,const int ilen,const int olen)
{
  int i,j;
  int pro;
  int sum=0;
  for (i = 0; i < olen; i++) {
    for (j = 0; j < ilen; j++) {
      pro = input[j] * weight[i][j];
      if (pro >= 0) sum += pro / (int)pow(2,8);
      else sum += pro / (int)pow(2,8)-1;
    }
    output[i] = sum + bias[i];
    sum=0;
  }
}

int softmax(double *output,int len)
{
  int i;
  double expsum=0.0;
  for (i = 0; i < len; i++) {
    expsum += exp(output[i]);
  }
  if (expsum==0) {
    return 1;
  } else {
    for (i = 0; i < len; i++) {
      output[i] = exp(output[i])/expsum;
    }
    return 0;
  }
}

int main (int argc, char *argv[])
{
  char filename[128];
  const int pm1hei = (IMHEI-FHEI+1)/PHEI; /*height of 1st pooled map*/
  const int pm1wid = (IMWID-FWID+1)/PWID; /*width of 1st pooled map*/
  const int pm2hei = (pm1hei-FHEI+1)/PHEI; /*height of 2nd pooled map*/
  const int pm2wid = (pm1wid-FWID+1)/PWID; /*height of 2nd pooled map*/
  double **dinput; /*input pixel(double)*/
  int **iinput; /*input pixel(Q 8.8)*/
  double ***df1weight; /*filter1 weight(double)*/
  int ***if1weight; /*filter1 weight(Q 8.8)*/
  double dbias1[N_F1]; /*feature map1 bias(Q8.8)*/
  int ibias1[N_F1]; /*feature map1 bias(double)*/
  double ****df2weight; /*filter2 weight(double)*/
  int ****if2weight; /*filter2 weight(Q8.8)*/
  double dbias2[N_F2]; /*feature map2 bias(double)*/
  int ibias2[N_F2]; /*feature map2 bias(Q8.8)*/
  double **dhweight; /*hidden layer weight(double)*/
  int **ihweight; /*hidden layer weight(Q8.8)*/
  double dhbias[N_HL]; /*hidden layer bias(double)*/
  int ihbias[N_HL]; /*hidden layer bias(Q8.8)*/
  double **doweight; /*output layer weight(double)*/
  int **ioweight; /*output layer weight(Q8.8)*/
  double dobias[LABEL]; /*output layer bias(double)*/
  int iobias[LABEL]; /*output layer bias(double)*/
  int ***ifmap1; /*feature map1(Q8.8)*/
  int ***ifmap2; /*feature map2(Q8.8)*/
  int ***ipmap1; /*pooled feature map1(Q8.8)*/
  int ***ipmap2; /*pooled feature map2(Q8.8)*/
  int ipmap2_flat[N_F2*pm2hei*pm2wid]; /*flat pooled map2(Q8.8)*/
  int ihunit[N_HL]; /*hidden layer unit(Q8.8)*/
  int ioutput[LABEL]; /*output(Q8.8)*/
  double doutput[LABEL]; /*output(double)*/
  int i,j,k; /*counter*/

  // memory allocation
  dinput    = dmalloc_2d(IMHEI,IMWID);
  iinput    = imalloc_2d(IMHEI,IMWID);
  df1weight = dmalloc_3d(N_F1,FHEI,FWID);
  if1weight = imalloc_3d(N_F1,FHEI,FWID);
  df2weight = dmalloc_4d(N_F1,N_F2,FHEI,FWID);
  if2weight = imalloc_4d(N_F1,N_F2,FHEI,FWID);
  dhweight  = dmalloc_2d(N_HL,pm2hei*pm2wid*N_F2);
  ihweight  = imalloc_2d(N_HL,pm2hei*pm2wid*N_F2);
  doweight  = dmalloc_2d(LABEL,N_HL);
  ioweight  = imalloc_2d(LABEL,N_HL);
  ifmap1    = imalloc_3d(N_F1,IMHEI-FHEI+1,IMWID-FWID+1);
  ipmap1    = imalloc_3d(N_F1,pm1hei,pm1wid);
  ifmap2    = imalloc_3d(N_F2,pm1hei-FHEI+1,pm1wid-FWID+1);
  ipmap2    = imalloc_3d(N_F2,pm2hei,pm2wid);

  int number = atoi(argv[1]);
  int sample = atoi(argv[2]);

  // load data
  sprintf(filename,
      "%s/bhewtek/data/mnist/input/%d/data%d.txt",
      where, number, sample);
  int r = load_image(filename,dinput,iinput,IMHEI,IMWID);
  if (r == -1) {
    fprintf(stderr, "load_image failed\n");
    exit(1);
  }

  for (i = 0; i < N_F1; i++) {
    sprintf(filename,
        "/home/work/takau/lazy_core/data/weight/wb_1/data%d.txt",i);
    load_data(filename,df1weight[i],if1weight[i],&dbias1[i],&ibias1[i],FHEI,FWID);
  }

  for (i = 0; i < N_F1; i++) {
    for (j = 0; j < N_F2; j++) {
      sprintf(filename,
          "/home/work/takau/lazy_core/data/weight/wb_2/data%d_%d.txt",j,i);
      load_w(filename,df2weight[i][j],if2weight[i][j],FHEI,FWID);
    }
  }

  for (i = 0; i < N_F2; i++) {
    sprintf(filename,
        "/home/work/takau/lazy_core/data/weight/wb_2/data%d.txt",i);
    load_b(filename,&dbias2[i],&ibias2[i]);
  }

  for (i = 0; i < N_HL; i++) {
    sprintf(filename,
        "/home/work/takau/lazy_core/data/weight/wb_3/data%d.txt",i);
    load_data_1d(filename,dhweight[i],ihweight[i],&dhbias[i],&ihbias[i],pm2hei*pm2wid*N_F2);
  }

  for (i = 0; i < LABEL; i++) {
    sprintf(filename,
        "/home/work/takau/lazy_core/data/weight/wb_4/data%d.txt",i);
    load_data_1d(filename,doweight[i],ioweight[i],&dobias[i],&iobias[i],N_HL);
  }

  // // image to feature map1
  // for (i = 0; i < N_F1; i++) {
  //   conv(iinput,if1weight[i],ifmap1[i],IMHEI,IMWID,FHEI,FWID);
  //   max_pooling(ifmap1[i],ipmap1[i],IMHEI-FHEI+1,IMWID-FWID+1);
  //   add_bias(ipmap1[i],ibias1[i],pm1hei,pm1wid);
  //   activate(ipmap1[i],pm1hei,pm1wid);
  // }
  //
  // // feature map1 to feature map2
  // fm_fm(ipmap1,ifmap2,if2weight,N_F1,N_F2,pm1hei,pm1wid,FHEI,FWID);
  // for (i = 0; i < N_F2; i++) {
  //   max_pooling(ifmap2[i],ipmap2[i],pm1hei-FHEI+1,pm1wid-FWID+1);
  //   add_bias(ipmap2[i],ibias2[i],pm2hei,pm2wid);
  //   activate(ipmap2[i],pm2hei,pm2wid);
  // }

  // image to feature map1
  for (i = 0; i < N_F1; i++) {
    conv(iinput,if1weight[i],ifmap1[i],IMHEI,IMWID,FHEI,FWID);
    add_bias(ifmap1[i],ibias1[i],IMHEI-FHEI+1,IMWID-FWID+1);
    activate(ifmap1[i],IMHEI-FHEI+1,IMWID-FWID+1);
    max_pooling(ifmap1[i],ipmap1[i],IMHEI-FHEI+1,IMWID-FWID+1);
  }

  // feature map1 to feature map2
  fm_fm(ipmap1,ifmap2,if2weight,N_F1,N_F2,pm1hei,pm1wid,FHEI,FWID);
  for (i = 0; i < N_F2; i++) {
    add_bias(ifmap2[i],ibias2[i],pm1hei-FHEI+1,pm1wid-FWID+1);
    activate(ifmap2[i],pm1hei-FHEI+1,pm1wid-FWID+1);
    max_pooling(ifmap2[i],ipmap2[i],pm1hei-FHEI+1,pm1wid-FWID+1);
  }

#ifdef IPMAP1
  for (i = 0; i < N_F1; i++)
    for (j = 0; j < pm1hei; j++)
      for (k = 0; k < pm1wid; k++)
        printf("%0d\n", ipmap1[i][j][k]);
#endif

#ifdef IFMAP2
  for (i = 0; i < N_F2; i++)
    for (j = 0; j < pm1hei-FHEI+1; j++)
      for (k = 0; k < pm1wid-FWID+1; k++)
        printf("%0d\n", ifmap2[i][j][k]);
#endif

#ifdef IPMAP2
  for (i = 0; i < N_F2; i++)
    for (j = 0; j < pm2hei; j++)
      for (k = 0; k < pm2wid; k++)
        printf("%0x\n", ipmap2[i][j][k]);
#endif

  // full connection layer
  flatten(ipmap2,ipmap2_flat,N_F2,pm2hei,pm2wid);
  full_connect(ipmap2_flat,ihunit,ihweight,ihbias,pm2hei*pm2wid*N_F2,N_HL);
  activate_1d(ihunit,N_HL);

#ifdef IHUNIT
  for (i = 0; i < N_HL; i++)
        printf("%0d\n", ihunit[i]);
#endif

  // output layer
  full_connect(ihunit,ioutput,ioweight,iobias,N_HL,LABEL);
  for (i = 0;  i<LABEL; i++) {
    doutput[i] = ioutput[i]/pow(2,8);
  }

  // verify the result
  int max = INT_MIN;
  int result = -1;
  for (i = 0; i < LABEL; i++) {
    if (ioutput[i] > max) {
      max = ioutput[i];
      result = i;
    }
  }
  assert(result == number);

  // free memory
  ifree_2d(iinput,IMHEI);
  ifree_3d(if1weight,N_F1,FHEI);
  ifree_4d(if2weight,N_F1,N_F2,FHEI);
  ifree_2d(ihweight,N_HL);
  ifree_2d(ioweight,LABEL);
  ifree_3d(ifmap1,N_F1,IMHEI-FHEI+1);
  ifree_3d(ipmap1,N_F1,pm1hei);
  ifree_3d(ifmap2,N_F2,pm1hei-FHEI+1);
  ifree_3d(ipmap2,N_F2,pm2hei);
  dfree_2d(dinput,IMHEI);
  dfree_3d(df1weight,N_F1,FHEI);
  dfree_4d(df2weight,N_F1,N_F2,FHEI);
  dfree_2d(dhweight,N_HL);
  dfree_2d(doweight,LABEL);

  return 0;
}
