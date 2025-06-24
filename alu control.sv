module alu_control (
    input  logic [1:0] aluop,
    input  logic  funct7,
    input  logic [2:0] funct3,
    output logic [3:0] alucontrol
);

    always_comb begin
        case (aluop)
            2'b00: begin // Load/Store
                alucontrol = 4'b0010; // ADD
            end
            2'b01: begin // Branch
                alucontrol = 4'b0110; // SUB
            end
            2'b10: begin // R-type
                case (funct3)
                    3'b000: alucontrol = (funct7 == 1'b0) ? 4'b0010 : 4'b0110; // ADD or SUB
                    3'b001: alucontrol = 4'b0001; // SLL
                    3'b100: alucontrol = 4'b0000; // XOR
                    3'b101: alucontrol = (funct7 == 1'b1) ? 4'b0100 : 4'b0101; // SRA or SRL
                    3'b110: alucontrol = 4'b1000; // OR
                    3'b111: alucontrol = 4'b0011; // AND
                    default: alucontrol = 4'b0000;
                endcase
            end
            default: begin
                alucontrol = 4'b0000;
            end
        endcase
    end

endmodule
