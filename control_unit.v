module control_unit (op, regdst, regwrite, branch, jump, memread, memtoreg, memwrite, aluop, aluscr);
	input[5:0] 	op;
  	output reg [1:0] regdst;
  	output reg regwrite;
	output reg branch;
	output reg jump;
	output reg memread;
  	output reg [1:0]memtoreg;
  	output reg memwrite;
	output reg [1:0] aluop;
	output reg aluscr;

	always @(*) begin
		// default
		// R-type
		branch 		<= 1'b0;
		jump 		<= 1'b0;
		memread 	<= 1'b0;
		memtoreg[1:0]	<= 2'b00;
		memwrite	<= 1'b0;
		aluop[1:0]	<= 2'b10;
		aluscr		<= 1'b0;
		regdst[1:0] <= 2'b01;
		regwrite	<= 1'b1;

		case(op)
			6'b10_0011: 
			begin // lw
				regdst[1:0]		<= 2'b00;
				memread     	<= 1'b1;
            aluop[1:0]		<= 2'b00;
				aluscr			<= 1'b1;
            memtoreg[1:0]	<= 2'b01;
			end
			6'b10_1011: 
			begin // sw
            aluop[1]	<= 1'b0;
				aluscr	<= 1'b1;
				memwrite <= 1'b1;
				regwrite	<= 1'b0;
			end
			6'b00_0100: 
			begin // beq
				branch		<= 1'b1;
				aluop[1:0]	<= 2'b01;
				regwrite		<= 1'b0;
			end
			6'b00_1000: 
			begin // addi
            regdst[1:0] <= 2'b00;
				aluop[1] 	<= 1'b0;
				aluscr   	<= 1'b1;
			end
			6'b00_0010: 
			begin //jump
			  jump		<= 1'b1;
			  regwrite	<= 1'b0;
			end
			6'b00_0011: 
			begin
			  jump 				<= 1'b1;
			  regdst[1:0]		<= 2'b10;
			  memtoreg[1:0]	<= 2'b10;
			end
			6'b00_0000: 
			begin // add
			end
		endcase
	end
endmodule 