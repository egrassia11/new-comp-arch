module cpu (input clk, input reset);
    wire [31:0] pc_out;      // Current PC value (output from pc_register)
    wire [31:0] pc_next;     // Next PC value (output from adder)
    wire [31:0] instruction; // Current instruction (output from memory2c)

    // Instantiate PC register
    pc_register PC(
        .clk(clk),
        .reset(reset),
        .pc_in(pc_next),       // Next PC value comes from the adder
        .pc_out(pc_out)        // Current PC value is outputted to be used
    );

    // Instantiate Adder (adds 4 to the current PC)
    adder ADD(
        .pc(pc_out),           // Current PC value
        .pc_next(pc_next)      // Output of next PC value (PC + 4)
    );

    // Instantiate memory2c
    memory2c MEMORY(
        .data_out(instruction),  // Output: instruction data fetched
        .data_in(32'b0),         // Input: No data for writing (instruction fetch only)
        .addr(pc_out),           // Address input: current PC value
        .enable(1'b1),           // Enable memory
        .wr(1'b0),               // Write disabled (fetch-only mode)
        .createdump(1'b0),       // No memory dump
        .clk(clk),               // Clock input
        .rst(reset)              // Reset input
    );

endmodule

