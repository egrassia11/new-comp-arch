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
