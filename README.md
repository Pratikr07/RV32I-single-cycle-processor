# RV32I Single-Cycle RISC-V Processor

A SystemVerilog implementation of a **32-bit RISC-V RV32I single-cycle processor**, designed and verified using **Xilinx Vivado and XSim**.

The project focuses on understanding the complete processor datapath, instruction decoding, control logic, ALU operations, register operations, immediate generation, memory access, and control-flow instructions.

## Overview

This processor executes RV32I instructions using a **single-cycle datapath**, where each instruction is processed within one clock cycle.

The processor consists of the following major components:

* Program Counter (PC)
* Instruction Memory
* Instruction Decoder / Control Unit
* Register File
* ALU
* Immediate Generator
* Data Memory interface
* Branch and Jump control
* Multiplexers
* Next-PC logic

## Supported Instructions

The processor implements the following RV32I instructions:

### R-Type

* `ADD`
* `SUB`
* `AND`
* `OR`
* `XOR`

### I-Type

* `ADDI`

### Load / Store

* `LW`
* `SW`

### Branch

* `BEQ`

### Jump

* `JAL`

## Processor Datapath

The general instruction flow is:

```text
        ┌──────────────┐
        │     PC       │
        └──────┬───────┘
               │
               ▼
      ┌──────────────────┐
      │ Instruction      │
      │ Memory           │
      └────────┬─────────┘
               │
               ▼
      ┌──────────────────┐
      │ Control Unit     │
      │ + Immediate Gen. │
      └────────┬─────────┘
               │
        ┌──────┴──────┐
        ▼             ▼
 ┌─────────────┐  ┌─────────────┐
 │ Register     │  │ Immediate   │
 │ File         │  │ Generator   │
 └──────┬──────┘  └──────┬──────┘
        │                 │
        └────────┬────────┘
                 ▼
          ┌─────────────┐
          │     ALU     │
          └──────┬──────┘
                 │
          ┌──────┴──────┐
          ▼             ▼
     Data Memory     Write Back
          │             │
          └──────┬──────┘
                 ▼
           Register File
```

## Main Modules

| Module                  | Description                                                  |
| ----------------------- | ------------------------------------------------------------ |
| `riscv_core`            | Top-level processor integration                              |
| `pc`                    | Program counter and sequential instruction execution         |
| `instruction_memory`    | Stores and provides instructions                             |
| `register_file`         | 32 × 32-bit RISC-V register file                             |
| `alu`                   | Performs arithmetic and logical operations                   |
| `control_unit`          | Generates control signals from instruction fields            |
| `imm_gen`               | Generates immediate values for different instruction formats |
| `data_memory`           | Handles load/store data operations                           |
| `mux` / selection logic | Selects datapath inputs                                      |
| Branch/Jump logic       | Determines the next PC for control-flow instructions         |

## Instruction Formats

The processor works with the main RV32I instruction formats required by the implemented instructions:

* R-Type
* I-Type
* S-Type
* B-Type
* J-Type

Instruction fields such as `opcode`, `funct3`, `funct7`, `rs1`, `rs2`, and `rd` are decoded to determine the required operation.

## Verification

The processor was simulated using **Vivado XSim**.

Verification was performed by:

1. Applying reset to the processor.
2. Loading test instructions into instruction memory.
3. Running the processor with a clock signal.
4. Monitoring the program counter and instruction execution.
5. Checking register and ALU operations.
6. Observing control signals and datapath behavior.
7. Inspecting simulation waveforms to verify correct operation.

Example instructions were used to verify arithmetic, logical, immediate, memory, branch, and jump operations.

### Example

For:

```text
ADDI x2, x0, 5
```

the processor:

* Decodes the `ADDI` instruction.
* Reads `x0`.
* Generates the immediate value `5`.
* Performs the ALU addition.
* Writes the result `5` into `x2`.

## Tools Used

* **SystemVerilog / Verilog**
* **Xilinx Vivado**
* **Vivado XSim**
* **Git / GitHub**

## Key Learning Outcomes

Through this project, I gained practical understanding of:

* RISC-V ISA and instruction encoding
* RV32I instruction formats
* Single-cycle CPU architecture
* RTL design and hardware modeling
* Datapath and control-path design
* ALU and register-file integration
* Immediate generation
* Branch and jump logic
* Memory access operations
* SystemVerilog module integration
* RTL simulation and waveform-based verification

## Project Status

**Completed and verified in simulation.**

Future extensions could include:

* Additional RV32I instructions
* More comprehensive test programs
* Improved instruction/data memory
* Pipelined RISC-V architecture
* FPGA implementation
* Formal verification and expanded testbench coverage

## Author

**Pratik Rathod**

B.Tech – Electronics and Communication Technology
Indian Institute of Information Technology Surat
