// % weight = "/home/work/takau/1.hw/bhewtek/hashed/train/lh_t"

`timescale 1ns/1ps

module test_renkon();
`include "renkon.vh"

  /*AUTOREGINPUT*/
  // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
  reg			clk;			// To dut0 of renkon.v
  reg [LWIDTH-1:0]	fil_size;		// To dut0 of renkon.v
  reg [LWIDTH-1:0]	img_size;		// To dut0 of renkon.v
  reg			img_we;			// To dut0 of renkon.v
  reg [IMGSIZE-1:0]	input_addr;		// To dut0 of renkon.v
  reg [NETSIZE-1:0]	net_addr;		// To dut0 of renkon.v
  reg [CORELOG:0]	net_we;			// To dut0 of renkon.v
  reg [IMGSIZE-1:0]	output_addr;		// To dut0 of renkon.v
  reg [LWIDTH-1:0]	pool_size;		// To dut0 of renkon.v
  reg signed [DWIDTH-1:0] read_img;		// To dut0 of renkon.v
  reg			req;			// To dut0 of renkon.v
  reg [LWIDTH-1:0]	total_in;		// To dut0 of renkon.v
  reg [LWIDTH-1:0]	total_out;		// To dut0 of renkon.v
  reg signed [DWIDTH-1:0] write_img;		// To dut0 of renkon.v
  reg signed [DWIDTH-1:0] write_net;		// To dut0 of renkon.v
  reg			xrst;			// To dut0 of renkon.v
  // End of automatics
  reg [DWIDTH-1:0] mem_i [2**IMGSIZE-1:0];
  reg [DWIDTH-1:0] mem_n0 [2**NETSIZE-1:0];
  reg [DWIDTH-1:0] mem_n1 [2**NETSIZE-1:0];
  reg [DWIDTH-1:0] mem_n2 [2**NETSIZE-1:0];
  reg [DWIDTH-1:0] mem_n3 [2**NETSIZE-1:0];
  reg [DWIDTH-1:0] mem_n4 [2**NETSIZE-1:0];
  reg [DWIDTH-1:0] mem_n5 [2**NETSIZE-1:0];
  reg [DWIDTH-1:0] mem_n6 [2**NETSIZE-1:0];
  reg [DWIDTH-1:0] mem_n7 [2**NETSIZE-1:0];


  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire			ack;			// From dut0 of renkon.v
  wire [IMGSIZE-1:0]	mem_img_addr;		// From dut0 of renkon.v
  wire			mem_img_we;		// From dut0 of renkon.v
  wire signed [DWIDTH-1:0] write_mem_img;	// From dut0 of renkon.v
  // End of automatics

  //clock
  always
  begin
    clk = 0;
    #(STEP/2);
    clk = 1;
    #(STEP/2);
  end

  integer i;
  integer gd;
  initial
  begin
    // $set_toggle_region(test_renkon.dut0);

    xrst = 0;
    clk = 0;
    xrst = 0;
    req = 0;
    img_we = 0;
    input_addr = 0;
    output_addr = 0;
    write_img = 0;
    net_we = 0;
    net_addr = 0;
    write_net = 0;
    total_out = 0;
    total_in = 0;
    img_size = 0;
    fil_size = 0;
    pool_size = 0;
    // mem_clear;
    mem_clear_direct;
    #(STEP);

    xrst        = 1;
    req         = 0;
    total_out   = N_F2;
    total_in    = N_F1;
    img_size    = 12;
    fil_size    = FSIZE;
    pool_size   = PSIZE;
    input_addr  = 0;
    output_addr = 5000;
    net_addr    = 0;

    // read_image_direct;
    read_image;

    // read_network_direct;
    read_network;

    // $toggle_start();
    #(STEP);

    req = 1;
    #(STEP);
    req = 0;

    while(!ack) #(STEP);
    #(STEP*10);
    // $toggle_stop();
    // $toggle_report(
    //   "renkon2_4.saif",
    //   1.0e-9,
    //   "test_renkon.dut0"
    // );

    // valid_memin;
    // valid_memw;
    write_output;

    $finish();
  end

  renkon dut0(/*AUTOINST*/
	      // Outputs
	      .ack			(ack),
	      .mem_img_we		(mem_img_we),
	      .mem_img_addr		(mem_img_addr[IMGSIZE-1:0]),
	      .write_mem_img		(write_mem_img[DWIDTH-1:0]),
	      // Inputs
	      .clk			(clk),
	      .xrst			(xrst),
	      .req			(req),
	      .img_we			(img_we),
	      .input_addr		(input_addr[IMGSIZE-1:0]),
	      .output_addr		(output_addr[IMGSIZE-1:0]),
	      .write_img		(write_img[DWIDTH-1:0]),
	      .net_we			(net_we[CORELOG:0]),
	      .net_addr			(net_addr[NETSIZE-1:0]),
	      .write_net		(write_net[DWIDTH-1:0]),
	      .total_out		(total_out[LWIDTH-1:0]),
	      .total_in			(total_in[LWIDTH-1:0]),
	      .img_size			(img_size[LWIDTH-1:0]),
	      .fil_size			(fil_size[LWIDTH-1:0]),
	      .pool_size		(pool_size[LWIDTH-1:0]),
	      .read_img			(read_img[DWIDTH-1:0]));

  task mem_clear;
    begin // {{{
      for (i=0; i<2**IMGSIZE; i=i+1)
        mem_i[i] = {DWIDTH{1'b0}};

      for (i=0; i<2**NETSIZE; i=i+1)
        mem_n0[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        mem_n1[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        mem_n2[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        mem_n3[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        mem_n4[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        mem_n5[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        mem_n6[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        mem_n7[i] = {DWIDTH{1'b0}};
    end // }}}
  endtask

  task mem_clear_direct;
    begin // {{{
      for (i=0; i<2**IMGSIZE; i=i+1)
        dut0.mem_img.mem[i] = {DWIDTH{1'b0}};

      for (i=0; i<2**NETSIZE; i=i+1)
        dut0.mem_net0.mem[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        dut0.mem_net1.mem[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        dut0.mem_net2.mem[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        dut0.mem_net3.mem[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        dut0.mem_net4.mem[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        dut0.mem_net5.mem[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        dut0.mem_net6.mem[i] = {DWIDTH{1'b0}};
      for (i=0; i<2**NETSIZE; i=i+1)
        dut0.mem_net7.mem[i] = {DWIDTH{1'b0}};
    end // }}}
  endtask

  task read_image;
    integer fd;
    begin // {{{
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_0.bin",
        mem_i,
        0,
        143
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_1.bin",
        mem_i,
        144,
        287
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_2.bin",
        mem_i,
        288,
        431
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_3.bin",
        mem_i,
        432,
        575
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_4.bin",
        mem_i,
        576,
        719
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_5.bin",
        mem_i,
        720,
        863
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_6.bin",
        mem_i,
        864,
        1007
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_7.bin",
        mem_i,
        1008,
        1151
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_8.bin",
        mem_i,
        1152,
        1295
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_9.bin",
        mem_i,
        1296,
        1439
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_10.bin",
        mem_i,
        1440,
        1583
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_11.bin",
        mem_i,
        1584,
        1727
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_12.bin",
        mem_i,
        1728,
        1871
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_13.bin",
        mem_i,
        1872,
        2015
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_14.bin",
        mem_i,
        2016,
        2159
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_15.bin",
        mem_i,
        2160,
        2303
      );
      #(STEP);
      img_we = 1;
      fd = $fopen("asdf");
      for (i=0; i<2**IMGSIZE; i=i+1)
      begin
        $fdisplay(fd, "%d", mem_i[i]);
        input_addr = i;
        #(STEP);
        write_img = mem_i[i];
        #(STEP);
      end
      $fclose(fd);
      #(STEP);
      img_we = 0;
      input_addr = 0;
      write_img = 0;
    end // }}}
  endtask

  task read_image_direct;
    begin // {{{
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_0.bin",
        dut0.mem_img.mem,
        0,
        143
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_1.bin",
        dut0.mem_img.mem,
        144,
        287
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_2.bin",
        dut0.mem_img.mem,
        288,
        431
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_3.bin",
        dut0.mem_img.mem,
        432,
        575
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_4.bin",
        dut0.mem_img.mem,
        576,
        719
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_5.bin",
        dut0.mem_img.mem,
        720,
        863
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_6.bin",
        dut0.mem_img.mem,
        864,
        1007
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_7.bin",
        dut0.mem_img.mem,
        1008,
        1151
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_8.bin",
        dut0.mem_img.mem,
        1152,
        1295
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_9.bin",
        dut0.mem_img.mem,
        1296,
        1439
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_10.bin",
        dut0.mem_img.mem,
        1440,
        1583
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_11.bin",
        dut0.mem_img.mem,
        1584,
        1727
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_12.bin",
        dut0.mem_img.mem,
        1728,
        1871
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_13.bin",
        dut0.mem_img.mem,
        1872,
        2015
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_14.bin",
        dut0.mem_img.mem,
        2016,
        2159
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/bpmap1/2/data4_15.bin",
        dut0.mem_img.mem,
        2160,
        2303
      );
    end // }}}
  endtask

  task read_network;
    begin // {{{
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_0.bin",
        mem_n0,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_1.bin",
        mem_n0,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_2.bin",
        mem_n0,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_3.bin",
        mem_n0,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_4.bin",
        mem_n0,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_5.bin",
        mem_n0,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_6.bin",
        mem_n0,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_7.bin",
        mem_n0,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_8.bin",
        mem_n0,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_9.bin",
        mem_n0,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_10.bin",
        mem_n0,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_11.bin",
        mem_n0,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_12.bin",
        mem_n0,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_13.bin",
        mem_n0,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_14.bin",
        mem_n0,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_15.bin",
        mem_n0,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0.bin",
        mem_n0,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_0.bin",
        mem_n1,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_1.bin",
        mem_n1,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_2.bin",
        mem_n1,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_3.bin",
        mem_n1,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_4.bin",
        mem_n1,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_5.bin",
        mem_n1,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_6.bin",
        mem_n1,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_7.bin",
        mem_n1,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_8.bin",
        mem_n1,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_9.bin",
        mem_n1,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_10.bin",
        mem_n1,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_11.bin",
        mem_n1,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_12.bin",
        mem_n1,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_13.bin",
        mem_n1,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_14.bin",
        mem_n1,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_15.bin",
        mem_n1,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1.bin",
        mem_n1,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_0.bin",
        mem_n2,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_1.bin",
        mem_n2,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_2.bin",
        mem_n2,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_3.bin",
        mem_n2,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_4.bin",
        mem_n2,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_5.bin",
        mem_n2,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_6.bin",
        mem_n2,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_7.bin",
        mem_n2,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_8.bin",
        mem_n2,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_9.bin",
        mem_n2,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_10.bin",
        mem_n2,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_11.bin",
        mem_n2,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_12.bin",
        mem_n2,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_13.bin",
        mem_n2,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_14.bin",
        mem_n2,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_15.bin",
        mem_n2,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2.bin",
        mem_n2,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_0.bin",
        mem_n3,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_1.bin",
        mem_n3,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_2.bin",
        mem_n3,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_3.bin",
        mem_n3,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_4.bin",
        mem_n3,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_5.bin",
        mem_n3,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_6.bin",
        mem_n3,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_7.bin",
        mem_n3,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_8.bin",
        mem_n3,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_9.bin",
        mem_n3,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_10.bin",
        mem_n3,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_11.bin",
        mem_n3,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_12.bin",
        mem_n3,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_13.bin",
        mem_n3,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_14.bin",
        mem_n3,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_15.bin",
        mem_n3,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3.bin",
        mem_n3,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_0.bin",
        mem_n4,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_1.bin",
        mem_n4,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_2.bin",
        mem_n4,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_3.bin",
        mem_n4,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_4.bin",
        mem_n4,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_5.bin",
        mem_n4,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_6.bin",
        mem_n4,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_7.bin",
        mem_n4,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_8.bin",
        mem_n4,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_9.bin",
        mem_n4,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_10.bin",
        mem_n4,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_11.bin",
        mem_n4,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_12.bin",
        mem_n4,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_13.bin",
        mem_n4,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_14.bin",
        mem_n4,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_15.bin",
        mem_n4,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4.bin",
        mem_n4,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_0.bin",
        mem_n5,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_1.bin",
        mem_n5,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_2.bin",
        mem_n5,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_3.bin",
        mem_n5,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_4.bin",
        mem_n5,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_5.bin",
        mem_n5,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_6.bin",
        mem_n5,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_7.bin",
        mem_n5,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_8.bin",
        mem_n5,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_9.bin",
        mem_n5,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_10.bin",
        mem_n5,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_11.bin",
        mem_n5,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_12.bin",
        mem_n5,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_13.bin",
        mem_n5,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_14.bin",
        mem_n5,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_15.bin",
        mem_n5,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5.bin",
        mem_n5,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_0.bin",
        mem_n6,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_1.bin",
        mem_n6,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_2.bin",
        mem_n6,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_3.bin",
        mem_n6,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_4.bin",
        mem_n6,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_5.bin",
        mem_n6,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_6.bin",
        mem_n6,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_7.bin",
        mem_n6,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_8.bin",
        mem_n6,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_9.bin",
        mem_n6,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_10.bin",
        mem_n6,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_11.bin",
        mem_n6,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_12.bin",
        mem_n6,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_13.bin",
        mem_n6,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_14.bin",
        mem_n6,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_15.bin",
        mem_n6,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6.bin",
        mem_n6,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_0.bin",
        mem_n7,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_1.bin",
        mem_n7,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_2.bin",
        mem_n7,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_3.bin",
        mem_n7,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_4.bin",
        mem_n7,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_5.bin",
        mem_n7,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_6.bin",
        mem_n7,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_7.bin",
        mem_n7,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_8.bin",
        mem_n7,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_9.bin",
        mem_n7,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_10.bin",
        mem_n7,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_11.bin",
        mem_n7,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_12.bin",
        mem_n7,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_13.bin",
        mem_n7,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_14.bin",
        mem_n7,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_15.bin",
        mem_n7,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7.bin",
        mem_n7,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_0.bin",
        mem_n0,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_1.bin",
        mem_n0,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_2.bin",
        mem_n0,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_3.bin",
        mem_n0,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_4.bin",
        mem_n0,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_5.bin",
        mem_n0,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_6.bin",
        mem_n0,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_7.bin",
        mem_n0,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_8.bin",
        mem_n0,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_9.bin",
        mem_n0,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_10.bin",
        mem_n0,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_11.bin",
        mem_n0,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_12.bin",
        mem_n0,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_13.bin",
        mem_n0,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_14.bin",
        mem_n0,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_15.bin",
        mem_n0,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8.bin",
        mem_n0,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_0.bin",
        mem_n1,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_1.bin",
        mem_n1,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_2.bin",
        mem_n1,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_3.bin",
        mem_n1,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_4.bin",
        mem_n1,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_5.bin",
        mem_n1,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_6.bin",
        mem_n1,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_7.bin",
        mem_n1,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_8.bin",
        mem_n1,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_9.bin",
        mem_n1,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_10.bin",
        mem_n1,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_11.bin",
        mem_n1,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_12.bin",
        mem_n1,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_13.bin",
        mem_n1,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_14.bin",
        mem_n1,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_15.bin",
        mem_n1,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9.bin",
        mem_n1,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_0.bin",
        mem_n2,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_1.bin",
        mem_n2,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_2.bin",
        mem_n2,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_3.bin",
        mem_n2,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_4.bin",
        mem_n2,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_5.bin",
        mem_n2,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_6.bin",
        mem_n2,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_7.bin",
        mem_n2,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_8.bin",
        mem_n2,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_9.bin",
        mem_n2,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_10.bin",
        mem_n2,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_11.bin",
        mem_n2,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_12.bin",
        mem_n2,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_13.bin",
        mem_n2,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_14.bin",
        mem_n2,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_15.bin",
        mem_n2,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10.bin",
        mem_n2,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_0.bin",
        mem_n3,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_1.bin",
        mem_n3,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_2.bin",
        mem_n3,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_3.bin",
        mem_n3,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_4.bin",
        mem_n3,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_5.bin",
        mem_n3,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_6.bin",
        mem_n3,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_7.bin",
        mem_n3,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_8.bin",
        mem_n3,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_9.bin",
        mem_n3,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_10.bin",
        mem_n3,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_11.bin",
        mem_n3,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_12.bin",
        mem_n3,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_13.bin",
        mem_n3,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_14.bin",
        mem_n3,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_15.bin",
        mem_n3,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11.bin",
        mem_n3,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_0.bin",
        mem_n4,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_1.bin",
        mem_n4,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_2.bin",
        mem_n4,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_3.bin",
        mem_n4,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_4.bin",
        mem_n4,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_5.bin",
        mem_n4,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_6.bin",
        mem_n4,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_7.bin",
        mem_n4,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_8.bin",
        mem_n4,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_9.bin",
        mem_n4,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_10.bin",
        mem_n4,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_11.bin",
        mem_n4,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_12.bin",
        mem_n4,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_13.bin",
        mem_n4,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_14.bin",
        mem_n4,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_15.bin",
        mem_n4,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12.bin",
        mem_n4,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_0.bin",
        mem_n5,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_1.bin",
        mem_n5,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_2.bin",
        mem_n5,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_3.bin",
        mem_n5,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_4.bin",
        mem_n5,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_5.bin",
        mem_n5,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_6.bin",
        mem_n5,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_7.bin",
        mem_n5,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_8.bin",
        mem_n5,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_9.bin",
        mem_n5,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_10.bin",
        mem_n5,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_11.bin",
        mem_n5,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_12.bin",
        mem_n5,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_13.bin",
        mem_n5,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_14.bin",
        mem_n5,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_15.bin",
        mem_n5,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13.bin",
        mem_n5,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_0.bin",
        mem_n6,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_1.bin",
        mem_n6,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_2.bin",
        mem_n6,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_3.bin",
        mem_n6,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_4.bin",
        mem_n6,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_5.bin",
        mem_n6,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_6.bin",
        mem_n6,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_7.bin",
        mem_n6,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_8.bin",
        mem_n6,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_9.bin",
        mem_n6,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_10.bin",
        mem_n6,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_11.bin",
        mem_n6,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_12.bin",
        mem_n6,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_13.bin",
        mem_n6,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_14.bin",
        mem_n6,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_15.bin",
        mem_n6,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14.bin",
        mem_n6,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_0.bin",
        mem_n7,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_1.bin",
        mem_n7,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_2.bin",
        mem_n7,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_3.bin",
        mem_n7,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_4.bin",
        mem_n7,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_5.bin",
        mem_n7,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_6.bin",
        mem_n7,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_7.bin",
        mem_n7,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_8.bin",
        mem_n7,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_9.bin",
        mem_n7,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_10.bin",
        mem_n7,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_11.bin",
        mem_n7,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_12.bin",
        mem_n7,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_13.bin",
        mem_n7,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_14.bin",
        mem_n7,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_15.bin",
        mem_n7,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15.bin",
        mem_n7,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_0.bin",
        mem_n0,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_1.bin",
        mem_n0,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_2.bin",
        mem_n0,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_3.bin",
        mem_n0,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_4.bin",
        mem_n0,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_5.bin",
        mem_n0,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_6.bin",
        mem_n0,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_7.bin",
        mem_n0,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_8.bin",
        mem_n0,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_9.bin",
        mem_n0,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_10.bin",
        mem_n0,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_11.bin",
        mem_n0,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_12.bin",
        mem_n0,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_13.bin",
        mem_n0,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_14.bin",
        mem_n0,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_15.bin",
        mem_n0,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16.bin",
        mem_n0,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_0.bin",
        mem_n1,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_1.bin",
        mem_n1,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_2.bin",
        mem_n1,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_3.bin",
        mem_n1,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_4.bin",
        mem_n1,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_5.bin",
        mem_n1,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_6.bin",
        mem_n1,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_7.bin",
        mem_n1,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_8.bin",
        mem_n1,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_9.bin",
        mem_n1,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_10.bin",
        mem_n1,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_11.bin",
        mem_n1,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_12.bin",
        mem_n1,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_13.bin",
        mem_n1,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_14.bin",
        mem_n1,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_15.bin",
        mem_n1,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17.bin",
        mem_n1,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_0.bin",
        mem_n2,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_1.bin",
        mem_n2,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_2.bin",
        mem_n2,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_3.bin",
        mem_n2,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_4.bin",
        mem_n2,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_5.bin",
        mem_n2,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_6.bin",
        mem_n2,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_7.bin",
        mem_n2,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_8.bin",
        mem_n2,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_9.bin",
        mem_n2,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_10.bin",
        mem_n2,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_11.bin",
        mem_n2,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_12.bin",
        mem_n2,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_13.bin",
        mem_n2,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_14.bin",
        mem_n2,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_15.bin",
        mem_n2,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18.bin",
        mem_n2,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_0.bin",
        mem_n3,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_1.bin",
        mem_n3,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_2.bin",
        mem_n3,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_3.bin",
        mem_n3,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_4.bin",
        mem_n3,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_5.bin",
        mem_n3,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_6.bin",
        mem_n3,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_7.bin",
        mem_n3,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_8.bin",
        mem_n3,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_9.bin",
        mem_n3,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_10.bin",
        mem_n3,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_11.bin",
        mem_n3,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_12.bin",
        mem_n3,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_13.bin",
        mem_n3,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_14.bin",
        mem_n3,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_15.bin",
        mem_n3,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19.bin",
        mem_n3,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_0.bin",
        mem_n4,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_1.bin",
        mem_n4,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_2.bin",
        mem_n4,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_3.bin",
        mem_n4,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_4.bin",
        mem_n4,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_5.bin",
        mem_n4,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_6.bin",
        mem_n4,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_7.bin",
        mem_n4,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_8.bin",
        mem_n4,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_9.bin",
        mem_n4,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_10.bin",
        mem_n4,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_11.bin",
        mem_n4,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_12.bin",
        mem_n4,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_13.bin",
        mem_n4,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_14.bin",
        mem_n4,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_15.bin",
        mem_n4,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20.bin",
        mem_n4,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_0.bin",
        mem_n5,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_1.bin",
        mem_n5,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_2.bin",
        mem_n5,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_3.bin",
        mem_n5,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_4.bin",
        mem_n5,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_5.bin",
        mem_n5,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_6.bin",
        mem_n5,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_7.bin",
        mem_n5,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_8.bin",
        mem_n5,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_9.bin",
        mem_n5,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_10.bin",
        mem_n5,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_11.bin",
        mem_n5,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_12.bin",
        mem_n5,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_13.bin",
        mem_n5,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_14.bin",
        mem_n5,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_15.bin",
        mem_n5,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21.bin",
        mem_n5,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_0.bin",
        mem_n6,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_1.bin",
        mem_n6,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_2.bin",
        mem_n6,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_3.bin",
        mem_n6,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_4.bin",
        mem_n6,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_5.bin",
        mem_n6,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_6.bin",
        mem_n6,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_7.bin",
        mem_n6,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_8.bin",
        mem_n6,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_9.bin",
        mem_n6,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_10.bin",
        mem_n6,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_11.bin",
        mem_n6,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_12.bin",
        mem_n6,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_13.bin",
        mem_n6,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_14.bin",
        mem_n6,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_15.bin",
        mem_n6,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22.bin",
        mem_n6,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_0.bin",
        mem_n7,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_1.bin",
        mem_n7,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_2.bin",
        mem_n7,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_3.bin",
        mem_n7,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_4.bin",
        mem_n7,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_5.bin",
        mem_n7,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_6.bin",
        mem_n7,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_7.bin",
        mem_n7,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_8.bin",
        mem_n7,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_9.bin",
        mem_n7,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_10.bin",
        mem_n7,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_11.bin",
        mem_n7,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_12.bin",
        mem_n7,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_13.bin",
        mem_n7,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_14.bin",
        mem_n7,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_15.bin",
        mem_n7,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23.bin",
        mem_n7,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_0.bin",
        mem_n0,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_1.bin",
        mem_n0,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_2.bin",
        mem_n0,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_3.bin",
        mem_n0,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_4.bin",
        mem_n0,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_5.bin",
        mem_n0,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_6.bin",
        mem_n0,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_7.bin",
        mem_n0,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_8.bin",
        mem_n0,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_9.bin",
        mem_n0,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_10.bin",
        mem_n0,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_11.bin",
        mem_n0,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_12.bin",
        mem_n0,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_13.bin",
        mem_n0,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_14.bin",
        mem_n0,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_15.bin",
        mem_n0,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24.bin",
        mem_n0,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_0.bin",
        mem_n1,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_1.bin",
        mem_n1,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_2.bin",
        mem_n1,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_3.bin",
        mem_n1,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_4.bin",
        mem_n1,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_5.bin",
        mem_n1,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_6.bin",
        mem_n1,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_7.bin",
        mem_n1,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_8.bin",
        mem_n1,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_9.bin",
        mem_n1,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_10.bin",
        mem_n1,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_11.bin",
        mem_n1,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_12.bin",
        mem_n1,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_13.bin",
        mem_n1,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_14.bin",
        mem_n1,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_15.bin",
        mem_n1,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25.bin",
        mem_n1,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_0.bin",
        mem_n2,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_1.bin",
        mem_n2,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_2.bin",
        mem_n2,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_3.bin",
        mem_n2,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_4.bin",
        mem_n2,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_5.bin",
        mem_n2,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_6.bin",
        mem_n2,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_7.bin",
        mem_n2,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_8.bin",
        mem_n2,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_9.bin",
        mem_n2,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_10.bin",
        mem_n2,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_11.bin",
        mem_n2,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_12.bin",
        mem_n2,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_13.bin",
        mem_n2,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_14.bin",
        mem_n2,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_15.bin",
        mem_n2,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26.bin",
        mem_n2,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_0.bin",
        mem_n3,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_1.bin",
        mem_n3,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_2.bin",
        mem_n3,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_3.bin",
        mem_n3,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_4.bin",
        mem_n3,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_5.bin",
        mem_n3,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_6.bin",
        mem_n3,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_7.bin",
        mem_n3,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_8.bin",
        mem_n3,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_9.bin",
        mem_n3,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_10.bin",
        mem_n3,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_11.bin",
        mem_n3,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_12.bin",
        mem_n3,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_13.bin",
        mem_n3,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_14.bin",
        mem_n3,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_15.bin",
        mem_n3,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27.bin",
        mem_n3,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_0.bin",
        mem_n4,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_1.bin",
        mem_n4,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_2.bin",
        mem_n4,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_3.bin",
        mem_n4,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_4.bin",
        mem_n4,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_5.bin",
        mem_n4,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_6.bin",
        mem_n4,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_7.bin",
        mem_n4,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_8.bin",
        mem_n4,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_9.bin",
        mem_n4,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_10.bin",
        mem_n4,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_11.bin",
        mem_n4,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_12.bin",
        mem_n4,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_13.bin",
        mem_n4,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_14.bin",
        mem_n4,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_15.bin",
        mem_n4,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28.bin",
        mem_n4,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_0.bin",
        mem_n5,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_1.bin",
        mem_n5,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_2.bin",
        mem_n5,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_3.bin",
        mem_n5,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_4.bin",
        mem_n5,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_5.bin",
        mem_n5,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_6.bin",
        mem_n5,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_7.bin",
        mem_n5,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_8.bin",
        mem_n5,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_9.bin",
        mem_n5,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_10.bin",
        mem_n5,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_11.bin",
        mem_n5,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_12.bin",
        mem_n5,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_13.bin",
        mem_n5,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_14.bin",
        mem_n5,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_15.bin",
        mem_n5,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29.bin",
        mem_n5,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_0.bin",
        mem_n6,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_1.bin",
        mem_n6,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_2.bin",
        mem_n6,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_3.bin",
        mem_n6,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_4.bin",
        mem_n6,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_5.bin",
        mem_n6,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_6.bin",
        mem_n6,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_7.bin",
        mem_n6,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_8.bin",
        mem_n6,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_9.bin",
        mem_n6,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_10.bin",
        mem_n6,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_11.bin",
        mem_n6,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_12.bin",
        mem_n6,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_13.bin",
        mem_n6,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_14.bin",
        mem_n6,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_15.bin",
        mem_n6,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30.bin",
        mem_n6,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_0.bin",
        mem_n7,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_1.bin",
        mem_n7,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_2.bin",
        mem_n7,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_3.bin",
        mem_n7,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_4.bin",
        mem_n7,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_5.bin",
        mem_n7,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_6.bin",
        mem_n7,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_7.bin",
        mem_n7,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_8.bin",
        mem_n7,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_9.bin",
        mem_n7,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_10.bin",
        mem_n7,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_11.bin",
        mem_n7,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_12.bin",
        mem_n7,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_13.bin",
        mem_n7,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_14.bin",
        mem_n7,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_15.bin",
        mem_n7,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31.bin",
        mem_n7,
        1603 + 0,
        1603 + 0
      );

      net_we = 4'd1;
      #(STEP);
      for (i=0; i<2**NETSIZE; i=i+1)
      begin
        net_addr = i;
        #(STEP);
        write_net = mem_n0[i];
        #(STEP);
      end
      net_we = 4'd0;
      net_addr = 0;
      write_net = 0;
      net_we = 4'd2;
      #(STEP);
      for (i=0; i<2**NETSIZE; i=i+1)
      begin
        net_addr = i;
        #(STEP);
        write_net = mem_n1[i];
        #(STEP);
      end
      net_we = 4'd0;
      net_addr = 0;
      write_net = 0;
      net_we = 4'd3;
      #(STEP);
      for (i=0; i<2**NETSIZE; i=i+1)
      begin
        net_addr = i;
        #(STEP);
        write_net = mem_n2[i];
        #(STEP);
      end
      net_we = 4'd0;
      net_addr = 0;
      write_net = 0;
      net_we = 4'd4;
      #(STEP);
      for (i=0; i<2**NETSIZE; i=i+1)
      begin
        net_addr = i;
        #(STEP);
        write_net = mem_n3[i];
        #(STEP);
      end
      net_we = 4'd0;
      net_addr = 0;
      write_net = 0;
      net_we = 4'd5;
      #(STEP);
      for (i=0; i<2**NETSIZE; i=i+1)
      begin
        net_addr = i;
        #(STEP);
        write_net = mem_n4[i];
        #(STEP);
      end
      net_we = 4'd0;
      net_addr = 0;
      write_net = 0;
      net_we = 4'd6;
      #(STEP);
      for (i=0; i<2**NETSIZE; i=i+1)
      begin
        net_addr = i;
        #(STEP);
        write_net = mem_n5[i];
        #(STEP);
      end
      net_we = 4'd0;
      net_addr = 0;
      write_net = 0;
      net_we = 4'd7;
      #(STEP);
      for (i=0; i<2**NETSIZE; i=i+1)
      begin
        net_addr = i;
        #(STEP);
        write_net = mem_n6[i];
        #(STEP);
      end
      net_we = 4'd0;
      net_addr = 0;
      write_net = 0;
      net_we = 4'd8;
      #(STEP);
      for (i=0; i<2**NETSIZE; i=i+1)
      begin
        net_addr = i;
        #(STEP);
        write_net = mem_n7[i];
        #(STEP);
      end
      net_we = 4'd0;
      net_addr = 0;
      write_net = 0;
    end // }}}
  endtask

  task read_network_direct;
    begin // {{{
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_0.bin",
        dut0.mem_net0.mem,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_1.bin",
        dut0.mem_net0.mem,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_2.bin",
        dut0.mem_net0.mem,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_3.bin",
        dut0.mem_net0.mem,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_4.bin",
        dut0.mem_net0.mem,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_5.bin",
        dut0.mem_net0.mem,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_6.bin",
        dut0.mem_net0.mem,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_7.bin",
        dut0.mem_net0.mem,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_8.bin",
        dut0.mem_net0.mem,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_9.bin",
        dut0.mem_net0.mem,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_10.bin",
        dut0.mem_net0.mem,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_11.bin",
        dut0.mem_net0.mem,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_12.bin",
        dut0.mem_net0.mem,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_13.bin",
        dut0.mem_net0.mem,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_14.bin",
        dut0.mem_net0.mem,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0_15.bin",
        dut0.mem_net0.mem,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data0.bin",
        dut0.mem_net0.mem,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_0.bin",
        dut0.mem_net1.mem,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_1.bin",
        dut0.mem_net1.mem,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_2.bin",
        dut0.mem_net1.mem,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_3.bin",
        dut0.mem_net1.mem,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_4.bin",
        dut0.mem_net1.mem,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_5.bin",
        dut0.mem_net1.mem,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_6.bin",
        dut0.mem_net1.mem,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_7.bin",
        dut0.mem_net1.mem,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_8.bin",
        dut0.mem_net1.mem,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_9.bin",
        dut0.mem_net1.mem,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_10.bin",
        dut0.mem_net1.mem,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_11.bin",
        dut0.mem_net1.mem,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_12.bin",
        dut0.mem_net1.mem,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_13.bin",
        dut0.mem_net1.mem,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_14.bin",
        dut0.mem_net1.mem,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1_15.bin",
        dut0.mem_net1.mem,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data1.bin",
        dut0.mem_net1.mem,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_0.bin",
        dut0.mem_net2.mem,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_1.bin",
        dut0.mem_net2.mem,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_2.bin",
        dut0.mem_net2.mem,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_3.bin",
        dut0.mem_net2.mem,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_4.bin",
        dut0.mem_net2.mem,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_5.bin",
        dut0.mem_net2.mem,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_6.bin",
        dut0.mem_net2.mem,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_7.bin",
        dut0.mem_net2.mem,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_8.bin",
        dut0.mem_net2.mem,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_9.bin",
        dut0.mem_net2.mem,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_10.bin",
        dut0.mem_net2.mem,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_11.bin",
        dut0.mem_net2.mem,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_12.bin",
        dut0.mem_net2.mem,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_13.bin",
        dut0.mem_net2.mem,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_14.bin",
        dut0.mem_net2.mem,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2_15.bin",
        dut0.mem_net2.mem,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data2.bin",
        dut0.mem_net2.mem,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_0.bin",
        dut0.mem_net3.mem,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_1.bin",
        dut0.mem_net3.mem,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_2.bin",
        dut0.mem_net3.mem,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_3.bin",
        dut0.mem_net3.mem,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_4.bin",
        dut0.mem_net3.mem,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_5.bin",
        dut0.mem_net3.mem,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_6.bin",
        dut0.mem_net3.mem,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_7.bin",
        dut0.mem_net3.mem,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_8.bin",
        dut0.mem_net3.mem,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_9.bin",
        dut0.mem_net3.mem,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_10.bin",
        dut0.mem_net3.mem,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_11.bin",
        dut0.mem_net3.mem,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_12.bin",
        dut0.mem_net3.mem,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_13.bin",
        dut0.mem_net3.mem,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_14.bin",
        dut0.mem_net3.mem,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3_15.bin",
        dut0.mem_net3.mem,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data3.bin",
        dut0.mem_net3.mem,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_0.bin",
        dut0.mem_net4.mem,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_1.bin",
        dut0.mem_net4.mem,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_2.bin",
        dut0.mem_net4.mem,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_3.bin",
        dut0.mem_net4.mem,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_4.bin",
        dut0.mem_net4.mem,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_5.bin",
        dut0.mem_net4.mem,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_6.bin",
        dut0.mem_net4.mem,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_7.bin",
        dut0.mem_net4.mem,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_8.bin",
        dut0.mem_net4.mem,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_9.bin",
        dut0.mem_net4.mem,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_10.bin",
        dut0.mem_net4.mem,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_11.bin",
        dut0.mem_net4.mem,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_12.bin",
        dut0.mem_net4.mem,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_13.bin",
        dut0.mem_net4.mem,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_14.bin",
        dut0.mem_net4.mem,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4_15.bin",
        dut0.mem_net4.mem,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data4.bin",
        dut0.mem_net4.mem,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_0.bin",
        dut0.mem_net5.mem,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_1.bin",
        dut0.mem_net5.mem,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_2.bin",
        dut0.mem_net5.mem,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_3.bin",
        dut0.mem_net5.mem,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_4.bin",
        dut0.mem_net5.mem,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_5.bin",
        dut0.mem_net5.mem,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_6.bin",
        dut0.mem_net5.mem,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_7.bin",
        dut0.mem_net5.mem,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_8.bin",
        dut0.mem_net5.mem,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_9.bin",
        dut0.mem_net5.mem,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_10.bin",
        dut0.mem_net5.mem,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_11.bin",
        dut0.mem_net5.mem,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_12.bin",
        dut0.mem_net5.mem,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_13.bin",
        dut0.mem_net5.mem,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_14.bin",
        dut0.mem_net5.mem,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5_15.bin",
        dut0.mem_net5.mem,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data5.bin",
        dut0.mem_net5.mem,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_0.bin",
        dut0.mem_net6.mem,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_1.bin",
        dut0.mem_net6.mem,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_2.bin",
        dut0.mem_net6.mem,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_3.bin",
        dut0.mem_net6.mem,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_4.bin",
        dut0.mem_net6.mem,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_5.bin",
        dut0.mem_net6.mem,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_6.bin",
        dut0.mem_net6.mem,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_7.bin",
        dut0.mem_net6.mem,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_8.bin",
        dut0.mem_net6.mem,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_9.bin",
        dut0.mem_net6.mem,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_10.bin",
        dut0.mem_net6.mem,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_11.bin",
        dut0.mem_net6.mem,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_12.bin",
        dut0.mem_net6.mem,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_13.bin",
        dut0.mem_net6.mem,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_14.bin",
        dut0.mem_net6.mem,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6_15.bin",
        dut0.mem_net6.mem,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data6.bin",
        dut0.mem_net6.mem,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_0.bin",
        dut0.mem_net7.mem,
        0 + 0,
        24 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_1.bin",
        dut0.mem_net7.mem,
        25 + 0,
        49 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_2.bin",
        dut0.mem_net7.mem,
        50 + 0,
        74 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_3.bin",
        dut0.mem_net7.mem,
        75 + 0,
        99 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_4.bin",
        dut0.mem_net7.mem,
        100 + 0,
        124 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_5.bin",
        dut0.mem_net7.mem,
        125 + 0,
        149 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_6.bin",
        dut0.mem_net7.mem,
        150 + 0,
        174 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_7.bin",
        dut0.mem_net7.mem,
        175 + 0,
        199 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_8.bin",
        dut0.mem_net7.mem,
        200 + 0,
        224 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_9.bin",
        dut0.mem_net7.mem,
        225 + 0,
        249 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_10.bin",
        dut0.mem_net7.mem,
        250 + 0,
        274 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_11.bin",
        dut0.mem_net7.mem,
        275 + 0,
        299 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_12.bin",
        dut0.mem_net7.mem,
        300 + 0,
        324 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_13.bin",
        dut0.mem_net7.mem,
        325 + 0,
        349 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_14.bin",
        dut0.mem_net7.mem,
        350 + 0,
        374 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7_15.bin",
        dut0.mem_net7.mem,
        375 + 0,
        399 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data7.bin",
        dut0.mem_net7.mem,
        400 + 0,
        400 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_0.bin",
        dut0.mem_net0.mem,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_1.bin",
        dut0.mem_net0.mem,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_2.bin",
        dut0.mem_net0.mem,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_3.bin",
        dut0.mem_net0.mem,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_4.bin",
        dut0.mem_net0.mem,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_5.bin",
        dut0.mem_net0.mem,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_6.bin",
        dut0.mem_net0.mem,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_7.bin",
        dut0.mem_net0.mem,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_8.bin",
        dut0.mem_net0.mem,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_9.bin",
        dut0.mem_net0.mem,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_10.bin",
        dut0.mem_net0.mem,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_11.bin",
        dut0.mem_net0.mem,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_12.bin",
        dut0.mem_net0.mem,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_13.bin",
        dut0.mem_net0.mem,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_14.bin",
        dut0.mem_net0.mem,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8_15.bin",
        dut0.mem_net0.mem,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data8.bin",
        dut0.mem_net0.mem,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_0.bin",
        dut0.mem_net1.mem,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_1.bin",
        dut0.mem_net1.mem,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_2.bin",
        dut0.mem_net1.mem,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_3.bin",
        dut0.mem_net1.mem,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_4.bin",
        dut0.mem_net1.mem,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_5.bin",
        dut0.mem_net1.mem,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_6.bin",
        dut0.mem_net1.mem,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_7.bin",
        dut0.mem_net1.mem,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_8.bin",
        dut0.mem_net1.mem,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_9.bin",
        dut0.mem_net1.mem,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_10.bin",
        dut0.mem_net1.mem,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_11.bin",
        dut0.mem_net1.mem,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_12.bin",
        dut0.mem_net1.mem,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_13.bin",
        dut0.mem_net1.mem,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_14.bin",
        dut0.mem_net1.mem,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9_15.bin",
        dut0.mem_net1.mem,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data9.bin",
        dut0.mem_net1.mem,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_0.bin",
        dut0.mem_net2.mem,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_1.bin",
        dut0.mem_net2.mem,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_2.bin",
        dut0.mem_net2.mem,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_3.bin",
        dut0.mem_net2.mem,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_4.bin",
        dut0.mem_net2.mem,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_5.bin",
        dut0.mem_net2.mem,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_6.bin",
        dut0.mem_net2.mem,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_7.bin",
        dut0.mem_net2.mem,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_8.bin",
        dut0.mem_net2.mem,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_9.bin",
        dut0.mem_net2.mem,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_10.bin",
        dut0.mem_net2.mem,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_11.bin",
        dut0.mem_net2.mem,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_12.bin",
        dut0.mem_net2.mem,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_13.bin",
        dut0.mem_net2.mem,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_14.bin",
        dut0.mem_net2.mem,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10_15.bin",
        dut0.mem_net2.mem,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data10.bin",
        dut0.mem_net2.mem,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_0.bin",
        dut0.mem_net3.mem,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_1.bin",
        dut0.mem_net3.mem,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_2.bin",
        dut0.mem_net3.mem,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_3.bin",
        dut0.mem_net3.mem,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_4.bin",
        dut0.mem_net3.mem,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_5.bin",
        dut0.mem_net3.mem,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_6.bin",
        dut0.mem_net3.mem,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_7.bin",
        dut0.mem_net3.mem,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_8.bin",
        dut0.mem_net3.mem,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_9.bin",
        dut0.mem_net3.mem,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_10.bin",
        dut0.mem_net3.mem,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_11.bin",
        dut0.mem_net3.mem,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_12.bin",
        dut0.mem_net3.mem,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_13.bin",
        dut0.mem_net3.mem,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_14.bin",
        dut0.mem_net3.mem,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11_15.bin",
        dut0.mem_net3.mem,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data11.bin",
        dut0.mem_net3.mem,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_0.bin",
        dut0.mem_net4.mem,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_1.bin",
        dut0.mem_net4.mem,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_2.bin",
        dut0.mem_net4.mem,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_3.bin",
        dut0.mem_net4.mem,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_4.bin",
        dut0.mem_net4.mem,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_5.bin",
        dut0.mem_net4.mem,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_6.bin",
        dut0.mem_net4.mem,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_7.bin",
        dut0.mem_net4.mem,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_8.bin",
        dut0.mem_net4.mem,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_9.bin",
        dut0.mem_net4.mem,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_10.bin",
        dut0.mem_net4.mem,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_11.bin",
        dut0.mem_net4.mem,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_12.bin",
        dut0.mem_net4.mem,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_13.bin",
        dut0.mem_net4.mem,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_14.bin",
        dut0.mem_net4.mem,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12_15.bin",
        dut0.mem_net4.mem,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data12.bin",
        dut0.mem_net4.mem,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_0.bin",
        dut0.mem_net5.mem,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_1.bin",
        dut0.mem_net5.mem,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_2.bin",
        dut0.mem_net5.mem,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_3.bin",
        dut0.mem_net5.mem,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_4.bin",
        dut0.mem_net5.mem,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_5.bin",
        dut0.mem_net5.mem,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_6.bin",
        dut0.mem_net5.mem,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_7.bin",
        dut0.mem_net5.mem,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_8.bin",
        dut0.mem_net5.mem,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_9.bin",
        dut0.mem_net5.mem,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_10.bin",
        dut0.mem_net5.mem,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_11.bin",
        dut0.mem_net5.mem,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_12.bin",
        dut0.mem_net5.mem,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_13.bin",
        dut0.mem_net5.mem,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_14.bin",
        dut0.mem_net5.mem,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13_15.bin",
        dut0.mem_net5.mem,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data13.bin",
        dut0.mem_net5.mem,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_0.bin",
        dut0.mem_net6.mem,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_1.bin",
        dut0.mem_net6.mem,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_2.bin",
        dut0.mem_net6.mem,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_3.bin",
        dut0.mem_net6.mem,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_4.bin",
        dut0.mem_net6.mem,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_5.bin",
        dut0.mem_net6.mem,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_6.bin",
        dut0.mem_net6.mem,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_7.bin",
        dut0.mem_net6.mem,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_8.bin",
        dut0.mem_net6.mem,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_9.bin",
        dut0.mem_net6.mem,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_10.bin",
        dut0.mem_net6.mem,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_11.bin",
        dut0.mem_net6.mem,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_12.bin",
        dut0.mem_net6.mem,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_13.bin",
        dut0.mem_net6.mem,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_14.bin",
        dut0.mem_net6.mem,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14_15.bin",
        dut0.mem_net6.mem,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data14.bin",
        dut0.mem_net6.mem,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_0.bin",
        dut0.mem_net7.mem,
        401 + 0,
        425 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_1.bin",
        dut0.mem_net7.mem,
        426 + 0,
        450 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_2.bin",
        dut0.mem_net7.mem,
        451 + 0,
        475 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_3.bin",
        dut0.mem_net7.mem,
        476 + 0,
        500 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_4.bin",
        dut0.mem_net7.mem,
        501 + 0,
        525 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_5.bin",
        dut0.mem_net7.mem,
        526 + 0,
        550 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_6.bin",
        dut0.mem_net7.mem,
        551 + 0,
        575 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_7.bin",
        dut0.mem_net7.mem,
        576 + 0,
        600 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_8.bin",
        dut0.mem_net7.mem,
        601 + 0,
        625 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_9.bin",
        dut0.mem_net7.mem,
        626 + 0,
        650 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_10.bin",
        dut0.mem_net7.mem,
        651 + 0,
        675 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_11.bin",
        dut0.mem_net7.mem,
        676 + 0,
        700 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_12.bin",
        dut0.mem_net7.mem,
        701 + 0,
        725 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_13.bin",
        dut0.mem_net7.mem,
        726 + 0,
        750 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_14.bin",
        dut0.mem_net7.mem,
        751 + 0,
        775 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15_15.bin",
        dut0.mem_net7.mem,
        776 + 0,
        800 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data15.bin",
        dut0.mem_net7.mem,
        801 + 0,
        801 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_0.bin",
        dut0.mem_net0.mem,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_1.bin",
        dut0.mem_net0.mem,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_2.bin",
        dut0.mem_net0.mem,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_3.bin",
        dut0.mem_net0.mem,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_4.bin",
        dut0.mem_net0.mem,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_5.bin",
        dut0.mem_net0.mem,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_6.bin",
        dut0.mem_net0.mem,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_7.bin",
        dut0.mem_net0.mem,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_8.bin",
        dut0.mem_net0.mem,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_9.bin",
        dut0.mem_net0.mem,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_10.bin",
        dut0.mem_net0.mem,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_11.bin",
        dut0.mem_net0.mem,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_12.bin",
        dut0.mem_net0.mem,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_13.bin",
        dut0.mem_net0.mem,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_14.bin",
        dut0.mem_net0.mem,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16_15.bin",
        dut0.mem_net0.mem,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data16.bin",
        dut0.mem_net0.mem,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_0.bin",
        dut0.mem_net1.mem,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_1.bin",
        dut0.mem_net1.mem,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_2.bin",
        dut0.mem_net1.mem,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_3.bin",
        dut0.mem_net1.mem,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_4.bin",
        dut0.mem_net1.mem,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_5.bin",
        dut0.mem_net1.mem,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_6.bin",
        dut0.mem_net1.mem,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_7.bin",
        dut0.mem_net1.mem,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_8.bin",
        dut0.mem_net1.mem,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_9.bin",
        dut0.mem_net1.mem,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_10.bin",
        dut0.mem_net1.mem,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_11.bin",
        dut0.mem_net1.mem,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_12.bin",
        dut0.mem_net1.mem,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_13.bin",
        dut0.mem_net1.mem,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_14.bin",
        dut0.mem_net1.mem,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17_15.bin",
        dut0.mem_net1.mem,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data17.bin",
        dut0.mem_net1.mem,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_0.bin",
        dut0.mem_net2.mem,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_1.bin",
        dut0.mem_net2.mem,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_2.bin",
        dut0.mem_net2.mem,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_3.bin",
        dut0.mem_net2.mem,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_4.bin",
        dut0.mem_net2.mem,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_5.bin",
        dut0.mem_net2.mem,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_6.bin",
        dut0.mem_net2.mem,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_7.bin",
        dut0.mem_net2.mem,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_8.bin",
        dut0.mem_net2.mem,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_9.bin",
        dut0.mem_net2.mem,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_10.bin",
        dut0.mem_net2.mem,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_11.bin",
        dut0.mem_net2.mem,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_12.bin",
        dut0.mem_net2.mem,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_13.bin",
        dut0.mem_net2.mem,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_14.bin",
        dut0.mem_net2.mem,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18_15.bin",
        dut0.mem_net2.mem,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data18.bin",
        dut0.mem_net2.mem,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_0.bin",
        dut0.mem_net3.mem,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_1.bin",
        dut0.mem_net3.mem,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_2.bin",
        dut0.mem_net3.mem,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_3.bin",
        dut0.mem_net3.mem,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_4.bin",
        dut0.mem_net3.mem,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_5.bin",
        dut0.mem_net3.mem,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_6.bin",
        dut0.mem_net3.mem,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_7.bin",
        dut0.mem_net3.mem,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_8.bin",
        dut0.mem_net3.mem,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_9.bin",
        dut0.mem_net3.mem,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_10.bin",
        dut0.mem_net3.mem,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_11.bin",
        dut0.mem_net3.mem,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_12.bin",
        dut0.mem_net3.mem,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_13.bin",
        dut0.mem_net3.mem,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_14.bin",
        dut0.mem_net3.mem,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19_15.bin",
        dut0.mem_net3.mem,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data19.bin",
        dut0.mem_net3.mem,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_0.bin",
        dut0.mem_net4.mem,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_1.bin",
        dut0.mem_net4.mem,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_2.bin",
        dut0.mem_net4.mem,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_3.bin",
        dut0.mem_net4.mem,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_4.bin",
        dut0.mem_net4.mem,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_5.bin",
        dut0.mem_net4.mem,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_6.bin",
        dut0.mem_net4.mem,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_7.bin",
        dut0.mem_net4.mem,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_8.bin",
        dut0.mem_net4.mem,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_9.bin",
        dut0.mem_net4.mem,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_10.bin",
        dut0.mem_net4.mem,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_11.bin",
        dut0.mem_net4.mem,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_12.bin",
        dut0.mem_net4.mem,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_13.bin",
        dut0.mem_net4.mem,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_14.bin",
        dut0.mem_net4.mem,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20_15.bin",
        dut0.mem_net4.mem,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data20.bin",
        dut0.mem_net4.mem,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_0.bin",
        dut0.mem_net5.mem,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_1.bin",
        dut0.mem_net5.mem,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_2.bin",
        dut0.mem_net5.mem,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_3.bin",
        dut0.mem_net5.mem,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_4.bin",
        dut0.mem_net5.mem,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_5.bin",
        dut0.mem_net5.mem,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_6.bin",
        dut0.mem_net5.mem,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_7.bin",
        dut0.mem_net5.mem,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_8.bin",
        dut0.mem_net5.mem,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_9.bin",
        dut0.mem_net5.mem,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_10.bin",
        dut0.mem_net5.mem,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_11.bin",
        dut0.mem_net5.mem,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_12.bin",
        dut0.mem_net5.mem,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_13.bin",
        dut0.mem_net5.mem,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_14.bin",
        dut0.mem_net5.mem,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21_15.bin",
        dut0.mem_net5.mem,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data21.bin",
        dut0.mem_net5.mem,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_0.bin",
        dut0.mem_net6.mem,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_1.bin",
        dut0.mem_net6.mem,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_2.bin",
        dut0.mem_net6.mem,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_3.bin",
        dut0.mem_net6.mem,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_4.bin",
        dut0.mem_net6.mem,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_5.bin",
        dut0.mem_net6.mem,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_6.bin",
        dut0.mem_net6.mem,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_7.bin",
        dut0.mem_net6.mem,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_8.bin",
        dut0.mem_net6.mem,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_9.bin",
        dut0.mem_net6.mem,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_10.bin",
        dut0.mem_net6.mem,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_11.bin",
        dut0.mem_net6.mem,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_12.bin",
        dut0.mem_net6.mem,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_13.bin",
        dut0.mem_net6.mem,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_14.bin",
        dut0.mem_net6.mem,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22_15.bin",
        dut0.mem_net6.mem,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data22.bin",
        dut0.mem_net6.mem,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_0.bin",
        dut0.mem_net7.mem,
        802 + 0,
        826 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_1.bin",
        dut0.mem_net7.mem,
        827 + 0,
        851 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_2.bin",
        dut0.mem_net7.mem,
        852 + 0,
        876 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_3.bin",
        dut0.mem_net7.mem,
        877 + 0,
        901 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_4.bin",
        dut0.mem_net7.mem,
        902 + 0,
        926 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_5.bin",
        dut0.mem_net7.mem,
        927 + 0,
        951 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_6.bin",
        dut0.mem_net7.mem,
        952 + 0,
        976 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_7.bin",
        dut0.mem_net7.mem,
        977 + 0,
        1001 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_8.bin",
        dut0.mem_net7.mem,
        1002 + 0,
        1026 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_9.bin",
        dut0.mem_net7.mem,
        1027 + 0,
        1051 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_10.bin",
        dut0.mem_net7.mem,
        1052 + 0,
        1076 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_11.bin",
        dut0.mem_net7.mem,
        1077 + 0,
        1101 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_12.bin",
        dut0.mem_net7.mem,
        1102 + 0,
        1126 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_13.bin",
        dut0.mem_net7.mem,
        1127 + 0,
        1151 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_14.bin",
        dut0.mem_net7.mem,
        1152 + 0,
        1176 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23_15.bin",
        dut0.mem_net7.mem,
        1177 + 0,
        1201 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data23.bin",
        dut0.mem_net7.mem,
        1202 + 0,
        1202 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_0.bin",
        dut0.mem_net0.mem,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_1.bin",
        dut0.mem_net0.mem,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_2.bin",
        dut0.mem_net0.mem,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_3.bin",
        dut0.mem_net0.mem,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_4.bin",
        dut0.mem_net0.mem,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_5.bin",
        dut0.mem_net0.mem,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_6.bin",
        dut0.mem_net0.mem,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_7.bin",
        dut0.mem_net0.mem,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_8.bin",
        dut0.mem_net0.mem,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_9.bin",
        dut0.mem_net0.mem,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_10.bin",
        dut0.mem_net0.mem,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_11.bin",
        dut0.mem_net0.mem,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_12.bin",
        dut0.mem_net0.mem,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_13.bin",
        dut0.mem_net0.mem,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_14.bin",
        dut0.mem_net0.mem,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24_15.bin",
        dut0.mem_net0.mem,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data24.bin",
        dut0.mem_net0.mem,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_0.bin",
        dut0.mem_net1.mem,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_1.bin",
        dut0.mem_net1.mem,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_2.bin",
        dut0.mem_net1.mem,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_3.bin",
        dut0.mem_net1.mem,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_4.bin",
        dut0.mem_net1.mem,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_5.bin",
        dut0.mem_net1.mem,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_6.bin",
        dut0.mem_net1.mem,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_7.bin",
        dut0.mem_net1.mem,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_8.bin",
        dut0.mem_net1.mem,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_9.bin",
        dut0.mem_net1.mem,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_10.bin",
        dut0.mem_net1.mem,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_11.bin",
        dut0.mem_net1.mem,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_12.bin",
        dut0.mem_net1.mem,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_13.bin",
        dut0.mem_net1.mem,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_14.bin",
        dut0.mem_net1.mem,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25_15.bin",
        dut0.mem_net1.mem,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data25.bin",
        dut0.mem_net1.mem,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_0.bin",
        dut0.mem_net2.mem,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_1.bin",
        dut0.mem_net2.mem,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_2.bin",
        dut0.mem_net2.mem,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_3.bin",
        dut0.mem_net2.mem,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_4.bin",
        dut0.mem_net2.mem,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_5.bin",
        dut0.mem_net2.mem,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_6.bin",
        dut0.mem_net2.mem,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_7.bin",
        dut0.mem_net2.mem,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_8.bin",
        dut0.mem_net2.mem,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_9.bin",
        dut0.mem_net2.mem,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_10.bin",
        dut0.mem_net2.mem,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_11.bin",
        dut0.mem_net2.mem,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_12.bin",
        dut0.mem_net2.mem,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_13.bin",
        dut0.mem_net2.mem,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_14.bin",
        dut0.mem_net2.mem,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26_15.bin",
        dut0.mem_net2.mem,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data26.bin",
        dut0.mem_net2.mem,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_0.bin",
        dut0.mem_net3.mem,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_1.bin",
        dut0.mem_net3.mem,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_2.bin",
        dut0.mem_net3.mem,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_3.bin",
        dut0.mem_net3.mem,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_4.bin",
        dut0.mem_net3.mem,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_5.bin",
        dut0.mem_net3.mem,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_6.bin",
        dut0.mem_net3.mem,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_7.bin",
        dut0.mem_net3.mem,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_8.bin",
        dut0.mem_net3.mem,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_9.bin",
        dut0.mem_net3.mem,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_10.bin",
        dut0.mem_net3.mem,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_11.bin",
        dut0.mem_net3.mem,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_12.bin",
        dut0.mem_net3.mem,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_13.bin",
        dut0.mem_net3.mem,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_14.bin",
        dut0.mem_net3.mem,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27_15.bin",
        dut0.mem_net3.mem,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data27.bin",
        dut0.mem_net3.mem,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_0.bin",
        dut0.mem_net4.mem,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_1.bin",
        dut0.mem_net4.mem,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_2.bin",
        dut0.mem_net4.mem,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_3.bin",
        dut0.mem_net4.mem,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_4.bin",
        dut0.mem_net4.mem,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_5.bin",
        dut0.mem_net4.mem,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_6.bin",
        dut0.mem_net4.mem,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_7.bin",
        dut0.mem_net4.mem,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_8.bin",
        dut0.mem_net4.mem,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_9.bin",
        dut0.mem_net4.mem,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_10.bin",
        dut0.mem_net4.mem,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_11.bin",
        dut0.mem_net4.mem,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_12.bin",
        dut0.mem_net4.mem,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_13.bin",
        dut0.mem_net4.mem,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_14.bin",
        dut0.mem_net4.mem,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28_15.bin",
        dut0.mem_net4.mem,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data28.bin",
        dut0.mem_net4.mem,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_0.bin",
        dut0.mem_net5.mem,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_1.bin",
        dut0.mem_net5.mem,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_2.bin",
        dut0.mem_net5.mem,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_3.bin",
        dut0.mem_net5.mem,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_4.bin",
        dut0.mem_net5.mem,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_5.bin",
        dut0.mem_net5.mem,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_6.bin",
        dut0.mem_net5.mem,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_7.bin",
        dut0.mem_net5.mem,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_8.bin",
        dut0.mem_net5.mem,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_9.bin",
        dut0.mem_net5.mem,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_10.bin",
        dut0.mem_net5.mem,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_11.bin",
        dut0.mem_net5.mem,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_12.bin",
        dut0.mem_net5.mem,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_13.bin",
        dut0.mem_net5.mem,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_14.bin",
        dut0.mem_net5.mem,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29_15.bin",
        dut0.mem_net5.mem,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data29.bin",
        dut0.mem_net5.mem,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_0.bin",
        dut0.mem_net6.mem,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_1.bin",
        dut0.mem_net6.mem,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_2.bin",
        dut0.mem_net6.mem,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_3.bin",
        dut0.mem_net6.mem,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_4.bin",
        dut0.mem_net6.mem,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_5.bin",
        dut0.mem_net6.mem,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_6.bin",
        dut0.mem_net6.mem,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_7.bin",
        dut0.mem_net6.mem,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_8.bin",
        dut0.mem_net6.mem,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_9.bin",
        dut0.mem_net6.mem,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_10.bin",
        dut0.mem_net6.mem,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_11.bin",
        dut0.mem_net6.mem,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_12.bin",
        dut0.mem_net6.mem,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_13.bin",
        dut0.mem_net6.mem,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_14.bin",
        dut0.mem_net6.mem,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30_15.bin",
        dut0.mem_net6.mem,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data30.bin",
        dut0.mem_net6.mem,
        1603 + 0,
        1603 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_0.bin",
        dut0.mem_net7.mem,
        1203 + 0,
        1227 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_1.bin",
        dut0.mem_net7.mem,
        1228 + 0,
        1252 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_2.bin",
        dut0.mem_net7.mem,
        1253 + 0,
        1277 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_3.bin",
        dut0.mem_net7.mem,
        1278 + 0,
        1302 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_4.bin",
        dut0.mem_net7.mem,
        1303 + 0,
        1327 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_5.bin",
        dut0.mem_net7.mem,
        1328 + 0,
        1352 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_6.bin",
        dut0.mem_net7.mem,
        1353 + 0,
        1377 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_7.bin",
        dut0.mem_net7.mem,
        1378 + 0,
        1402 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_8.bin",
        dut0.mem_net7.mem,
        1403 + 0,
        1427 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_9.bin",
        dut0.mem_net7.mem,
        1428 + 0,
        1452 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_10.bin",
        dut0.mem_net7.mem,
        1453 + 0,
        1477 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_11.bin",
        dut0.mem_net7.mem,
        1478 + 0,
        1502 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_12.bin",
        dut0.mem_net7.mem,
        1503 + 0,
        1527 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_13.bin",
        dut0.mem_net7.mem,
        1528 + 0,
        1552 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_14.bin",
        dut0.mem_net7.mem,
        1553 + 0,
        1577 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31_15.bin",
        dut0.mem_net7.mem,
        1578 + 0,
        1602 + 0
      );
      $readmemb(
        "/home/work/takau/1.hw/bhewtek/data/mnist/lenet/bwb_2/data31.bin",
        dut0.mem_net7.mem,
        1603 + 0,
        1603 + 0
      );
    end // }}}
  endtask

  task write_output;
    integer fd;
    integer i;
    integer out_size;
    begin // {{{
      fd = $fopen("test_renkon.dat", "w");
      out_size = 800;
      for (i=0; i<out_size; i=i+1)
      begin
        input_addr = i + 5000;
        #(STEP*2);
        $fdisplay(fd, "%0d", read_img);
      end
      input_addr = 0;
      #(STEP);
      $fclose(fd);
    end // }}}
  endtask

  always
  begin
    #(STEP/2-1);
    $display(
      "%5d: ", $time/STEP, // {{{
      "%d ", dut0.ctrl.ctrl_core.r_state,
      "%d ", dut0.ctrl.ctrl_core.r_state_weight,
      "%d ", dut0.ctrl.ctrl_core.r_count_out,
      "%d ", dut0.ctrl.ctrl_core.r_count_in,
      "|o: ",
      "%d ", ack,
      "%4d ", read_img,
      "|r: ",
      "%d ", dut0.mem_img_we,
      "%d ", dut0.mem_img_addr,
      "%4d ", dut0.read_img,
      "; ",
      "%d ", dut0.mem_net_we,
      "%d ", dut0.mem_net_addr,
      "%4d ", dut0.read_net0,
      "; ",
      "%4d ", dut0.pmap0,
      "; ",
      "%0d ", dut0.serial.mem_serial0.mem[0],
      "%0d ", dut0.serial.mem_serial0.mem[1],
      "%0d ", dut0.serial.mem_serial0.mem[2],
      "%0d ", dut0.serial.mem_serial0.mem[3],
      "%0d ", dut0.serial.mem_serial0.mem[4],
      "%0d ", dut0.serial.mem_serial0.mem[5],
      "%0d ", dut0.serial.mem_serial0.mem[6],
      "%0d ", dut0.serial.mem_serial0.mem[7],
      "%0d ", dut0.serial.mem_serial0.mem[8],
      "%0d ", dut0.serial.mem_serial0.mem[9],
      "%0d ", dut0.serial.mem_serial0.mem[10],
      "%0d ", dut0.serial.mem_serial0.mem[11],
      "%0d ", dut0.serial.mem_serial0.mem[12],
      "%0d ", dut0.serial.mem_serial0.mem[13],
      "%0d ", dut0.serial.mem_serial0.mem[14],
      "%0d ", dut0.serial.mem_serial0.mem[15],
      "; ",
      "%0d ", dut0.serial.mem_serial7.mem[0],
      "%0d ", dut0.serial.mem_serial7.mem[1],
      "%0d ", dut0.serial.mem_serial7.mem[2],
      "%0d ", dut0.serial.mem_serial7.mem[3],
      "%0d ", dut0.serial.mem_serial7.mem[4],
      "%0d ", dut0.serial.mem_serial7.mem[5],
      "%0d ", dut0.serial.mem_serial7.mem[6],
      "%0d ", dut0.serial.mem_serial7.mem[7],
      "%0d ", dut0.serial.mem_serial7.mem[8],
      "%0d ", dut0.serial.mem_serial7.mem[9],
      "%0d ", dut0.serial.mem_serial7.mem[10],
      "%0d ", dut0.serial.mem_serial7.mem[11],
      "%0d ", dut0.serial.mem_serial7.mem[12],
      "%0d ", dut0.serial.mem_serial7.mem[13],
      "%0d ", dut0.serial.mem_serial7.mem[14],
      "%0d ", dut0.serial.mem_serial7.mem[15],
      "|" // }}}
    );
    #(STEP/2+1);
  end

endmodule
