module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input   [3:0]   ALUControl; // control bits for ALU operation
	input   [31:0]  A, B;	    // inputs

	output  reg [31:0]  ALUResult;	// answer
	output  reg     Zero;	    // Zero=1 if ALUResult == 0

    /* Please fill in the implementation here... */


    always @(ALUControl,A,B)
    begin
	case (ALUControl)
		4'b0000: // AND
			ALUResult <= A & B;
		4'b0001: // OR
			ALUResult <= A | B;
		4'b0010: // ADD
			ALUResult <= A + B;
		4'b0110: // SUB
			ALUResult <= A + (~B + 1);
		4'b0111: begin // SLT
			if (A[31] != B[31]) 
			begin
				if (A[31] > B[31]) begin
					ALUResult <= 1;
				end 
				else begin
					ALUResult <= 0;
				end
			end 
			else begin
				if (A < B)
				begin
					ALUResult <= 1;
				end
				else
				begin
					ALUResult <= 0;
				end
			end
			end
		4'b1100: // NOR
			ALUResult <= ~(A | B);

	endcase
     end

always @(ALUResult) begin
	if (ALUResult == 0) begin
		Zero <= 1;
	end else begin
		Zero <= 0;
	end

end

endmodule
