module datamem(rst, clk, dataOut, address, dataIn, writemode, readmode);
  input rst,clk;
  output [31:0] dataOut;
  input [31:0] address, dataIn;
  input writemode, readmode;


  reg [31:0] Mem [99:0];
  
  assign dataOut = readmode ? Mem[address >> 2] : 0;

  always @(posedge reset or posedge clk)
		if (rst)
			for (i = 0; i < RAM_SIZE; i = i + 1)
				Mem[i] <= 32'h00000000;
		else if (writemode)
			Mem[address[8 + 1:2]] <= dataIn;
endmodule 