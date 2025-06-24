module tb_adder(
    output logic [31:0] a, // First output
    output logic [31:0] b, // Second output
    input logic [31:0] sum // input sum
);

adder uut (
    .a(a),
    .b(b),
    .sum(sum)
);
initial begin
    // Initialize inputs
    a = 32'h0000; // Set a to 0
    b = 32'h00000; // Set b to 0
    // Wait for some time
    #10;
    // Test case 1: Add two numbers
    a = 32'h0001; // Set a to 1
    b = 32'h0002; // Set b to 2
    #10; // Wait for the addition to complete
    // End simulation
    $finish;
    end
endmodule