module rsic (
  input  logic clk
   
);
    // Wires
    wire [31:0] next_pc;             // Next program counter value
    wire [31:0] pc_value;            // Current program counter value
    wire [31:0] instruction;         // Output instruction
    wire [31:0] res1, res2;          // Intermediate PC results
    wire branch;
    wire mem_read;
    wire mem_write;
    wire [1:0] memtoreg;
    wire jump;
    wire [1:0] alu_op;
    wire alu_src;
    wire reg_write;
    wire pcSrc;
    wire [31:0] write_data;          // Data to write to register file
    wire [31:0] imm;                 // Immediate value for ALU operations
    wire [3:0] alu_control_signal;   // ALU control signal
    wire [31:0] read_data1;          // Data read from register 1
    wire [31:0] read_data2;          // Data read from register 2
    wire [31:0] alu_src_data;        // Data for ALU source
    wire zero;                       // Zero flag for ALU result
    wire [31:0] alu_result;          // ALU result
    wire [31:0] read_data_mem;       // Data read from memory

    // PC source decision
    assign pcSrc = (branch & zero)| jump;

    // Instantiate Control Unit
    control_unit cu (
        .opcode     (instruction[6:0]),
        .branch     (branch),
        .memread   (mem_read),
        .memwrite  (mem_write),
        .memtoreg   (memtoreg),
        .aluop     (alu_op),
        .alusrc    (alu_src),
        .regwrite  (reg_write),
        .jump      (jump)
    );

    // ALU Control Unit
    alu_control alu_ctrl (
        .aluop     (alu_op),
        .funct3     (instruction[14:12]),
        .funct7     (instruction[30]),
        .alucontrol (alu_control_signal)
    );

    // ALU
    M_alu alu (
        .alucontrol (alu_control_signal),
        .a          (read_data1),
        .b          (alu_src_data),
        .result     (alu_result),
        .zero       (zero)
    );

    // ALU Source MUX
    mux2to1 mux1 (
        .a   (read_data2),
        .b   (imm),
        .sel (alu_src),
        .out (alu_src_data)
    );
    // Write Back MUX
    mux3to1 mux2 (
        .a   (alu_result),
        .b   (read_data_mem),
        .c   (pc_value + 32'd4), // For JAL
        .sel (memtoreg),
        .out (write_data)
    );

    // PC MUX
    mux2to1 mux3 (
        .a   (res1),
        .b   (res2),
        .sel (pcSrc),
        .out (next_pc)
    );

    // PC + 4
    adder pc_adder (
        .a   (pc_value),
        .b   (32'd4),
        .sum (res1)
    );

    // Branch Address Adder
    adder branch_adder (
        .a   (pc_value),
        .b   (imm),
        .sum (res2)
    );

    // Immediate Generator
    imm_gen imm_gen_inst (
        .instruction (instruction),
        .imm         (imm)
    );

    // Register File
    reg_file reg_file_inst (
        .clk         (clk),
        .read_reg1   (instruction[19:15]),  // rs1
        .read_reg2   (instruction[24:20]),  // rs2
        .write_reg   (instruction[11:7]),   // rd
        .write_data  (write_data),
        .regwrite    (reg_write),
        .read_data1  (read_data1),
        .read_data2  (read_data2)
    );

    // Program Counter
    pc pc_inst (
        .clk      (clk),
        .next_pc  (next_pc),
        .pc_value (pc_value)
    );

    // Instruction Memory
    instruction_mem inst_mem (
        .pc_value    (pc_value),
        .instruction (instruction)
    );

    // Data Memory
    data_mem data_mem_inst (
        .clk        (clk),
        .address    (alu_result),
        .write_data (read_data2),
        .mem_read   (mem_read),
        .mem_write  (mem_write),
        .read_data  (read_data_mem)
    );
   

endmodule
