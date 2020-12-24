`timescale 1ns/1ns

module tb_aludec();

reg   [5:0] func;
reg   [1:0] aluop;
wire [2:0] alucontrol;

aludec u0(func, aluop, alucontrol);


initial
begin
aluop=2'b00;
#50; aluop=2'b01;
end

initial
begin
func=6'b000000;
#20; func=6'b100000;
#20; func=6'b100010;
#20; func=6'b100100;
#20; func=6'b100101;
#20; func=6'b100000;
end


endmodule
