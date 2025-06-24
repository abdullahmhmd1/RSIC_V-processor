module control_unit (
    input  logic [6:0] opcode,
    output logic       branch,
    output logic       memread,
    output logic       memwrite,
    output logic       alusrc,
    output logic       regwrite,
    output logic       jump,
    output logic [1:0] aluop,
    output logic [1:0] memtoreg
);

always @(*) begin
    case (opcode)
        7'b0110011: begin // R-type
            alusrc    = 0;
            memtoreg  = 2'b00;
            regwrite  = 1;
            memread   = 0;
            memwrite  = 0;
            branch    = 0;
            aluop     = 2'b10;
            jump      = 0;
        end

        7'b0000011: begin // lw
            alusrc    = 1;
            memtoreg  = 2'b01;
            regwrite  = 1;
            memread   = 1;
            memwrite  = 0;
            branch    = 0;
            aluop     = 2'b00;
            jump      = 0;
        end

        7'b0010011: begin // addi
            alusrc    = 1;
            memtoreg  = 2'b00;
            regwrite  = 1;
            memread   = 0;
            memwrite  = 0;
            branch    = 0;
            aluop     = 2'b00;
            jump      = 0;
        end

        7'b0100011: begin // sw
            alusrc    = 1;
            memtoreg  = 2'bxx; // don't care
            regwrite  = 0;
            memread   = 0;
            memwrite  = 1;
            branch    = 0;
            aluop     = 2'b00;
            jump      = 0;
        end

        7'b1100011: begin // beq
            alusrc    = 0;
            memtoreg  = 2'bxx; // don't care
            regwrite  = 0;
            memread   = 0;
            memwrite  = 0;
            branch    = 1;
            aluop     = 2'b01;
            jump      = 0;
        end

        7'b1101111: begin // jal
            alusrc    = 1'bx;
            memtoreg  = 2'b10;
            regwrite  = 1;
            memread   = 0;
            memwrite  = 0;
            branch    = 0;
            aluop     = 2'bxx;
            jump      = 1;
        end

        default: begin
            alusrc    = 0;
            memtoreg  = 2'b00;
            regwrite  = 1;
            memread   = 0;
            memwrite  = 0;
            branch    = 0;
            aluop     = 2'b00;
            jump      = 0;
        end
    endcase
end

endmodule
