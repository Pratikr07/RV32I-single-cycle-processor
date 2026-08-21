`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 16.08.2026 15:40:47
//  
// Module Name: data_memory
//////////////////////////////////////////////////////////////////////////////////


module data_memory (
    input  logic        clk,
    input  logic        mem_read,
    input  logic        mem_write,

    input  logic [31:0] address,
    input  logic [31:0] write_data,

    output logic [31:0] read_data
);

    // 256 words × 32 bits
    logic [31:0] memory [0:255];

    // Read
    assign read_data = mem_read ? memory[address[9:2]] : 32'd0;

    // Write
    always_ff @(posedge clk) begin
        if (mem_write)
            memory[address[9:2]] <= write_data;
    end

endmodule
