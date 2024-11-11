module testbench;
    reg clk;                 // Clock signal
    reg reset;               // Reset signal
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

    // Instantiate Instruction Memory
    instruction_memory MEMORY(
        .data_out(instruction),  // Output: instruction data fetched
        .data_in(32'b0),         // Input: No data for writing (instruction fetch only)
        .addr(pc_out),           // Address input: current PC value
        .enable(1'b1),           // Enable memory
        .wr(1'b0),               // Write disabled (fetch-only mode)
        .createdump(1'b0),       // No memory dump
        .clk(clk),               // Clock input
        .rst(reset)              // Reset input
    );
	
	// Instantiate Register File
    register_file RF(
        .clk(clk),
        .reset(reset),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Simulation control
    initial begin
        // Initialize reset
        reset = 1;
        #10 reset = 0;
        #100 $finish;
    end

    // Display PC and instruction values
    always @(posedge clk) begin
        $display("PC = %h, Instruction = %h", pc_out, instruction);
    end
endmodule
