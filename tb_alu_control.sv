module tb_alu_control(
  output  logic [1:0] aluop,
    output  logic funct7,
    output  logic [2:0] funct3,
    input logic [3:0] alucontrol
);
alu_control alu_control_inst (
    .aluop(aluop),
    .funct7(funct7),
    .funct3(funct3),
    .alucontrol(alucontrol)
);
initial begin
    // Test case 1: Load/Store operation
    aluop = 2'b00;
    funct7 = 0;
    funct3 = 3'b000;
    #10; // Wait for the output to stabilize
    assert(alucontrol == 4'b0010) else $fatal("Test case 1 failed");

    // Test case 2: Branch operation
    aluop = 2'b01;
    funct7 = 0;
    funct3 = 3'b000;
    #10; // Wait for the output to stabilize
    assert(alucontrol == 4'b0110) else $fatal("Test case 2 failed");

    // Test case 3: R-type ADD operation
    aluop = 2'b10;
    funct7 = 0;
    funct3 = 3'b000;
    #10; // Wait for the output to stabilize
    assert(alucontrol == 4'b0010) else $fatal("Test case 3 failed");

    // Test case 4: R-type SUB operation
    aluop = 2'b10;
    funct7 = 1; // funct7[5] = 1
    funct3 = 3'b000;
    #10; // Wait for the output to stabilize
    assert(alucontrol == 4'b0110) else $fatal("Test case 4 failed");

    // Test case 5: R-type SLL operation
    aluop = 2'b10;
    funct7 = 0;
    funct3 = 3'b001;
    #10; // Wait for the output to stabilize
    assert(alucontrol == 4'b0001) else $fatal("Test case 5 failed");

    // Test case 6: R-type XOR operation
    aluop = 2'b10;
    funct7 = 7'b0000000;
    funct3 = 3'b100;
    #10; // Wait for the output to stabilize
    assert(alucontrol == 4'b0000) else $fatal("Test case 6 failed");

    // Test case 7: R-type SRL operation
    aluop = 2'b10;
    funct7 = 0; // funct7[5] = 0
    funct3 = 3'b101;
    #10; // Wait for the output to stabilize
    assert(alucontrol == 4'b0101) else $fatal("Test case 7 failed");
    // Test case 8: R-type SRA operation
    aluop = 2'b10;
    funct7 = 1; // funct7[5] = 1
    funct3 = 3'b101;
    #10; // Wait for the output to stabilize
    assert(alucontrol == 4'b0100) else $fatal("Test case 8 failed");
    // Test case 9: R-type OR operation
    aluop = 2'b10;
    funct7 = 0;
    funct3 = 3'b110;
    #10; // Wait for the output to stabilize
    assert(alucontrol == 4'b1000) else $fatal("Test case 9 failed");
    // Test case 10: R-type AND operation
    aluop = 2'b10;
    funct7 = 0;
    funct3 = 3'b111;
    #10; // Wait for the output to stabilize
    assert(alucontrol == 4'b0011) else $fatal("Test case 10 failed");
end


endmodule