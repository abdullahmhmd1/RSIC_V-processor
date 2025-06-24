module imm_gen(
    input  logic [31:0] instruction, // 32-bit instruction input
    output logic [31:0] imm          // 64-bit immediate output
);

    always @(*) begin
        case (instruction[6:0]) // Check the opcode
            7'b0000011, // Load instructions
            7'b0010011: // I-type immediate arithmetic
                imm = {{20{instruction[31]}}, instruction[31:20]}; // 12-bit sign-extend

            7'b0100011: // S-type store instructions
                imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // 12-bit sign-extend

            7'b1100011: // B-type branch instructions
                imm = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // 13-bit sign-extend
            7'b 1101111: //
            imm= {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            default:
                imm = 32'b0; // Fallback/default
        endcase
    end

endmodule
