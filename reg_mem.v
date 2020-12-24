module regmem(
	 clk,
    rst,
    rgr1,
    rgr2,
    write,
    rgw1,
    rgw1data,
    rg1data,
    rg2data
);

    input [4:0] rgr1;
    input [4:0] rgr2;
    input [4:0]     rgw1;
    input [31:0]  rgw1data;
    input clk;
    input rst;
    input write;
    output reg [31:0] rg1data;
    output reg [31:0] rg2data;
	 
	 
    reg [31:0] regMem [31:0]; // register memory
    

/*
    assign rg1data = regMem[rgr1];
    assign rg2data = regMem[rgr2];
*/

  always @(rgr1 or rgr2)
  begin
    rg1data = regMem[rgr1];
    rg2data = regMem[rgr2];
  end

  always @(posedge write)
  begin
    if(rgw1 == 5'b0) regMem[0] = 5'b0;
    else regMem[rgw1] = rgw1data;
  end

    ///write to register
    integer i;

    initial 
    begin
        for( i = 0; i < 32; i = i + 1 )
            regMem[i] = i;
    end


  always @(posedge clk or negedge reset)
    begin
        regMem[0] = 32'b0; //register 0 is hardwired to zero;
        if(reset == 1'b0)
        begin 
            regMem[0] = 32'b0;
            // set all registers to their defaults 
            for( i = 0; i < 32; i = i + 1 )
                regMem[i] = i;
        end
        else if(write == 1'b1 && rgw1 != 5'd0) //$zero register is hardwired to zero
            regMem[rgw1] = rgw1data;
    end

endmodule