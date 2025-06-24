module tb_pc(
output logic clk, // Clock signal
    output logic [31:0] next_pc, // Next program counter value
    input logic [31:0] pc_value // Current program counter value
);
initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk; // Toggle clock every 5 time units
    end
end
pc uut (
    .clk(clk),
    .next_pc(next_pc),
    .pc_value(pc_value)
);
initial begin
   
    next_pc = 64'h0000001; // Set next_pc to 1
    #10; // Wait for 10 time units
    next_pc = 64'h0000010; // Set next_pc to 16
    #10; // Wait for 10 time units
    next_pc = 64'h0000100; // Set next_pc to 256
    #100; // Wait for 10 time units
   $finish;
end
endmodule