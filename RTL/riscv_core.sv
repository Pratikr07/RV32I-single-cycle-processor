`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 16.08.2026 15:52:18
// Module Name: riscv_core
// Project Name: RISC V ARCHITECTURE
// 
//////////////////////////////////////////////////////////////////////////////////


module riscv_core (
    input logic clk,
    input logic reset
);

    // -------------------------
    // PC signals
    // -------------------------
    logic [31:0] pc_current;
    logic [31:0] pc_next;

    // -------------------------
    // Instruction Memory
    // -------------------------
    logic [31:0] instruction;

    // -------------------------
    // Register File
    // -------------------------    
    logic [31:0] read_data1;
    logic [31:0] read_data2;
    
    
    // -------------------------
    // ALU
    // -------------------------
    logic [31:0] alu_result;
    logic        zero;

    // -------------------------
    // Data Memory
    // -------------------------
    logic [31:0] memory_read_data;

    // -------------------------
    // Write-back
    // -------------------------
    logic [31:0] write_back_data;

    // -------------------------
    // Control Unit signals
    // -------------------------
    logic       reg_write;
    logic       alu_src;
    logic       mem_read;
    logic       mem_write;
    logic       branch;
    logic       jump;
    logic [2:0] alu_control;

    // Immediate
    logic [31:0] immediate;

    // ALU second input
    logic [31:0] alu_input2;
    
    // -------------------------
    // PC
    // -------------------------
    pc pc_unit (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_current(pc_current)
    );

    // -------------------------
    // Instruction Memory
    // -------------------------
    instruction_memory imem (
        .pc(pc_current),
        .instruction(instruction)
    );

    // -------------------------
    // Register File
    // -------------------------
    regfile reg_file (
        .clk(clk),
        .reset(reset),

        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),

        .write_data(write_back_data),
        .reg_write(reg_write),

        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    
    // -------------------------
    // ALU input MUX
    // -------------------------
    assign alu_input2 = alu_src ? immediate : read_data2;

    // -------------------------
    // ALU
    // -------------------------
    alu alu_unit (
        .a(read_data1),
        .b(alu_input2),
        .alu_control(alu_control),

        .result(alu_result),
        .zero(zero)
    );
    
    // -------------------------
    // Data Memory
    // -------------------------
    data_memory data_mem (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),

        .address(alu_result),
        .write_data(read_data2),

        .read_data(memory_read_data)
    );
    
    // -------------------------
    // Control Unit
    // -------------------------
    control_unit control_unit (
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),

        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump),
        .alu_control(alu_control)
    );
    
    // -------------------------
    // Immediate Generator
    // -------------------------
    imm_gen imm_gen_unit (
        .instruction(instruction),
        .imm_out(immediate)
    );
    
    // -------------------------
    // Write-back MUX
    // -------------------------
    
    assign pc_next = jump ? pc_current + immediate :
                 (branch && zero) ? pc_current + immediate :
                 pc_current + 32'd4;
    
    logic [31:0] pc_plus_4;

    assign pc_plus_4 = pc_current + 32'd4;
    
    assign write_back_data = jump ? pc_plus_4 :
                         mem_read ? memory_read_data :
                         alu_result;

endmodule
