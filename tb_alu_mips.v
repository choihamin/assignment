`timescale 1ns/1ns

module tb_alu_mips();
reg [31:0] a, b;
reg [3:0] control;
wire [31:0] outalu;
wire zero;

alu_mips u0(a, b, control, outalu, zero);

initial
begin
control=0; a=0; b=0;
end

always #50
begin  
	control=control+1;
end

always #10
begin
	a=a+1;
end

always #15
begin
	b=b+1;
end

always #5
begin
	$display("a : %b", a);
	$display("b : %b", b);
	$display("outalu : %b", outalu);
	$display("zero : %b\n", zero);
end


endmodule

