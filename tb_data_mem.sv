module tb_data_mem(
 output logic clk, // Clock signal
    output logic [31:0] address, // Address to read/write data
    output logic [31:0] write_data, // Data to write (if write enable is high)
    output logic mem_write, // Write enable signal
    output logic  mem_read, // read enable signal
    input logic [31:0] read_data // Data read from memory

);
data_mem dut (
    .clk(clk),
    .address(address),
    .write_data(write_data),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .read_data(read_data)
);
 initial begin
    foreach (dut.memory[i]) begin
        dut.memory[i] = 2*i; // Initialize memory to zero
    end
 end
 initial begin
clk=0;
forever #5 clk = ~clk; // Generate clock signal with a period of 10 time units

 end
 initial begin
    // Test case 1: Write data to memory
    address = 32'h000000; // Address 0
    write_data = 32'h0ABCDEF; // Data to write
    mem_write = 1; // Enable write
    mem_read = 0; // Disable read
    #10; // Wait for a clock cycle

    // Test case 2: Read data from memory
    address = 32'h000; // Address 0
    mem_write = 0; // Disable write
    mem_read = 1; // Enable read
    #10; // Wait for a clock cycle

    // Test case 4: Read from the new address
    address = 32'h000004; // Address 4
    mem_write = 0; // Disable write
    mem_read = 1; // Enable read
    #10; // Wait for a clock cycle
    address = 32'h0008; // Address 8
    mem_write = 0; // Disable write
    mem_read = 1; // Enable read
    #10; // Wait for a clock cycle
    


 end



endmodule