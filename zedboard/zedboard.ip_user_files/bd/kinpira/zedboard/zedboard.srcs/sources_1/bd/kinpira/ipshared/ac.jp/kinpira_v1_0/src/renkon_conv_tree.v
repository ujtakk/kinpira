
module renkon_conv_tree(/*AUTOARG*/
   // Outputs
   fmap,
   // Inputs
   clk, xrst, pixel0, weight0, pixel1, weight1, pixel2, weight2,
   pixel3, weight3, pixel4, weight4, pixel5, weight5, pixel6, weight6,
   pixel7, weight7, pixel8, weight8, pixel9, weight9, pixel10,
   weight10, pixel11, weight11, pixel12, weight12, pixel13, weight13,
   pixel14, weight14, pixel15, weight15, pixel16, weight16, pixel17,
   weight17, pixel18, weight18, pixel19, weight19, pixel20, weight20,
   pixel21, weight21, pixel22, weight22, pixel23, weight23, pixel24,
   weight24
   );
`include "renkon.vh"

  /*AUTOINPUT*/
  input clk;
  input xrst;
  input signed [DWIDTH-1:0] pixel0;
  input signed [DWIDTH-1:0] weight0;
  input signed [DWIDTH-1:0] pixel1;
  input signed [DWIDTH-1:0] weight1;
  input signed [DWIDTH-1:0] pixel2;
  input signed [DWIDTH-1:0] weight2;
  input signed [DWIDTH-1:0] pixel3;
  input signed [DWIDTH-1:0] weight3;
  input signed [DWIDTH-1:0] pixel4;
  input signed [DWIDTH-1:0] weight4;
  input signed [DWIDTH-1:0] pixel5;
  input signed [DWIDTH-1:0] weight5;
  input signed [DWIDTH-1:0] pixel6;
  input signed [DWIDTH-1:0] weight6;
  input signed [DWIDTH-1:0] pixel7;
  input signed [DWIDTH-1:0] weight7;
  input signed [DWIDTH-1:0] pixel8;
  input signed [DWIDTH-1:0] weight8;
  input signed [DWIDTH-1:0] pixel9;
  input signed [DWIDTH-1:0] weight9;
  input signed [DWIDTH-1:0] pixel10;
  input signed [DWIDTH-1:0] weight10;
  input signed [DWIDTH-1:0] pixel11;
  input signed [DWIDTH-1:0] weight11;
  input signed [DWIDTH-1:0] pixel12;
  input signed [DWIDTH-1:0] weight12;
  input signed [DWIDTH-1:0] pixel13;
  input signed [DWIDTH-1:0] weight13;
  input signed [DWIDTH-1:0] pixel14;
  input signed [DWIDTH-1:0] weight14;
  input signed [DWIDTH-1:0] pixel15;
  input signed [DWIDTH-1:0] weight15;
  input signed [DWIDTH-1:0] pixel16;
  input signed [DWIDTH-1:0] weight16;
  input signed [DWIDTH-1:0] pixel17;
  input signed [DWIDTH-1:0] weight17;
  input signed [DWIDTH-1:0] pixel18;
  input signed [DWIDTH-1:0] weight18;
  input signed [DWIDTH-1:0] pixel19;
  input signed [DWIDTH-1:0] weight19;
  input signed [DWIDTH-1:0] pixel20;
  input signed [DWIDTH-1:0] weight20;
  input signed [DWIDTH-1:0] pixel21;
  input signed [DWIDTH-1:0] weight21;
  input signed [DWIDTH-1:0] pixel22;
  input signed [DWIDTH-1:0] weight22;
  input signed [DWIDTH-1:0] pixel23;
  input signed [DWIDTH-1:0] weight23;
  input signed [DWIDTH-1:0] pixel24;
  input signed [DWIDTH-1:0] weight24;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] fmap;

  /*AUTOWIRE*/
  wire signed[DWIDTH-1:0]   sum0;
  wire signed[DWIDTH-1:0]   sum1;
  wire signed[DWIDTH-1:0]   sum2;
  wire signed[DWIDTH-1:0]   sum3;
  wire signed[DWIDTH-1:0]   sum4;
  wire signed[DWIDTH-1:0]   sum5;
  wire signed[DWIDTH-1:0]   sum6;
  wire signed[DWIDTH-1:0]   sum7;
  wire signed[DWIDTH-1:0]   sum8;
  wire signed[DWIDTH-1:0]   sum9;
  wire signed[DWIDTH-1:0]   sum10;
  wire signed[DWIDTH-1:0]   sum11;
  wire signed[DWIDTH-1:0]   sum12;
  wire signed[DWIDTH-1:0]   sum13;
  wire signed[DWIDTH-1:0]   sum14;
  wire signed[DWIDTH-1:0]   sum15;
  wire signed[DWIDTH-1:0]   sum16;
  wire signed[DWIDTH-1:0]   sum17;
  wire signed[DWIDTH-1:0]   sum18;
  wire signed[DWIDTH-1:0]   sum19;
  wire signed[DWIDTH-1:0]   sum20;
  wire signed[DWIDTH-1:0]   sum21;
  wire signed[DWIDTH-1:0]   sum22;
  wire signed[DWIDTH-1:0]   sum23;
  wire signed[2*DWIDTH-1:0]   pro0;
  wire signed [DWIDTH-1:0]    pro_short0;
  wire signed[2*DWIDTH-1:0]   pro1;
  wire signed [DWIDTH-1:0]    pro_short1;
  wire signed[2*DWIDTH-1:0]   pro2;
  wire signed [DWIDTH-1:0]    pro_short2;
  wire signed[2*DWIDTH-1:0]   pro3;
  wire signed [DWIDTH-1:0]    pro_short3;
  wire signed[2*DWIDTH-1:0]   pro4;
  wire signed [DWIDTH-1:0]    pro_short4;
  wire signed[2*DWIDTH-1:0]   pro5;
  wire signed [DWIDTH-1:0]    pro_short5;
  wire signed[2*DWIDTH-1:0]   pro6;
  wire signed [DWIDTH-1:0]    pro_short6;
  wire signed[2*DWIDTH-1:0]   pro7;
  wire signed [DWIDTH-1:0]    pro_short7;
  wire signed[2*DWIDTH-1:0]   pro8;
  wire signed [DWIDTH-1:0]    pro_short8;
  wire signed[2*DWIDTH-1:0]   pro9;
  wire signed [DWIDTH-1:0]    pro_short9;
  wire signed[2*DWIDTH-1:0]   pro10;
  wire signed [DWIDTH-1:0]    pro_short10;
  wire signed[2*DWIDTH-1:0]   pro11;
  wire signed [DWIDTH-1:0]    pro_short11;
  wire signed[2*DWIDTH-1:0]   pro12;
  wire signed [DWIDTH-1:0]    pro_short12;
  wire signed[2*DWIDTH-1:0]   pro13;
  wire signed [DWIDTH-1:0]    pro_short13;
  wire signed[2*DWIDTH-1:0]   pro14;
  wire signed [DWIDTH-1:0]    pro_short14;
  wire signed[2*DWIDTH-1:0]   pro15;
  wire signed [DWIDTH-1:0]    pro_short15;
  wire signed[2*DWIDTH-1:0]   pro16;
  wire signed [DWIDTH-1:0]    pro_short16;
  wire signed[2*DWIDTH-1:0]   pro17;
  wire signed [DWIDTH-1:0]    pro_short17;
  wire signed[2*DWIDTH-1:0]   pro18;
  wire signed [DWIDTH-1:0]    pro_short18;
  wire signed[2*DWIDTH-1:0]   pro19;
  wire signed [DWIDTH-1:0]    pro_short19;
  wire signed[2*DWIDTH-1:0]   pro20;
  wire signed [DWIDTH-1:0]    pro_short20;
  wire signed[2*DWIDTH-1:0]   pro21;
  wire signed [DWIDTH-1:0]    pro_short21;
  wire signed[2*DWIDTH-1:0]   pro22;
  wire signed [DWIDTH-1:0]    pro_short22;
  wire signed[2*DWIDTH-1:0]   pro23;
  wire signed [DWIDTH-1:0]    pro_short23;
  wire signed[2*DWIDTH-1:0]   pro24;
  wire signed [DWIDTH-1:0]    pro_short24;

  /*AUTOREG*/
  reg signed[DWIDTH-1:0]    r_fmap;
  reg signed [DWIDTH-1:0]   r_pixel0;
  reg signed [DWIDTH-1:0]   r_weight0;
  reg signed [2*DWIDTH-1:0] r_pro0;
  reg signed [DWIDTH-1:0]   r_pro_short0;
  reg signed [DWIDTH-1:0]   r_pixel1;
  reg signed [DWIDTH-1:0]   r_weight1;
  reg signed [2*DWIDTH-1:0] r_pro1;
  reg signed [DWIDTH-1:0]   r_pro_short1;
  reg signed [DWIDTH-1:0]   r_pixel2;
  reg signed [DWIDTH-1:0]   r_weight2;
  reg signed [2*DWIDTH-1:0] r_pro2;
  reg signed [DWIDTH-1:0]   r_pro_short2;
  reg signed [DWIDTH-1:0]   r_pixel3;
  reg signed [DWIDTH-1:0]   r_weight3;
  reg signed [2*DWIDTH-1:0] r_pro3;
  reg signed [DWIDTH-1:0]   r_pro_short3;
  reg signed [DWIDTH-1:0]   r_pixel4;
  reg signed [DWIDTH-1:0]   r_weight4;
  reg signed [2*DWIDTH-1:0] r_pro4;
  reg signed [DWIDTH-1:0]   r_pro_short4;
  reg signed [DWIDTH-1:0]   r_pixel5;
  reg signed [DWIDTH-1:0]   r_weight5;
  reg signed [2*DWIDTH-1:0] r_pro5;
  reg signed [DWIDTH-1:0]   r_pro_short5;
  reg signed [DWIDTH-1:0]   r_pixel6;
  reg signed [DWIDTH-1:0]   r_weight6;
  reg signed [2*DWIDTH-1:0] r_pro6;
  reg signed [DWIDTH-1:0]   r_pro_short6;
  reg signed [DWIDTH-1:0]   r_pixel7;
  reg signed [DWIDTH-1:0]   r_weight7;
  reg signed [2*DWIDTH-1:0] r_pro7;
  reg signed [DWIDTH-1:0]   r_pro_short7;
  reg signed [DWIDTH-1:0]   r_pixel8;
  reg signed [DWIDTH-1:0]   r_weight8;
  reg signed [2*DWIDTH-1:0] r_pro8;
  reg signed [DWIDTH-1:0]   r_pro_short8;
  reg signed [DWIDTH-1:0]   r_pixel9;
  reg signed [DWIDTH-1:0]   r_weight9;
  reg signed [2*DWIDTH-1:0] r_pro9;
  reg signed [DWIDTH-1:0]   r_pro_short9;
  reg signed [DWIDTH-1:0]   r_pixel10;
  reg signed [DWIDTH-1:0]   r_weight10;
  reg signed [2*DWIDTH-1:0] r_pro10;
  reg signed [DWIDTH-1:0]   r_pro_short10;
  reg signed [DWIDTH-1:0]   r_pixel11;
  reg signed [DWIDTH-1:0]   r_weight11;
  reg signed [2*DWIDTH-1:0] r_pro11;
  reg signed [DWIDTH-1:0]   r_pro_short11;
  reg signed [DWIDTH-1:0]   r_pixel12;
  reg signed [DWIDTH-1:0]   r_weight12;
  reg signed [2*DWIDTH-1:0] r_pro12;
  reg signed [DWIDTH-1:0]   r_pro_short12;
  reg signed [DWIDTH-1:0]   r_pixel13;
  reg signed [DWIDTH-1:0]   r_weight13;
  reg signed [2*DWIDTH-1:0] r_pro13;
  reg signed [DWIDTH-1:0]   r_pro_short13;
  reg signed [DWIDTH-1:0]   r_pixel14;
  reg signed [DWIDTH-1:0]   r_weight14;
  reg signed [2*DWIDTH-1:0] r_pro14;
  reg signed [DWIDTH-1:0]   r_pro_short14;
  reg signed [DWIDTH-1:0]   r_pixel15;
  reg signed [DWIDTH-1:0]   r_weight15;
  reg signed [2*DWIDTH-1:0] r_pro15;
  reg signed [DWIDTH-1:0]   r_pro_short15;
  reg signed [DWIDTH-1:0]   r_pixel16;
  reg signed [DWIDTH-1:0]   r_weight16;
  reg signed [2*DWIDTH-1:0] r_pro16;
  reg signed [DWIDTH-1:0]   r_pro_short16;
  reg signed [DWIDTH-1:0]   r_pixel17;
  reg signed [DWIDTH-1:0]   r_weight17;
  reg signed [2*DWIDTH-1:0] r_pro17;
  reg signed [DWIDTH-1:0]   r_pro_short17;
  reg signed [DWIDTH-1:0]   r_pixel18;
  reg signed [DWIDTH-1:0]   r_weight18;
  reg signed [2*DWIDTH-1:0] r_pro18;
  reg signed [DWIDTH-1:0]   r_pro_short18;
  reg signed [DWIDTH-1:0]   r_pixel19;
  reg signed [DWIDTH-1:0]   r_weight19;
  reg signed [2*DWIDTH-1:0] r_pro19;
  reg signed [DWIDTH-1:0]   r_pro_short19;
  reg signed [DWIDTH-1:0]   r_pixel20;
  reg signed [DWIDTH-1:0]   r_weight20;
  reg signed [2*DWIDTH-1:0] r_pro20;
  reg signed [DWIDTH-1:0]   r_pro_short20;
  reg signed [DWIDTH-1:0]   r_pixel21;
  reg signed [DWIDTH-1:0]   r_weight21;
  reg signed [2*DWIDTH-1:0] r_pro21;
  reg signed [DWIDTH-1:0]   r_pro_short21;
  reg signed [DWIDTH-1:0]   r_pixel22;
  reg signed [DWIDTH-1:0]   r_weight22;
  reg signed [2*DWIDTH-1:0] r_pro22;
  reg signed [DWIDTH-1:0]   r_pro_short22;
  reg signed [DWIDTH-1:0]   r_pixel23;
  reg signed [DWIDTH-1:0]   r_weight23;
  reg signed [2*DWIDTH-1:0] r_pro23;
  reg signed [DWIDTH-1:0]   r_pro_short23;
  reg signed [DWIDTH-1:0]   r_pixel24;
  reg signed [DWIDTH-1:0]   r_weight24;
  reg signed [2*DWIDTH-1:0] r_pro24;
  reg signed [DWIDTH-1:0]   r_pro_short24;
  reg signed [DWIDTH-1:0] r_sum0;
  reg signed [DWIDTH-1:0] r_sum1;
  reg signed [DWIDTH-1:0] r_sum2;
  reg signed [DWIDTH-1:0] r_sum3;
  reg signed [DWIDTH-1:0] r_sum4;
  reg signed [DWIDTH-1:0] r_sum5;
  reg signed [DWIDTH-1:0] r_sum6;
  reg signed [DWIDTH-1:0] r_sum7;
  reg signed [DWIDTH-1:0] r_sum8;
  reg signed [DWIDTH-1:0] r_sum9;
  reg signed [DWIDTH-1:0] r_sum10;
  reg signed [DWIDTH-1:0] r_sum11;
  reg signed [DWIDTH-1:0] r_sum12;
  reg signed [DWIDTH-1:0] r_sum13;
  reg signed [DWIDTH-1:0] r_sum14;
  reg signed [DWIDTH-1:0] r_sum15;
  reg signed [DWIDTH-1:0] r_sum16;
  reg signed [DWIDTH-1:0] r_sum17;
  reg signed [DWIDTH-1:0] r_sum18;
  reg signed [DWIDTH-1:0] r_sum19;
  reg signed [DWIDTH-1:0] r_sum20;
  reg signed [DWIDTH-1:0] r_sum21;
  reg signed [DWIDTH-1:0] r_sum22;
  reg signed [DWIDTH-1:0] r_sum23;
  reg signed [DWIDTH-1:0] pro_short24_d1;
  reg signed [DWIDTH-1:0] pro_short24_d2;
  reg signed [DWIDTH-1:0] pro_short24_d3;
  reg signed [DWIDTH-1:0] pro_short24_d4;

  assign pro0 = (r_pixel0 * r_weight0);
  assign pro1 = (r_pixel1 * r_weight1);
  assign pro2 = (r_pixel2 * r_weight2);
  assign pro3 = (r_pixel3 * r_weight3);
  assign pro4 = (r_pixel4 * r_weight4);
  assign pro5 = (r_pixel5 * r_weight5);
  assign pro6 = (r_pixel6 * r_weight6);
  assign pro7 = (r_pixel7 * r_weight7);
  assign pro8 = (r_pixel8 * r_weight8);
  assign pro9 = (r_pixel9 * r_weight9);
  assign pro10 = (r_pixel10 * r_weight10);
  assign pro11 = (r_pixel11 * r_weight11);
  assign pro12 = (r_pixel12 * r_weight12);
  assign pro13 = (r_pixel13 * r_weight13);
  assign pro14 = (r_pixel14 * r_weight14);
  assign pro15 = (r_pixel15 * r_weight15);
  assign pro16 = (r_pixel16 * r_weight16);
  assign pro17 = (r_pixel17 * r_weight17);
  assign pro18 = (r_pixel18 * r_weight18);
  assign pro19 = (r_pixel19 * r_weight19);
  assign pro20 = (r_pixel20 * r_weight20);
  assign pro21 = (r_pixel21 * r_weight21);
  assign pro22 = (r_pixel22 * r_weight22);
  assign pro23 = (r_pixel23 * r_weight23);
  assign pro24 = (r_pixel24 * r_weight24);

  //assign pro_short0 = $signed({pro0[22],pro0[22:8]});
  assign pro_short0 = $signed({r_pro0[22], round(r_pro0[22:0])});
  //assign pro_short1 = $signed({pro1[22],pro1[22:8]});
  assign pro_short1 = $signed({r_pro1[22], round(r_pro1[22:0])});
  //assign pro_short2 = $signed({pro2[22],pro2[22:8]});
  assign pro_short2 = $signed({r_pro2[22], round(r_pro2[22:0])});
  //assign pro_short3 = $signed({pro3[22],pro3[22:8]});
  assign pro_short3 = $signed({r_pro3[22], round(r_pro3[22:0])});
  //assign pro_short4 = $signed({pro4[22],pro4[22:8]});
  assign pro_short4 = $signed({r_pro4[22], round(r_pro4[22:0])});
  //assign pro_short5 = $signed({pro5[22],pro5[22:8]});
  assign pro_short5 = $signed({r_pro5[22], round(r_pro5[22:0])});
  //assign pro_short6 = $signed({pro6[22],pro6[22:8]});
  assign pro_short6 = $signed({r_pro6[22], round(r_pro6[22:0])});
  //assign pro_short7 = $signed({pro7[22],pro7[22:8]});
  assign pro_short7 = $signed({r_pro7[22], round(r_pro7[22:0])});
  //assign pro_short8 = $signed({pro8[22],pro8[22:8]});
  assign pro_short8 = $signed({r_pro8[22], round(r_pro8[22:0])});
  //assign pro_short9 = $signed({pro9[22],pro9[22:8]});
  assign pro_short9 = $signed({r_pro9[22], round(r_pro9[22:0])});
  //assign pro_short10 = $signed({pro10[22],pro10[22:8]});
  assign pro_short10 = $signed({r_pro10[22], round(r_pro10[22:0])});
  //assign pro_short11 = $signed({pro11[22],pro11[22:8]});
  assign pro_short11 = $signed({r_pro11[22], round(r_pro11[22:0])});
  //assign pro_short12 = $signed({pro12[22],pro12[22:8]});
  assign pro_short12 = $signed({r_pro12[22], round(r_pro12[22:0])});
  //assign pro_short13 = $signed({pro13[22],pro13[22:8]});
  assign pro_short13 = $signed({r_pro13[22], round(r_pro13[22:0])});
  //assign pro_short14 = $signed({pro14[22],pro14[22:8]});
  assign pro_short14 = $signed({r_pro14[22], round(r_pro14[22:0])});
  //assign pro_short15 = $signed({pro15[22],pro15[22:8]});
  assign pro_short15 = $signed({r_pro15[22], round(r_pro15[22:0])});
  //assign pro_short16 = $signed({pro16[22],pro16[22:8]});
  assign pro_short16 = $signed({r_pro16[22], round(r_pro16[22:0])});
  //assign pro_short17 = $signed({pro17[22],pro17[22:8]});
  assign pro_short17 = $signed({r_pro17[22], round(r_pro17[22:0])});
  //assign pro_short18 = $signed({pro18[22],pro18[22:8]});
  assign pro_short18 = $signed({r_pro18[22], round(r_pro18[22:0])});
  //assign pro_short19 = $signed({pro19[22],pro19[22:8]});
  assign pro_short19 = $signed({r_pro19[22], round(r_pro19[22:0])});
  //assign pro_short20 = $signed({pro20[22],pro20[22:8]});
  assign pro_short20 = $signed({r_pro20[22], round(r_pro20[22:0])});
  //assign pro_short21 = $signed({pro21[22],pro21[22:8]});
  assign pro_short21 = $signed({r_pro21[22], round(r_pro21[22:0])});
  //assign pro_short22 = $signed({pro22[22],pro22[22:8]});
  assign pro_short22 = $signed({r_pro22[22], round(r_pro22[22:0])});
  //assign pro_short23 = $signed({pro23[22],pro23[22:8]});
  assign pro_short23 = $signed({r_pro23[22], round(r_pro23[22:0])});
  //assign pro_short24 = $signed({pro24[22],pro24[22:8]});
  assign pro_short24 = $signed({r_pro24[22], round(r_pro24[22:0])});

  assign sum0 = sum1 + sum2;

  assign sum1 = r_sum3 + r_sum4;
  assign sum2 = r_sum5 + pro_short24_d2;

  assign sum3 = sum7 + sum6;
  assign sum4 = sum9 + sum8;
  assign sum5 = sum11 + sum10;

  assign sum6 = sum13 + sum12;
  assign sum7 = sum15 + sum14;
  assign sum8 = sum17 + sum16;
  assign sum9 = sum19 + sum18;
  assign sum10 = sum21 + sum20;
  assign sum11 = sum23 + sum22;

  assign sum12 = r_pro_short1 + r_pro_short0;
  assign sum13 = r_pro_short3 + r_pro_short2;
  assign sum14 = r_pro_short5 + r_pro_short4;
  assign sum15 = r_pro_short7 + r_pro_short6;
  assign sum16 = r_pro_short9 + r_pro_short8;
  assign sum17 = r_pro_short11 + r_pro_short10;
  assign sum18 = r_pro_short13 + r_pro_short12;
  assign sum19 = r_pro_short15 + r_pro_short14;
  assign sum20 = r_pro_short17 + r_pro_short16;
  assign sum21 = r_pro_short19 + r_pro_short18;
  assign sum22 = r_pro_short21 + r_pro_short20;
  assign sum23 = r_pro_short23 + r_pro_short22;

  always @(posedge clk)
    pro_short24_d1 <= pro_short24;
  always @(posedge clk)
    pro_short24_d2 <= pro_short24_d1;
  always @(posedge clk)
    pro_short24_d3 <= pro_short24_d2;
  always @(posedge clk)
    pro_short24_d4 <= pro_short24_d3;

  always @(posedge clk)
    r_sum0 <= sum0;
  always @(posedge clk)
    r_sum1 <= sum1;
  always @(posedge clk)
    r_sum2 <= sum2;
  always @(posedge clk)
    r_sum3 <= sum3;
  always @(posedge clk)
    r_sum4 <= sum4;
  always @(posedge clk)
    r_sum5 <= sum5;
  always @(posedge clk)
    r_sum6 <= sum6;
  always @(posedge clk)
    r_sum7 <= sum7;
  always @(posedge clk)
    r_sum8 <= sum8;
  always @(posedge clk)
    r_sum9 <= sum9;
  always @(posedge clk)
    r_sum10 <= sum10;
  always @(posedge clk)
    r_sum11 <= sum11;
  always @(posedge clk)
    r_sum12 <= sum12;
  always @(posedge clk)
    r_sum13 <= sum13;
  always @(posedge clk)
    r_sum14 <= sum14;
  always @(posedge clk)
    r_sum15 <= sum15;
  always @(posedge clk)
    r_sum16 <= sum16;
  always @(posedge clk)
    r_sum17 <= sum17;
  always @(posedge clk)
    r_sum18 <= sum18;
  always @(posedge clk)
    r_sum19 <= sum19;
  always @(posedge clk)
    r_sum20 <= sum20;
  always @(posedge clk)
    r_sum21 <= sum21;
  always @(posedge clk)
    r_sum22 <= sum22;
  always @(posedge clk)
    r_sum23 <= sum23;

  always @(posedge clk)
    r_pro0 <= pro0;
  always @(posedge clk)
    r_pro_short0 <= pro_short0;
  always @(posedge clk)
    r_pro1 <= pro1;
  always @(posedge clk)
    r_pro_short1 <= pro_short1;
  always @(posedge clk)
    r_pro2 <= pro2;
  always @(posedge clk)
    r_pro_short2 <= pro_short2;
  always @(posedge clk)
    r_pro3 <= pro3;
  always @(posedge clk)
    r_pro_short3 <= pro_short3;
  always @(posedge clk)
    r_pro4 <= pro4;
  always @(posedge clk)
    r_pro_short4 <= pro_short4;
  always @(posedge clk)
    r_pro5 <= pro5;
  always @(posedge clk)
    r_pro_short5 <= pro_short5;
  always @(posedge clk)
    r_pro6 <= pro6;
  always @(posedge clk)
    r_pro_short6 <= pro_short6;
  always @(posedge clk)
    r_pro7 <= pro7;
  always @(posedge clk)
    r_pro_short7 <= pro_short7;
  always @(posedge clk)
    r_pro8 <= pro8;
  always @(posedge clk)
    r_pro_short8 <= pro_short8;
  always @(posedge clk)
    r_pro9 <= pro9;
  always @(posedge clk)
    r_pro_short9 <= pro_short9;
  always @(posedge clk)
    r_pro10 <= pro10;
  always @(posedge clk)
    r_pro_short10 <= pro_short10;
  always @(posedge clk)
    r_pro11 <= pro11;
  always @(posedge clk)
    r_pro_short11 <= pro_short11;
  always @(posedge clk)
    r_pro12 <= pro12;
  always @(posedge clk)
    r_pro_short12 <= pro_short12;
  always @(posedge clk)
    r_pro13 <= pro13;
  always @(posedge clk)
    r_pro_short13 <= pro_short13;
  always @(posedge clk)
    r_pro14 <= pro14;
  always @(posedge clk)
    r_pro_short14 <= pro_short14;
  always @(posedge clk)
    r_pro15 <= pro15;
  always @(posedge clk)
    r_pro_short15 <= pro_short15;
  always @(posedge clk)
    r_pro16 <= pro16;
  always @(posedge clk)
    r_pro_short16 <= pro_short16;
  always @(posedge clk)
    r_pro17 <= pro17;
  always @(posedge clk)
    r_pro_short17 <= pro_short17;
  always @(posedge clk)
    r_pro18 <= pro18;
  always @(posedge clk)
    r_pro_short18 <= pro_short18;
  always @(posedge clk)
    r_pro19 <= pro19;
  always @(posedge clk)
    r_pro_short19 <= pro_short19;
  always @(posedge clk)
    r_pro20 <= pro20;
  always @(posedge clk)
    r_pro_short20 <= pro_short20;
  always @(posedge clk)
    r_pro21 <= pro21;
  always @(posedge clk)
    r_pro_short21 <= pro_short21;
  always @(posedge clk)
    r_pro22 <= pro22;
  always @(posedge clk)
    r_pro_short22 <= pro_short22;
  always @(posedge clk)
    r_pro23 <= pro23;
  always @(posedge clk)
    r_pro_short23 <= pro_short23;
  always @(posedge clk)
    r_pro24 <= pro24;
  always @(posedge clk)
    r_pro_short24 <= pro_short24;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel0 <= 0;
    else
      r_pixel0 <= pixel0;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel1 <= 0;
    else
      r_pixel1 <= pixel1;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel2 <= 0;
    else
      r_pixel2 <= pixel2;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel3 <= 0;
    else
      r_pixel3 <= pixel3;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel4 <= 0;
    else
      r_pixel4 <= pixel4;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel5 <= 0;
    else
      r_pixel5 <= pixel5;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel6 <= 0;
    else
      r_pixel6 <= pixel6;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel7 <= 0;
    else
      r_pixel7 <= pixel7;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel8 <= 0;
    else
      r_pixel8 <= pixel8;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel9 <= 0;
    else
      r_pixel9 <= pixel9;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel10 <= 0;
    else
      r_pixel10 <= pixel10;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel11 <= 0;
    else
      r_pixel11 <= pixel11;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel12 <= 0;
    else
      r_pixel12 <= pixel12;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel13 <= 0;
    else
      r_pixel13 <= pixel13;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel14 <= 0;
    else
      r_pixel14 <= pixel14;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel15 <= 0;
    else
      r_pixel15 <= pixel15;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel16 <= 0;
    else
      r_pixel16 <= pixel16;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel17 <= 0;
    else
      r_pixel17 <= pixel17;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel18 <= 0;
    else
      r_pixel18 <= pixel18;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel19 <= 0;
    else
      r_pixel19 <= pixel19;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel20 <= 0;
    else
      r_pixel20 <= pixel20;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel21 <= 0;
    else
      r_pixel21 <= pixel21;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel22 <= 0;
    else
      r_pixel22 <= pixel22;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel23 <= 0;
    else
      r_pixel23 <= pixel23;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_pixel24 <= 0;
    else
      r_pixel24 <= pixel24;


  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight0 <= 0;
    else
      r_weight0 <= weight0;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight1 <= 0;
    else
      r_weight1 <= weight1;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight2 <= 0;
    else
      r_weight2 <= weight2;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight3 <= 0;
    else
      r_weight3 <= weight3;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight4 <= 0;
    else
      r_weight4 <= weight4;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight5 <= 0;
    else
      r_weight5 <= weight5;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight6 <= 0;
    else
      r_weight6 <= weight6;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight7 <= 0;
    else
      r_weight7 <= weight7;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight8 <= 0;
    else
      r_weight8 <= weight8;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight9 <= 0;
    else
      r_weight9 <= weight9;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight10 <= 0;
    else
      r_weight10 <= weight10;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight11 <= 0;
    else
      r_weight11 <= weight11;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight12 <= 0;
    else
      r_weight12 <= weight12;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight13 <= 0;
    else
      r_weight13 <= weight13;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight14 <= 0;
    else
      r_weight14 <= weight14;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight15 <= 0;
    else
      r_weight15 <= weight15;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight16 <= 0;
    else
      r_weight16 <= weight16;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight17 <= 0;
    else
      r_weight17 <= weight17;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight18 <= 0;
    else
      r_weight18 <= weight18;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight19 <= 0;
    else
      r_weight19 <= weight19;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight20 <= 0;
    else
      r_weight20 <= weight20;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight21 <= 0;
    else
      r_weight21 <= weight21;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight22 <= 0;
    else
      r_weight22 <= weight22;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight23 <= 0;
    else
      r_weight23 <= weight23;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_weight24 <= 0;
    else
      r_weight24 <= weight24;

  assign fmap = r_fmap;

  always @(posedge clk or negedge xrst)
    if(!xrst)
      r_fmap <= 0;
    else
      r_fmap <= sum0;

////////////////////////////////////////////////////////////
//  Function
////////////////////////////////////////////////////////////

  function signed [14:0] round;
    input [22:0] data;
    if (data[22] == 1'b1 && data[7:0] == 8'd0)
      round = data[22:8] - 1;
    else
      round = data[22:8];
  endfunction

endmodule
