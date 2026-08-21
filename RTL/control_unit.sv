`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 16.08.2026 12:15:44
// 
// Module Name: control_unit
//////////////////////////////////////////////////////////////////////////////////


module control_unit (
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,

    output logic       reg_write,
    output logic       alu_src,
    output logic       mem_read,
    output logic       mem_write,
    output logic       branch,
    output logic       jump,
    output logic [2:0] alu_control
);

    always_comb begin

        // Default values
        reg_write  = 1'b0;
        alu_src    = 1'b0;
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        branch     = 1'b0;
        jump       = 1'b0;
        alu_control = 3'b000;

        case (opcode)

            // -------------------------
            // R-Type: ADD, SUB, AND, OR, XOR
            // -------------------------
            7'b0110011: begin
                reg_write = 1'b1;
                alu_src   = 1'b0;

                case (funct3)

                    3'b000: begin
                        if (funct7 == 7'b0100000)
                            alu_control = 3'b001; // SUB
                        else
                            alu_control = 3'b000; // ADD
                    end

                    3'b111: alu_control = 3'b010; // AND
                    3'b110: alu_control = 3'b011; // OR
                    3'b100: alu_control = 3'b100; // XOR

                    default: alu_control = 3'b000;

                endcase
            end

            // -------------------------
            // ADDI
            // -------------------------
            7'b0010011: begin
                reg_write   = 1'b1;
                alu_src     = 1'b1;
                alu_control = 3'b000; // ADD
            end

            // -------------------------
            // LW
            // -------------------------
            7'b0000011: begin
                reg_write   = 1'b1;
                alu_src     = 1'b1;
                mem_read    = 1'b1;
                alu_control = 3'b000; // ADD
            end

            // -------------------------
            // SW
            // -------------------------
            7'b0100011: begin
                alu_src     = 1'b1;
                mem_write   = 1'b1;
                alu_control = 3'b000; // ADD
            end

            // -------------------------
            // BEQ
            // -------------------------
            7'b1100011: begin
                branch      = 1'b1;
                alu_src     = 1'b0;
                alu_control = 3'b001; // SUB
            end

            // -------------------------
            // JAL
            // -------------------------
            7'b1101111: begin
                reg_write   = 1'b1;
                jump        = 1'b1;
            end

            default: begin
                // Keep default control signals
            end

        endcase
    end

endmodule