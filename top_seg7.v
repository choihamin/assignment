module top_seg7(rst, clk, seg1, seg2, seg3, seg4, seg5, seg6);
  input  rst, clk;
  
  output[6:0] seg1;
  output[6:0] seg2;
  output[6:0] seg3;
  output[6:0] seg4;
  output[6:0] seg5;
  output[6:0] seg6;

  wire[3:0] digit1;
  wire[3:0] digit2;
  wire[3:0] digit3;
  wire[3:0] digit4;
  wire[3:0] digit5;
  wire[3:0] digit6;
  
  wire out_clk;
  
  reg [31:0] addr;
  wire [31:0] inst;
  wire [1:0] regdst;
  wire jump, branch, memread;
  wire [1:0] memtoreg;
  wire [1:0] aluop;
  wire memwrite, alusrc, regwrite;
  wire [4:0] mux1rw;
  wire [31:0] memdata;
  wire [31:0] regrd1, regrd2;
  wire [31:0] signex;
  wire [31:0] mux2out;
  wire [31:0] aluout;
  wire alu0;
  wire[2:0] aluctrl;
  wire [31:0] dmemrd;
  wire bB;
  wire [31:0] jaddr;
  wire [31:0] nextpc;
				
  
  // 50MHz -> 1Hz  divide
  clk_dll u0(rst, clk, out_clk); 
  
  // cpu
  cpu u1(rst,clk, .addr(addr), .instruction(inst), .cu_regdst(regdst), .cu_jump(jump), 
				.cu_branch(branch), .cu_memread(memread), .cu_memtoreg(memtoreg), .cu_aluop(aluop),
				.cu_memwrite(memwrite), .cu_aluscr(alusrc), .cu_regwrite(regwrite),
				.mux1_regwrite(mux1rw), .memdata(memdata), .reg_readdata1(regrd1), 
				.reg_readdata2(regrd2), .signext_out(signex), .mux2_out(mux2out), .alu_out(aluout),
				.alu_zero(alu0), .aluctrl_out(aluctrl), .dmem_readdata(dmemrd),
				.bBranch(bB), 
				.j_addr(jaddr), 
				.next_pc(nextpc));
				
  wire [31:0] q1; // quotient
  wire [31:0] q2;
  wire [31:0] q3;
  wire [31:0] s1; // remainder
  wire [31:0] s2;
  wire [31:0] s3;
  
  div dv1(clk, aluout, 16'd1000,.q(q1), .s(s1));
  div dv2(clk, s1, 16'd100, .q(q2), .s(s2));
  div dv3(clk, s2, 16'd100, .q(q3), .s(s3));
  
  assign digit4 = q1[3:0];
  assign digit3 = q2[3:0];
  assign digit2 = q3[3:0];
  assign digit1 = s3[3:0];
  
  wire [31:0] q4;
  wire [31:0] s4;
  
  div dv4(clk, nextpc, 16'd10,.q(q4),.s(s4));
  
  assign digit6 = q4[3:0];
  assign digit5 = s4[3:0];
  
  // 7-segment decoder   
  seg7 u2(digit1, seg1);
  seg7 u3(digit2, seg2);
  seg7 u4(digit3, seg3);
  seg7 u5(digit4, seg4);
  seg7 u6(digit5, seg5);
  seg7 u7(digit6, seg6);
  
endmodule
