module cpu (rst, clk, addr, instruction, cu_regdst, cu_jump, cu_branch, cu_memread, cu_memtoreg, cu_aluop, cu_memwrite, cu_aluscr, cu_regwrite,
				mux1_regwrite, memdata, reg_readdata1, reg_readdata2, signext_out, mux2_out, alu_out, alu_zero, aluctrl_out, dmem_readdata,
				bBranch, j_addr, next_pc);
  	  input rst,clk;
  	  output reg [31:0] addr;
	  output [31:0] instruction;
	  output [1:0] cu_regdst;
	  output cu_jump, cu_branch, cu_memread;
	  output [1:0] cu_memtoreg;
	  output [1:0] cu_aluop;
	  output cu_memwrite, cu_aluscr, cu_regwrite;
	  output [4:0] mux1_regwrite;
	  output [31:0] memdata;
	  output [31:0] reg_readdata1, reg_readdata2;
	  output [31:0] signext_out;
	  output [31:0] mux2_out;
	  output [31:0] alu_out;
	  output alu_zero;
	  output [2:0] aluctrl_out;
	  output [31:0] dmem_readdata;
	  output bBranch;
     output [31:0] j_addr;
     output [31:0] next_pc;
	  
    wire [31:0] pc;
	 
	 always @(posedge reset or posedge clk)
		if (reset)
			addr <= 32'h00000000;
		else
			addr <= pc;
	 
    initial 
	 begin
        addr = addr << 2;
    end

    reg [31:0] ra;
    parameter ra_addr = 5'b11111;

    instr_mem instrmem (addr,instruction);
    assign pc = addr + 4;
    control_unit contrlu (instruction[31:26], cu_regdst, cu_regwrite, cu_branch, cu_jump, cu_memread, cu_memtoreg, cu_memwrite, cu_aluop, cu_aluscr);
	 
    mux5_3to1 mux01 (mux1_regwrite, instruction[20:16], instruction[15:11], ra_addr, cu_regdst[1:0]);
	 
    regmem rmem (clk, rst, instruction[25:21], instruction[20:16], mux1_regwrite, memdata, cu_regwrite, reg_readdata1, reg_readdata2);
	 
    aludec aluctrl (instruction[5:0], cu_aluop, aluctrl_out);
	 
    sign_extended signext (signext_out[31:0], instruction[15:0]);
	 
    mux32_2to1 mux02 (mux2_out, reg_readdata2, signext_out, cu_aluscr);
	 
    alu_mips ALU (reg_readdata1, mux2_out, aluctrl_out, alu_out, alu_zero);
	 
    datamem data_mem (clk, dmem_readdata, alu_out, reg_readdata2, cu_memread, cu_memwrite);

    always @(posedge clk) addr <= pc;

    mux32_3to1 memmux(memdata, alu_out, dmem_readdata, pc, cu_memtoreg);
    and AND1(bBranch, cu_branch, alu_zero );

    wire [31:0] branch_shiftl2_result;
    wire [31:0] b_addr;
    wire [31:0] mux04_result;

    assign branch_shiftl2_result = signext_out << 2;
    assign b_addr = pc + branch_shiftl2_result;
    assign j_addr = {pc[31:28],instruction[25:0] << 2};

    mux32_2to1 mux04 (mux04_result, pc, b_addr, bBranch);
    mux32_2to1 mux05 (next_pc, mux04_result, j_addr, cu_jump);


endmodule 