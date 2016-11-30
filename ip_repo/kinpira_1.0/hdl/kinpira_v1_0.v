
`timescale 1 ns / 1 ps

module kinpira_v1_0 #
  (
    // Users to add parameters here

    // User parameters ends
    // Do not modify the parameters beyond this line


    // Parameters of Axi Slave Bus Interface s_axi
    parameter integer C_s_axi_DATA_WIDTH  = 32,
    parameter integer C_s_axi_ADDR_WIDTH  = 7
  )
  (
    // Users to add ports here

    // User ports ends
    // Do not modify the ports beyond this line


    // Ports of Axi Slave Bus Interface s_axi
    input wire  s_axi_aclk,
    input wire  s_axi_aresetn,
    input wire [C_s_axi_ADDR_WIDTH-1 : 0] s_axi_awaddr,
    input wire [2 : 0] s_axi_awprot,
    input wire  s_axi_awvalid,
    output wire  s_axi_awready,
    input wire [C_s_axi_DATA_WIDTH-1 : 0] s_axi_wdata,
    input wire [(C_s_axi_DATA_WIDTH/8)-1 : 0] s_axi_wstrb,
    input wire  s_axi_wvalid,
    output wire  s_axi_wready,
    output wire [1 : 0] s_axi_bresp,
    output wire  s_axi_bvalid,
    input wire  s_axi_bready,
    input wire [C_s_axi_ADDR_WIDTH-1 : 0] s_axi_araddr,
    input wire [2 : 0] s_axi_arprot,
    input wire  s_axi_arvalid,
    output wire  s_axi_arready,
    output wire [C_s_axi_DATA_WIDTH-1 : 0] s_axi_rdata,
    output wire [1 : 0] s_axi_rresp,
    output wire  s_axi_rvalid,
    input wire  s_axi_rready
  );
// Instantiation of Axi Bus Interface s_axi
  wire [C_s_axi_DATA_WIDTH-1:0]	port0;
  wire [C_s_axi_DATA_WIDTH-1:0]	port1;
  wire [C_s_axi_DATA_WIDTH-1:0]	port2;
  wire [C_s_axi_DATA_WIDTH-1:0]	port3;
  wire [C_s_axi_DATA_WIDTH-1:0]	port4;
  wire [C_s_axi_DATA_WIDTH-1:0]	port5;
  wire [C_s_axi_DATA_WIDTH-1:0]	port6;
  wire [C_s_axi_DATA_WIDTH-1:0]	port7;
  wire [C_s_axi_DATA_WIDTH-1:0]	port8;
  wire [C_s_axi_DATA_WIDTH-1:0]	port9;
  wire [C_s_axi_DATA_WIDTH-1:0]	port10;
  wire [C_s_axi_DATA_WIDTH-1:0]	port11;
  wire [C_s_axi_DATA_WIDTH-1:0]	port12;
  wire [C_s_axi_DATA_WIDTH-1:0]	port13;
  wire [C_s_axi_DATA_WIDTH-1:0]	port14;
  wire [C_s_axi_DATA_WIDTH-1:0]	port15;
  wire [C_s_axi_DATA_WIDTH-1:0]	port16;
  wire [C_s_axi_DATA_WIDTH-1:0]	port17;
  wire [C_s_axi_DATA_WIDTH-1:0]	port18;
  wire [C_s_axi_DATA_WIDTH-1:0]	port19;
  wire [C_s_axi_DATA_WIDTH-1:0]	port20;
  wire [C_s_axi_DATA_WIDTH-1:0]	port21;
  wire [C_s_axi_DATA_WIDTH-1:0]	port22;
  wire [C_s_axi_DATA_WIDTH-1:0]	port23;
  wire [C_s_axi_DATA_WIDTH-1:0]	port24;
  wire [C_s_axi_DATA_WIDTH-1:0]	port25;
  wire [C_s_axi_DATA_WIDTH-1:0]	port26;
  wire [C_s_axi_DATA_WIDTH-1:0]	port27;
  wire [C_s_axi_DATA_WIDTH-1:0]	port28;
  wire [C_s_axi_DATA_WIDTH-1:0]	port29;
  wire [C_s_axi_DATA_WIDTH-1:0]	port30;
  wire [C_s_axi_DATA_WIDTH-1:0]	port31;

  ninjin # (
    .C_S_AXI_DATA_WIDTH(C_s_axi_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH(C_s_axi_ADDR_WIDTH)
  ) kinpira_v1_0_s_axi_inst (
    .port0(port0),
    .port1(port1),
    .port2(port2),
    .port3(port3),
    .port4(port4),
    .port5(port5),
    .port6(port6),
    .port7(port7),
    .port8(port8),
    .port9(port9),
    .port10(port10),
    .port11(port11),
    .port12(port12),
    .port13(port13),
    .port14(port14),
    .port15(port15),
    .port16(port16),
    .port17(port17),
    .port18(port18),
    .port19(port19),
    .port20(port20),
    .port21(port21),
    .port22(port22),
    .port23(port23),
    .port24(port24),
    .port25(port25),
    .port26(port26),
    .port27(port27),
    .port28(port28),
    .port29(port29),
    .port30(port30),
    .port31(port31),
    .S_AXI_ACLK(s_axi_aclk),
    .S_AXI_ARESETN(s_axi_aresetn),
    .S_AXI_AWADDR(s_axi_awaddr),
    .S_AXI_AWPROT(s_axi_awprot),
    .S_AXI_AWVALID(s_axi_awvalid),
    .S_AXI_AWREADY(s_axi_awready),
    .S_AXI_WDATA(s_axi_wdata),
    .S_AXI_WSTRB(s_axi_wstrb),
    .S_AXI_WVALID(s_axi_wvalid),
    .S_AXI_WREADY(s_axi_wready),
    .S_AXI_BRESP(s_axi_bresp),
    .S_AXI_BVALID(s_axi_bvalid),
    .S_AXI_BREADY(s_axi_bready),
    .S_AXI_ARADDR(s_axi_araddr),
    .S_AXI_ARPROT(s_axi_arprot),
    .S_AXI_ARVALID(s_axi_arvalid),
    .S_AXI_ARREADY(s_axi_arready),
    .S_AXI_RDATA(s_axi_rdata),
    .S_AXI_RRESP(s_axi_rresp),
    .S_AXI_RVALID(s_axi_rvalid),
    .S_AXI_RREADY(s_axi_rready)
  );

  // Add user logic here

`include "ninjin.vh"

  wire                      clk;
  wire                      xrst;
  wire signed [DWIDTH-1:0]  read_img;

  // For ninjin
  wire                      which;
  wire                      req;
  wire                      img_we;
  wire [IMGSIZE-1:0]        input_addr;
  wire [IMGSIZE-1:0]        output_addr;
  wire signed [DWIDTH-1:0]  write_img;
  wire [32-1:0]             net_we;
  wire [32-1:0]             net_addr;
  wire signed [DWIDTH-1:0]  write_net;
  wire [LWIDTH-1:0]         total_out;
  wire [LWIDTH-1:0]         total_in;
  wire [LWIDTH-1:0]         img_size;
  wire [LWIDTH-1:0]         fil_size;
  wire [LWIDTH-1:0]         pool_size;

  wire                      ack;
  wire                      mem_img_we;
  wire [IMGSIZE-1:0]        mem_img_addr;
  wire signed [DWIDTH-1:0]  write_mem_img;

  // For renkon
  wire                      renkon_req;
  wire                      renkon_img_we;
  wire [IMGSIZE-1:0]        renkon_input_addr;
  wire [IMGSIZE-1:0]        renkon_output_addr;
  wire signed [DWIDTH-1:0]  renkon_write_img;
  wire [RENKON_CORELOG:0]   renkon_net_we;
  wire [RENKON_NETSIZE-1:0] renkon_net_addr;
  wire signed [DWIDTH-1:0]  renkon_write_net;
  wire [LWIDTH-1:0]         renkon_total_out;
  wire [LWIDTH-1:0]         renkon_total_in;
  wire [LWIDTH-1:0]         renkon_img_size;
  wire [LWIDTH-1:0]         renkon_fil_size;
  wire [LWIDTH-1:0]         renkon_pool_size;
  wire signed [DWIDTH-1:0]  renkon_read_img;

  wire                      renkon_ack;
  wire                      renkon_mem_img_we;
  wire [IMGSIZE-1:0]        renkon_mem_img_addr;
  wire signed [DWIDTH-1:0]  renkon_write_mem_img;

  // For gobou
  wire                      gobou_req;
  wire                      gobou_img_we;
  wire [IMGSIZE-1:0]        gobou_input_addr;
  wire [IMGSIZE-1:0]        gobou_output_addr;
  wire signed [DWIDTH-1:0]  gobou_write_img;
  wire [GOBOU_CORELOG:0]    gobou_net_we;
  wire [GOBOU_NETSIZE-1:0]  gobou_net_addr;
  wire signed [DWIDTH-1:0]  gobou_write_net;
  wire [LWIDTH-1:0]         gobou_total_out;
  wire [LWIDTH-1:0]         gobou_total_in;
  wire [LWIDTH-1:0]         gobou_img_size;
  wire [LWIDTH-1:0]         gobou_fil_size;
  wire [LWIDTH-1:0]         gobou_pool_size;
  wire signed [DWIDTH-1:0]  gobou_read_img;

  wire                      gobou_ack;
  wire                      gobou_mem_img_we;
  wire [IMGSIZE-1:0]        gobou_mem_img_addr;
  wire signed [DWIDTH-1:0]  gobou_write_mem_img;

  reg r_which;



  /* which:
   *   0: renkon  (2D convolution)
   *   1: gobou   (1D linear)
   */
  assign clk          = s_axi_aclk;
  assign xrst         = s_axi_aresetn;
  assign which        =  port0[0];
  assign req          =  port1[0];
  assign img_we       =  port2[0];
  assign input_addr   =  port3[IMGSIZE-1:0];
  assign output_addr  =  port4[IMGSIZE-1:0];
  assign write_img    =  port5[DWIDTH-1:0];
  assign net_we       =  port6[32-1:0];
  assign net_addr     =  port7[32-1:0];
  assign write_net    =  port8[DWIDTH-1:0];
  assign total_out    =  port9[LWIDTH-1:0];
  assign total_in     = port10[LWIDTH-1:0];
  assign img_size     = port11[LWIDTH-1:0];
  assign fil_size     = port12[LWIDTH-1:0];
  assign pool_size    = port13[LWIDTH-1:0];

  assign port31 = {31'b0, r_which};
  assign port30 = {31'b0, ack};
  assign port29 = {{(32-DWIDTH){read_img[DWIDTH-1]}}, read_img};

  // For renkon
  assign renkon_req         = !which ? req         : 0;
  assign renkon_img_we      = !which ? img_we      : 0;
  assign renkon_input_addr  = !which ? input_addr  : 0;
  assign renkon_output_addr = !which ? output_addr : 0;
  assign renkon_write_img   = !which ? write_img   : 0;
  assign renkon_net_we      = !which ? net_we[RENKON_CORELOG:0] : 0;
  assign renkon_net_addr    = !which ? net_addr[RENKON_NETSIZE-1] : 0;
  assign renkon_write_net   = !which ? write_net   : 0;
  assign renkon_total_out   = !which ? total_out   : 0;
  assign renkon_total_in    = !which ? total_in    : 0;
  assign renkon_img_size    = !which ? img_size    : 0;
  assign renkon_fil_size    = !which ? fil_size    : 0;
  assign renkon_pool_size   = !which ? pool_size   : 0;
  assign renkon_read_img    = !which ? read_img    : 0;

  // For gobou
  assign gobou_req          = which ? req         : 0;
  assign gobou_img_we       = which ? img_we      : 0;
  assign gobou_input_addr   = which ? input_addr  : 0;
  assign gobou_output_addr  = which ? output_addr : 0;
  assign gobou_write_img    = which ? write_img   : 0;
  assign gobou_net_we       = which ? net_we[GOBOU_CORELOG:0] : 0;
  assign gobou_net_addr     = which ? net_addr[GOBOU_NETSIZE-1:0] : 0;
  assign gobou_write_net    = which ? write_net   : 0;
  assign gobou_total_out    = which ? total_out   : 0;
  assign gobou_total_in     = which ? total_in    : 0;
  assign gobou_img_size     = which ? img_size    : 0;
  assign gobou_fil_size     = which ? fil_size    : 0;
  assign gobou_pool_size    = which ? pool_size   : 0;
  assign gobou_read_img     = which ? read_img    : 0;

  assign ack            = !which ? renkon_ack           : gobou_ack           ;
  assign mem_img_we     = !which ? renkon_mem_img_we    : gobou_mem_img_we    ;
  assign mem_img_addr   = !which ? renkon_mem_img_addr  : gobou_mem_img_addr  ;
  assign write_mem_img  = !which ? renkon_write_mem_img : gobou_write_mem_img ;



  always @(posedge clk)
    if (!xrst)
      r_which <= 0;
    else
      r_which <= which;

  mem_img mem_img0(/*AUTOINST*/
    // Outputs
    .read_data  (read_img[DWIDTH-1:0]),
    // Inputs
    .clk        (clk),
    .mem_we     (mem_img_we),
    .mem_addr   (mem_img_addr[IMGSIZE-1:0]),
    .write_data (write_mem_img[DWIDTH-1:0])
  );

  renkon renkon0(/*AUTOINST*/
    // Outputs
    .ack            (renkon_ack),
    .mem_img_we     (renkon_mem_img_we),
    .mem_img_addr   (renkon_mem_img_addr[IMGSIZE-1:0]),
    .write_mem_img  (renkon_write_mem_img[DWIDTH-1:0]),
    // Inputs
    .clk            (clk),
    .xrst           (xrst),
    .req            (renkon_req),
    .img_we         (renkon_img_we),
    .input_addr     (renkon_input_addr[IMGSIZE-1:0]),
    .output_addr    (renkon_output_addr[IMGSIZE-1:0]),
    .write_img      (renkon_write_img[DWIDTH-1:0]),
    .net_we         (renkon_net_we[RENKON_CORELOG:0]),
    .net_addr       (renkon_net_addr[RENKON_NETSIZE-1:0]),
    .write_net      (renkon_write_net[DWIDTH-1:0]),
    .total_out      (renkon_total_out[LWIDTH-1:0]),
    .total_in       (renkon_total_in[LWIDTH-1:0]),
    .img_size       (renkon_img_size[LWIDTH-1:0]),
    .fil_size       (renkon_fil_size[LWIDTH-1:0]),
    .pool_size      (renkon_pool_size[LWIDTH-1:0]),
    .read_img       (renkon_read_img[DWIDTH-1:0])
  );

  gobou gobou0(/*AUTOINST*/
    // Outputs
    .ack            (gobou_ack),
    .mem_img_we     (gobou_mem_img_we),
    .mem_img_addr   (gobou_mem_img_addr[IMGSIZE-1:0]),
    .write_mem_img  (gobou_write_mem_img[DWIDTH-1:0]),
    // Inputs
    .clk            (clk),
    .xrst           (xrst),
    .req            (gobou_req),
    .img_we         (gobou_img_we),
    .input_addr     (gobou_input_addr[IMGSIZE-1:0]),
    .output_addr    (gobou_output_addr[IMGSIZE-1:0]),
    .write_img      (gobou_write_img[DWIDTH-1:0]),
    .net_we         (gobou_net_we[GOBOU_CORELOG:0]),
    .net_addr       (gobou_net_addr[GOBOU_NETSIZE-1:0]),
    .write_net      (gobou_write_net[DWIDTH-1:0]),
    .total_out      (gobou_total_out[LWIDTH-1:0]),
    .total_in       (gobou_total_in[LWIDTH-1:0]),
    .read_img       (gobou_read_img[DWIDTH-1:0])
  );

  // User logic ends

endmodule
