module register_file(
    input clk,                  // Clock input
    input reset,                // Reset input
    input [4:0] read_reg1,      // Register address for first read
    input [4:0] read_reg2,      // Register address for second read
    input [4:0] write_reg,      // Register address for write
    input [31:0] write_data,    // Data to be written to register
    input reg_write,            // Write enable signal
    output [31:0] read_data1,   // Data output of first read
    output [31:0] read_data2    // Data output of second read
);

    // Register array for 32 registers
    reg [31:0] registers [0:31];

    // Read operations
    assign read_data1 = (read_reg1 != 0) ? registers[read_reg1] : 32'b0;
    assign read_data2 = (read_reg2 != 0) ? registers[read_reg2] : 32'b0;

    // Write operation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all registers to 0
            integer i;
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (reg_write && write_reg != 0) begin
            registers[write_reg] <= write_data;
        end
    end
endmodule
