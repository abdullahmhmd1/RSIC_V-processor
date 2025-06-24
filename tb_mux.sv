module tb_mux(
 output logic [31:0] a, // First output
    output logic [31:0] b, // Second output
    output logic sel, // Select signal
    input logic [31:0] out // Output
);
mux2to1 uut (
    .a(a),
    .b(b),
    .sel(sel),
    .out(out)
);
initial begin
    // Test case 1: sel = 0, expect out = a
    a = 32'h000001; // Set a to 1
    b = 32'h000002; // Set b to 2
    sel = 0; // Select a
    #10; // Wait for 10 time units
    assert(out == a) else $fatal("Test case 1 failed: expected %h, got %h", a, out);
    // Test case 2: sel = 1, expect out = b
    sel = 1; // Select b
    #10; // Wait for 10 time units
    assert(out == b) else $fatal("Test case 2 failed: expected %h, got %h", b, out);
end

endmodule