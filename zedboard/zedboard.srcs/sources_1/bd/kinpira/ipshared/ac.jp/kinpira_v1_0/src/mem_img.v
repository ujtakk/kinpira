
module mem_img(/*AUTOARG*/
   // Outputs
   read_data,
   // Inputs
   clk, mem_we, mem_addr, write_data
   );
`include "ninjin.vh"
  // parameter WORDS = 2 ** IMGSIZE;
  parameter WORDS = 5000;

  /*AUTOINPUT*/
  input                     clk;
  input                     mem_we;
  input [IMGSIZE-1:0]        mem_addr;
  input signed [DWIDTH-1:0] write_data;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] read_data;

  /*AUTOWIRE*/

  /*AUTOREG*/
  reg signed [DWIDTH-1:0] mem [WORDS-1:0];
  reg [DWIDTH-1:0]        addr_reg;

  assign read_data = mem[addr_reg];

  always @(posedge clk)
  begin
    if (mem_we)
      mem[mem_addr] <= write_data;
    addr_reg <= mem_addr;
  end

endmodule