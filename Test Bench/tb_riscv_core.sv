`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 16.08.2026 16:08:07
//
// Module Name: tb_riscv_core
//////////////////////////////////////////////////////////////////////////////////


module tb_riscv_core;

    logic clk;
    logic reset;

    riscv_core uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        #10;
        reset = 0;

        #150;
        
        $display("========================================");
        $display("       RISC-V CPU FINAL RESULTS");
        $display("========================================");

        $display("x1  = %0d", uut.reg_file.registers[1]);
        $display("x2  = %0d", uut.reg_file.registers[2]);
        $display("x3  = %0d", uut.reg_file.registers[3]);
        $display("x4  = %0d", uut.reg_file.registers[4]);
        $display("x5  = %0d", uut.reg_file.registers[5]);
        $display("x6  = %0d", uut.reg_file.registers[6]);
        $display("x7  = %0d", uut.reg_file.registers[7]);
        $display("x8  = %0d", uut.reg_file.registers[8]);
        $display("x9  = %0d", uut.reg_file.registers[9]);
        $display("x10 = %0d", uut.reg_file.registers[10]);
        $display("x11 = %0d", uut.reg_file.registers[11]);
        $display("x12 = %0d", uut.reg_file.registers[12]);

        $display("----------------------------------------");
        $display("Memory[0] = %0d", uut.data_mem.memory[0]);
        $display("========================================");
        
        $finish;
    end

endmodule
