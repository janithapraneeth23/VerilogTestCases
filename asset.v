module arithmetic_DUT (
    input wire [7:0] a,
    input wire [7:0] b,
    output reg [15:0] sum
);

    // Arithmetic operation
    assign sum = a + b;

    // Assertions
    // Assert that the sum is within valid range
    always @* begin
        assert(sum >= 0 && sum <= 255) else $error("Sum out of valid range");
    end

    // Assert that a is not equal to b
    always @* begin
        assert(a != b) else $error("a is equal to b");
    end

    // Assert that a is less than b
    always @* begin
        assert(a < b) else $error("a is not less than b");
    end

endmodule
