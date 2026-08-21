`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 16.08.2026 11:03:48
//
// Module Name: instruction_memory
//////////////////////////////////////////////////////////////////////////////////


module instruction_memory (
    input  logic [31:0] pc,
    output logic [31:0] instruction
);

    // 256 words × 32 bits
    logic [31:0] memory [0:255];

    // Initialize a few instructions for testing
    initial begin

        memory[0]  = 32'h00A00093; // ADDI x1,  x0, 10
        memory[1]  = 32'h00500113; // ADDI x2,  x0, 5

        memory[2]  = 32'h002081B3; // ADD  x3,  x1, x2
        memory[3]  = 32'h40208233; // SUB  x4,  x1, x2
        memory[4]  = 32'h0020F2B3; // AND  x5,  x1, x2
        memory[5]  = 32'h0020E333; // OR   x6,  x1, x2
        memory[6]  = 32'h0020C3B3; // XOR  x7,  x1, x2

        memory[7]  = 32'h00302023; // SW   x3, 0(x0)
        memory[8]  = 32'h00002403; // LW   x8, 0(x0)

        memory[9]  = 32'h00818463; // BEQ  x3, x8, +8
        memory[10] = 32'h06300493; // ADDI x9, x0, 99 -- SHOULD BE SKIPPED
        memory[11] = 32'h00100493; // ADDI x9, x0, 1

        memory[12] = 32'h0080056F; // JAL  x10, +8
        memory[13] = 32'h06300593; // ADDI x11, x0, 99 -- SHOULD BE SKIPPED
        memory[14] = 32'h00C00613; // ADDI x12, x0, 12

        // Remaining memory = NOP
        for (int i = 15; i < 256; i = i + 1)
            memory[i] = 32'h00000013;

    end

    // PC is byte address.
    // Each instruction is 4 bytes, so use PC[9:2].
    assign instruction = memory[pc[9:2]];

endmodule
