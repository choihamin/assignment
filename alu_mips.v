module alu_mips(a, b, control, outalu, zero);
input [31:0] a, b;
input [2:0] control;
output reg [31:0] outalu;
output zero;

always@(control, a, b)
begin
	case(control)
		0 : outalu=a&b;
		1 : outalu= a|b;
		4 : outalu=a+b;
		6 : outalu=a-b;
		7 : outalu=a<b?1:0;
		12 : outalu=~(a|b);
		default : outalu=0;
	endcase
end

assign zero=outalu==0?x1:0;

endmodule
