// PC Register Module
module pc_register(
    input clk,              // Clock input
    input reset,            // Reset input
    input [31:0] pc_in,     // Input for the next PC value
    output reg [31:0] pc_out // Output of the current PC value
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 32'b0;   // Initialize PC to 0 on reset
        else
            pc_out <= pc_in;    // Update PC with next address on the clock edge
    end
endmodule

// Adder Module
module adder(
    input [31:0] pc,        // Current PC value input
    output [31:0] pc_next   // Output of next PC value (PC + 4)
);
    assign pc_next = pc + 4;    // Increment the PC by 4
endmodule

// Instruction Memory Module
module instruction_memory(
    input [31:0] addr,          // Address input (PC value)
    output [31:0] instruction   // Output fetched instruction
);
    reg [31:0] memory [0:255];  // Memory array to store 256 instructions

    initial begin
        // Load some instructions (RISC-V machine code in hex)
        memory[0] = 32'h00a00093; // addi x1, x0, 10
        memory[1] = 32'h00b00113;  // addi x2, x0, 11
        memory[2] = 32'h00c00193;  // addi x3, x0, 12
    end

    assign instruction = memory[addr[9:2]]; // Fetch instruction (use addr[9:2] as index)
endmodule

// Top Module to connect everything together
module top(
    input clk,                // Clock input
    input reset               // Reset input
);
    wire [31:0] pc_out;       // Current PC value (output from pc_register)
    wire [31:0] pc_next;      // Next PC value (output from adder)
    wire [31:0] instruction;  // Current instruction (output from instruction_memory)

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

    // Instantiate Instruction Memory (fetches instruction based on PC)
    instruction_memory IMEM(
        .addr(pc_out),         // Use current PC value as the address
        .instruction(instruction) // Output instruction fetched from memory
    );

    // Output
    always @(posedge clk) begin
        $display("PC = %h, Instruction = %h", pc_out, instruction); // Display PC and instruction
    end
endmodule
