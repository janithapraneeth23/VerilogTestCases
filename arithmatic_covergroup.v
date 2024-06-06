module arithmetic_DUT;

    // Define a covergroup
    covergroup cg_arithmetic;
        option.per_instance = 1; // Each instance of this covergroup is sampled independently
        
        // Define random variables
        rand integer a;
        rand integer b;
        rand integer result;

        // Define coverpoints for the random variables
        coverpoint a {
            bins bin1 = {0}; // Define a bin
            bins bin2 = {[1:100]}; // Define a bin range
        }
        coverpoint b {
            bins bin1 = {0}; // Define a bin
            bins bin2 = {[1:100]}; // Define a bin range
        }
        coverpoint result {
            bins bin1 = {0}; // Define a bin
            bins bin2 = {[1:200]}; // Define a bin range
        }

        // Cross coverage between a, b, and result
        cross a, b, result;

        // Define a cross coverage with clause
        cross with (result < 100) a, b, result;
        
        // Define a cross coverage with item
        cross with item[result < 100] {a, b, result};

    endgroup

    // Instantiate the covergroup
    cg_arithmetic cg_inst;

    // Generate random values and sample the covergroup
    initial begin
        cg_inst = new;
        repeat (100) begin
            cg_inst.a = $urandom_range(0, 100); // Generate random value for 'a'
            cg_inst.b = $urandom_range(0, 100); // Generate random value for 'b'
            // Perform arithmetic operation (e.g., addition)
            cg_inst.result = cg_inst.a + cg_inst.b;
            cg_inst.sample();
        end
    end

endmodule
