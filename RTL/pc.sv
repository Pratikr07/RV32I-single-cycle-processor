`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 16.08.2026 11:26:41
//
// Module Name: pc
//////////////////////////////////////////////////////////////////////////////////

module pc (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] pc_next,
    output logic [31:0] pc_current
);

    always_ff @(posedge clk) begin
        if (reset)
            pc_current <= 32'd0;
        else
            pc_current <= pc_next;
    end

endmodule
