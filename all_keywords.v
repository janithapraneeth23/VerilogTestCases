`timescale 1ns / 1ps

module tb_all_lines;

    // Inputs
    reg [3:0] in_data;
    reg [1:0] select;
    reg clk;

    // Outputs
    wire out_data;
    wire reg_out;

    // Instantiate the Unit Under Test (UUT)
    all_verilog_keywords uut (
        .in_data(in_data),
        .select(select),
        .clk(clk),
        .out_data(out_data),
        .reg_out(reg_out)
    );

    initial begin
        // Initialize Inputs
        in_data = 4'b0000;
        select = 2'b00;
        clk = 0;

        // Test all possible input combinations

        // Test input values for each possible case
        for (int i = 0; i < 16; i = i + 1) begin
            in_data = i;
            select = i[1:0];

            // Test case for each clock cycle
            #10;
            clk = ~clk;
        end

        // Additional test cases as needed to cover all lines in the DUT

        // Finish the simulation
        $finish;
    end

    // Clock generation
    always #5 clk = ~clk;

endmodule



module all_verilog_keywords (
    input wire [3:0] in_data,
    input wire [1:0] select,
    input wire clk,
    output reg out_data,
    output reg reg_out
);

    // Verilog Keywords

    // Continuous Assignment
    assign out_data = (select == 2'b00) ? in_data[0] : (select == 2'b01) ? in_data[1] : (select == 2'b10) ? in_data[2] : in_data[3];

    // Blocking Assignment
    always @ (posedge clk) begin
        if (select == 2'b11) begin
            reg_out = in_data[3];
        end else begin
            reg_out <= in_data[2];
        end
    end

    // Nonblocking Assignment
    always @ (posedge clk) begin
        if (select == 2'b00) begin
            out_data <= in_data[0];
        end else if (select == 2'b01) begin
            out_data <= in_data[1];
        end else if (select == 2'b10) begin
            out_data <= in_data[2];
        end else begin
            out_data <= in_data[3];
        end
    end

    // Procedural Continuous Assignment
    always @* begin
        if (select == 2'b00) begin
            reg_out = in_data[0];
        end else if (select == 2'b01) begin
            reg_out = in_data[1];
        end else if (select == 2'b10) begin
            reg_out = in_data[2];
        end else begin
            reg_out = in_data[3];
        end
    end

    // Procedural Blocks
    always @ (posedge clk) begin
        case (select)
            2'b00: out_data = in_data[0];
            2'b01: out_data = in_data[1];
            2'b10: out_data = in_data[2];
            default: out_data = in_data[3];
        endcase
    end

    // Conditional Statement
    always @* begin
        if (in_data[0] && in_data[1])
            out_data = 1'b1;
        else if (in_data[2] || in_data[3])
            out_data = 1'b0;
        else
            out_data = 1'bz;
    end

endmodule
