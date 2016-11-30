module renkon_mem_linebuf(/*AUTOARG*/
   // Outputs
   read_data,
   // Inputs
   clk, mem_we, mem_addr, write_data
   );
`include "renkon.vh"
    localparam WORDS   = 2 ** BUFSIZE;

    /*AUTOINPUT*/
    input clk;
    input mem_we;
    input [BUFSIZE-1:0] mem_addr;
    input signed [DWIDTH-1:0] write_data;

    /*AUTOOUTPUT*/
    output signed [DWIDTH-1:0] read_data;

    /*AUTOWIRE*/

    /*AUTOREG*/

    reg [DWIDTH-1:0] mem [WORDS-1:0];
    reg [DWIDTH-1:0] addr_reg;

    always @(posedge clk)
    begin
        if(mem_we)
          mem[mem_addr] <= write_data;
        addr_reg <= mem_addr;
    end

    assign read_data = mem[addr_reg];

    integer i;
    initial
      for (i = 0; i < WORDS; i = i + 1)
        mem[i] = 0;

endmodule