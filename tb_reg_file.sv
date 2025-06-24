module tb_reg_file (
    output logic clk, // Clock signal
    output logic [4:0] read_reg1, // Register to read from
    output logic [4:0] read_reg2, // Register to read from
    output logic [4:0] write_reg, // Register to write to
    output logic [31:0] write_data, // Data to write
    output logic regwrite, // Write enable signal
    input logic [31:0] read_data1, // Output data from read_reg1
    input logic [31:0] read_data2 // Output data from read_reg2
);
    reg_file dut (
        .clk(clk),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .regwrite(regwrite),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    initial begin
        clk=0;
        forever begin
            #5 clk = ~clk; // Toggle clock every 5 time units
        end
        
    end
    initial begin 

        foreach (dut.registers[i]) begin
            dut.registers[i] = i;  // Initialize registers with their index value
        end
    end
     initial begin
        // Initialize inputs
        read_reg1 = 5'b00001; // Read from register 1
        read_reg2 = 5'b00010; // Read from register 2
        write_reg = 5'b00011; // Write to register 3
        write_data = 32'h1111; // Data to write
        regwrite = 1; // Enable write

        // Wait for a clock cycle
        #10;

        // Check outputs
        $display("Read Data 1: %h", read_data1);
        $display("Read Data 2: %h", read_data2);

        // Change write_reg and write_data
        write_reg = 5'b00001; // Write to register 1
        write_data = 32'h2222; // New data to write
        read_reg2 = 5'b00011; // Read from register 3


        // Wait for a clock cycle
        #10;

        // Check outputs again
        $display("Read Data 1 after write: %h", read_data1);
     end

    endmodule