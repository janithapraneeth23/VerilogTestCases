`timescale 1ns / 1ps

// Arithmetic Unit Module
module arithmetic_unit (
    input [3:0] A,        // 4-bit input A
    input [3:0] B,        // 4-bit input B
    input [1:0] CTRL,     // 2-bit control signal
    output reg [3:0] OUT  // 4-bit output
);
    always @(*) begin
        case (CTRL)
            2'b00: OUT = A + B;     // Addition
            2'b01: OUT = A - B;     // Subtraction
            2'b10: OUT = A & B;     // Bitwise AND
            2'b11: OUT = A | B;     // Bitwise OR
            default: OUT = 4'b0000; // Default case (should not occur)
        endcase
    end
endmodule

module tb_arithmetic_unit;

    // Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg [1:0] CTRL;

    // Outputs
    wire [3:0] OUT;

    // Instantiate the Unit Under Test (UUT)
    arithmetic_unit uut (
        .A(A),
        .B(B),
        .CTRL(CTRL),
        .OUT(OUT)
    );

    initial begin
        // Initialize Inputs
        A = 4'b0000;
        B = 4'b0000;
        CTRL = 2'b00;

        // Wait for global reset to finish
        #100;

        // Testcase 1: Addition (CTRL=00)
        A = 4'b0011; B = 4'b0101; CTRL = 2'b00; #10;
        $display("Testcase 1: A=%b, B=%b, CTRL=00, OUT=%b", A, B, OUT);

        // Testcase 2: Subtraction (CTRL=01)
        A = 4'b0110; B = 4'b0010; CTRL = 2'b01; #10;
        $display("Testcase 2: A=%b, B=%b, CTRL=01, OUT=%b", A, B, OUT);

        // Testcase 3: Bitwise AND (CTRL=10)
        A = 4'b1100; B = 4'b1010; CTRL = 2'b10; #10;
        $display("Testcase 3: A=%b, B=%b, CTRL=10, OUT=%b", A, B, OUT);

        // Testcase 4: Bitwise OR (CTRL=11)
        A = 4'b1100; B = 4'b1010; CTRL = 2'b11; #10;
        $display("Testcase 4: A=%b, B=%b, CTRL=11, OUT=%b", A, B, OUT);

        // Finish the simulation
        $finish;
    end

endmodule
