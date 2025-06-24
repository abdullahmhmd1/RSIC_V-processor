module tb_alu(
output logic [31:0] a, 
output logic [31:0] b, // Inputs to the ALU
output logic [3:0] alucontrol, // ALU control signal
input logic [31:0] result, // Output of the ALU
input logic zero // Zero flag

);
M_alu alu (
    .a(a), 
    .b(b), 
    .alucontrol(alucontrol), 
    .result(result), 
    .zero(zero)
);
initial begin
    // Test case 1: ADD
    a = 32'h000001; // 1
    b = 32'h000002; // 2
    alucontrol = 4'b0010; // ADD
    #10; // Wait for ALU to compute

    // Test case 2: SUB
    a = 32'h000005; // 5
    b = 32'h000003; // 3
    alucontrol = 4'b0110; // SUB
    #10;

    // Test case 3: SLL
    a = 32'h000001; // 1
    b = 32'h000002; // Shift by 2
    alucontrol = 4'b0001; // SLL
    #10;

    // Test case 4: SRL
    a = 32'h800000; // -2 in two's complement
    b = 32'h1; // Shift by 1
    alucontrol = 4'b0101; // SRL
    #10;

    // Test case 5: SRA
    a = 32'h800000; // -2 in two's complement
    b = 32'h1; // Shift by 1
    alucontrol = 4'b0100; // SRA
    #10;

    // Test case 6: XOR
    a = 32'hFFFFFFF; 
    b = 32'hAAAAAAA;
    alucontrol = 4'b0000; // XOR
    #10;

    // Test case 7: AND
    a = 32'hFFFFFFFF;
    b = 32'h5555555;
    alucontrol = 4'b0011; // AND
    #10;

    // Test case 8: OR
    a = 32'hFFFFFFFF;
    b = 32'h55555555;
    alucontrol = 4'b1000; // OR
    #10;
end


endmodule