module tb_instruction_mem;

    logic [31:0] pc_value; // Current program counter value
    logic [31:0] instruction; // Output instruction

    // Instantiate the instruction memory module
    instruction_mem im (
        .pc_value(pc_value),
        .instruction(instruction)
    );
    initial begin
        foreach (im.instructions[i]) begin
            im.instructions[i] = 4*i; // Initialize all instructions to zero
        end
    end
    // Testbench stimulus
    initial begin
        pc_value = 32'h00000000; // Start with PC at 0
        
       #10; // Wait for clock to stabilize
        // Change PC value to fetch different instructions
        pc_value = 32'h00000004; // Change PC to 4
        
        #10; // Wait for clock to stabilize
        
        pc_value = 32'h00000008; // Change PC to 8
         #10; // Wait for clock to stabilize
       
      
    end
    endmodule