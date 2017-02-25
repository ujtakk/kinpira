
module renkon_mem_feat(/*AUTOARG*/
   // Outputs
   read_data1, read_data2,
   // Inputs
   clk, mem_we1, mem_we2, mem_addr1, mem_addr2, write_data1,
   write_data2
   );
`include "ninjin.vh"
`include "renkon.vh"
  parameter WORDS = 2 ** FACCUM;

  /*AUTOINPUT*/
  input                     clk;
  input                     mem_we1;
  input                     mem_we2;
  input [FACCUM-1:0]        mem_addr1;
  input [FACCUM-1:0]        mem_addr2;
  input signed [DWIDTH-1:0] write_data1;
  input signed [DWIDTH-1:0] write_data2;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] read_data1;
  output signed [DWIDTH-1:0] read_data2;

  /*AUTOWIRE*/

  /*AUTOREG*/
  reg signed [DWIDTH-1:0] mem [WORDS-1:0];
  reg [DWIDTH-1:0]        addr_reg1;
  reg [DWIDTH-1:0]        addr_reg2;

  always @(posedge clk)
  begin
    if(mem_we1)
      mem[mem_addr1] <= write_data1;
    addr_reg1 <= mem_addr1;
  end

  always @(posedge clk)
  begin
    //if(mem_we2)
    //  mem[mem_addr2] <= write_data2;
    addr_reg2 <= mem_addr2;
  end

  assign read_data1 = mem[addr_reg1];
  assign read_data2 = mem[addr_reg2];

endmodule
