`timescale 1ns/1ns
module tb_alu2();
reg [3:0] ALUControl;
reg [31:0] A, B;
wire [31:0] ALUResult;
wire Zero;

ALU32Bit u0(.ALUControl(ALUControl), .A(A), .B(B), .ALUResult(ALUResult), .Zero(Zero));

initial
begin
ALUControl = 4'b0000; A = 15; B = 8;
#250; ALUControl = 4'b0001; A = 15; B = 8;
#250; ALUControl = 4'b0010; A = 15; B = 8;
#250; ALUControl = 4'b0110; A = 15; B = 8;
#250; ALUControl = 4'b0111; A = 15; B = 8;
#250; ALUControl = 4'b1100; A = 15; B = 8;
end

endmodule
