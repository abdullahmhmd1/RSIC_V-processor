module tb_rsic(output logic clk);

    // Instantiate the top module
    rsic uut (
        .clk(clk)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        
        // Wait for a few cycles to stabilize
        uut.pc_inst.pc_value = 64'd0; // Initialize PC to 0 
        for (int i = 0; i < 32; i++) begin
            uut.reg_file_inst.registers[i] = i;  // Initialize instruction memory
        end
    

        uut.inst_mem.instructions[0] = 32'h00a08113; //addi x2,x1,10
        uut.inst_mem.instructions[1] = 32'h00202223;// sw x2,4(x0)
        uut.inst_mem.instructions[2] = 32'h00402183; //lw x3,4(x0)
        uut.inst_mem.instructions[3] = 32'h00208233; //add x4,x1,x2
        uut.inst_mem.instructions[4] = 32'h402082b3;//sub x5,x1,x2
        uut.inst_mem.instructions[5] = 32'h00209333;//sll x6,x1,x2
        uut.inst_mem.instructions[6] = 32'h4020d3b3;//sra x7,x1,x2
        uut.inst_mem.instructions[7] = 32'h0020d433;// srl x8,x1,x2
        uut.inst_mem.instructions[8] = 32'h0020e4b3;//or x9,x1,x2
        uut.inst_mem.instructions[9] = 32'h0020f533;//and x10,x1,x2
        uut.inst_mem.instructions[10] = 32'h0020c5b3;//xor x11,x1,x2
        uut.inst_mem.instructions[11] = 32'h00310263;//beq x2,x3,4
        uut.inst_mem.instructions[12] = 32'h00500613;//addi x12,x0,5
        uut.inst_mem.instructions[13] = 32'h008006ef;//jal x13,8
        uut.inst_mem.instructions[15] = 32'h00500713;//addi x14,x0,5

       


#160;
       for (int i = 0; i < 16; i++) begin
            $display("Instruction %0d: %h", i, uut.inst_mem.instructions[i]);
        end

        // Display final register values
        for (int j = 0; j < 32; j++) begin
            $display("Register %0d: %h", j, uut.reg_file_inst.registers[j]);
        end

        // Display final memory values
      for (int k = 0; k < 16; k ++) begin
            $display("Memory[k]: %h", uut.data_mem_inst.memory[k]);
       end

       
        
    end

endmodule












