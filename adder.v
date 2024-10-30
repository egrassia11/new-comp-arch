module adder(
    input [31:0] pc,        // Current PC value input
    output [31:0] pc_next   // Output of next PC value (PC + 4)
);
    assign pc_next = pc + 4;    // Increment the PC by 4
endmodule
