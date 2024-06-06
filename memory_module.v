
`timescale 1ns / 1ps

module tb_memory_module;

    // Inputs
    reg [3:0] addr;
    reg [7:0] data_in;
    reg write_enable;
    reg read_enable;
    reg clk;

    // Outputs
    wire [7:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    memory_module uut (
        .addr(addr),
        .data_in(data_in),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .clk(clk),
        .data_out(data_out)
    );

    initial begin
        // Initialize Inputs
        addr = 4'b0000;
        data_in = 8'b00000000;
        write_enable = 0;
        read_enable = 0;
        clk = 0;

        // Wait for global reset to finish
        #100;

        // Testcase 1: Write and read back
        addr = 4'b0001; data_in = 8'b10101010; write_enable = 1; read_enable = 0; #10;
        clk = 1; #10; clk = 0; #10; // Toggle clock to write data
        write_enable = 0; read_enable = 1; #10;
        clk = 1; #10; clk = 0; #10; // Toggle clock to read data
        $display("Testcase 1: addr=%b, data_out=%b", addr, data_out);

        // Testcase 2: Write and read back different address
        addr = 4'b0010; data_in = 8'b11001100; write_enable = 1; read_enable = 0; #10;
        clk = 1; #10; clk = 0; #10; // Toggle clock to write data
        write_enable = 0; read_enable = 1; #10;
        clk = 1; #10; clk = 0; #10; // Toggle clock to read data
        $display("Testcase 2: addr=%b, data_out=%b", addr, data_out);

        // Testcase 3: Write and read back another address
        addr = 4'b0100; data_in = 8'b11110000; write_enable = 1; read_enable = 0; #10;
        clk = 1; #10; clk = 0; #10; // Toggle clock to write data
        write_enable = 0; read_enable = 1; #10;
        clk = 1; #10; clk = 0; #10; // Toggle clock to read data
        $display("Testcase 3: addr=%b, data_out=%b", addr, data_out);

        // Testcase 4: Write and read back at address 0
        addr = 4'b0000; data_in = 8'b00001111; write_enable = 1; read_enable = 0; #10;
        clk = 1; #10; clk = 0; #10; // Toggle clock to write data
        write_enable = 0; read_enable = 1; #10;
        clk = 1; #10; clk = 0; #10; // Toggle clock to read data
        $display("Testcase 4: addr=%b, data_out=%b", addr, data_out);

        // Testcase 5: No operation
        addr = 4'b0011; data_in = 8'b00000000; write_enable = 0; read_enable = 0; #10;
        clk = 1; #10; clk = 0; #10; // Toggle clock with no operation
        $display("Testcase 5: addr=%b, data_out=%b", addr, data_out);

        // Finish the simulation
        $finish;
    end

    // Clock generation
    always #5 clk = ~clk;

endmodule

// Memory Module
module memory_module (
    input wire [3:0] addr,      // Address input
    input wire [7:0] data_in,   // Data input
    input wire write_enable,    // Write enable signal
    input wire read_enable,     // Read enable signal
    input wire clk,             // Clock signal
    output reg [7:0] data_out   // Data output
);
    reg [7:0] mem_array [15:0]; // Memory array
    integer i;

    always @(posedge clk) begin
        if (write_enable) begin
            mem_array[addr] <= data_in; // Write operation
        end
        if (read_enable) begin
            data_out <= mem_array[addr]; // Read operation
        end
    end

    initial begin
        // Initialize memory array
        for (i = 0; i < 16; i = i + 1) begin
            mem_array[i] = 0;
        end
    end
endmodule
