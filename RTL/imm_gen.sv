`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 16.08.2026 11:39:28
//
// Module Name: imm_gen
//////////////////////////////////////////////////////////////////////////////////


module imm_gen (
    input  logic [31:0] instruction,
    output logic [31:0] imm_out
);

    always_comb begin 
    
        case (instruction[6:0])
        
            // I-Type: ADDI, LW
            7'b0010011,
            7'b0000011: begin
                imm_out = {{20{instruction[31]}},
                           instruction[31:20]};
            end
            
            // S-Type: SW
            7'b0100011: begin
                imm_out = {{20{instruction[31]}},
                           instruction[31:25],
                           instruction[11:7]};
            end
                         
            // B-Type: BEQ
            7'b1100011: begin
                imm_out = {{19{instruction[31]}},
                           instruction[31],
                           instruction[7],
                           instruction[30:25],
                           instruction[11:8],1'b0};
            end
            
            // J-Type: JAL
            7'b1101111: begin
                imm_out = {{12{instruction[31]}},
                           instruction[19:12],
                           instruction[20],
                           instruction[30:21],
                           1'b0};
            end

            // Other instructions
            default: begin
                imm_out = 32'd0;
            end
            
        endcase
        
    end
        
endmodule
