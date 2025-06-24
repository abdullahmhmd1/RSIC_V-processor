module mux2to1 (
    input logic [31:0] a, // First input
    input logic [31:0] b, // Second input
    input logic sel, // Select signal
    output logic [31:0] out // Output
);
    always @(*) begin
        if (sel) begin
            out = b; // If sel is 1, output b
        end else begin
            out = a; // If sel is 0, output a
        end
    end
    endmodule
