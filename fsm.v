`timescale 1ns / 1ps

module tb_fsm;

    // Inputs
    reg clk;
    reg reset;
    reg start;

    // Outputs
    wire [1:0] state;

    // Instantiate the Unit Under Test (UUT)
    fsm uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .state(state)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;
        start = 0;

        // Wait for global reset to finish
        #100;

        // Testcase 1: Reset FSM
        reset = 1; #10; reset = 0; #10;
        $display("Testcase 1: state=%b", state);

        // Testcase 2: Start FSM from IDLE
        start = 1; #10; start = 0;
        #10; clk = 1; #10; clk = 0; // Toggle clock to move to LOAD state
        $display("Testcase 2: state=%b", state);

        // Testcase 3: Move to DONE state
        #10; clk = 1; #10; clk = 0; // Toggle clock to move to DONE state
        $display("Testcase 3: state=%b", state);

        // Testcase 4: Go back to IDLE state
        #10; clk = 1; #10; clk = 0; // Toggle clock to move to IDLE state
        $display("Testcase 4: state=%b", state);

        // Testcase 5: Ensure FSM stays in IDLE without start signal
        #10; clk = 1; #10; clk = 0;
        $display("Testcase 5: state=%b", state);

        // Testcase 6: Start FSM again
        start = 1; #10; start = 0;
        #10; clk = 1; #10; clk = 0; // Toggle clock to move to LOAD state
        $display("Testcase 6: state=%b", state);

        // Testcase 7: Move to DONE state again
        #10; clk = 1; #10; clk = 0; // Toggle clock to move to DONE state
        $display("Testcase 7: state=%b", state);

        // Finish the simulation
        $finish;
    end

    // Clock generation
    always #5 clk = ~clk;

endmodule

// FSM Module
module fsm (
    input wire clk,         // Clock input
    input wire reset,       // Reset input
    input wire start,       // Start signal
    output reg [1:0] state  // State output
);

    // State encoding
    parameter IDLE = 2'b00, LOAD = 2'b01, DONE = 2'b10;

    // FSM state register
    reg [1:0] current_state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (start)
                    next_state = LOAD;
                else
                    next_state = IDLE;
            end
            LOAD: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        state = current_state;
    end
endmodule
