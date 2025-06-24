module tb_imm_gen;

    logic [31:0] instruction;
    logic [31:0] imm;
    // Instantiate the imm_gen module
    imm_gen uut (
        .instruction(instruction),
        .imm(imm)
    );
    initial begin
        // Test case 1: Load instruction
        instruction = 32'b00000000000100000000000000000011; // I-type load
        #10;
        // Test case 2: Immediate arithmetic instruction
        instruction = 32'b00000000000100010000000000010011; // I-type addi
        #10;             
        // Test case 3: Store instruction
        instruction = 32'b11111111111111111111111110100011; // S-type sw
        #10;
        // Test case 4: Branch instruction
        instruction = 32'b11000000000101010001000001100011; // B-type beq
        #10;
    end

endmodule
