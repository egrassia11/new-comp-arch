module testbench;
    reg clk;                 // Clock signal
    reg reset;               // Reset signal

    cpu cpu1(.clk(clk), .reset(reset));

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
        $display("PC = %h, Instruction = %h", cpu1.pc_out, cpu1.instruction);
    end
endmodule

