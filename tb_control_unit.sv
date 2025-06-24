module tb_control_unit(
output logic [6:0] opcode ,input logic branch 
    ,memread
    ,memtoreg
    ,memwrite
    ,alusrc
    ,regwrite
    ,jump
    ,input logic [1:0] aluop


);
control_unit control_unit_inst (
    .opcode(opcode),
    .branch(branch),
    .memread(memread),
    .memtoreg(memtoreg),
    .memwrite(memwrite),
    .alusrc(alusrc),
    .regwrite(regwrite),
    .aluop(aluop),
    .jump(jump)
);
initial begin
    // Test case 1: R-type instruction (opcode = 7'b0110011)
    opcode = 7'b0110011;
    #10; // Wait for the output to stabilize

    // Test case 2: Load instruction (opcode = 7'b0000011)
    opcode = 7'b0000011;
    #10; // Wait for the output to stabilize

    // Test case 3: Add immediate instruction (opcode = 7'b0010011)
    opcode = 7'b0010011;
    #10; // Wait for the output to stabilize

    // Test case 4: Store instruction (opcode = 7'b0100011)
    opcode = 7'b0100011;
    #10; // Wait for the output to stabilize
   
    // Test case 5: Branch instruction (opcode = 7'b1100011)
    opcode = 7'b1100011;
    #10; // Wait for the output to stabilize
    //test case 6: Jump and link instruction (opcode = 7'b1101111)
    opcode = 7'b1101111;
    #10; // Wait for the output to stabilize
   
end

endmodule