// For this project, the aim of processor is two stage
// therefore, there is only Control hazard need to be considered. In other world,
// Pipeline hazards involves Conditional branches.

`include "definitions.svh"

module Hazard_Detec(
    input   wire  [31:0]  instruct_i,
    input   wire  [31:0]  reg1_data_i,
    input   wire  [31:0]  reg2_data_i,
    output  reg           flush      
);

    always @(*)begin
        if(instruct_i[6:0] == `OPCODE_SB_STYLE ) begin
            case(instruct_i[14:12])
                `FUNCT3_BEQ: flush <= (reg1_data_i == reg2_data_i) ? 1 : 0;
                `FUNCT3_BNE: flush <= (reg1_data_i != reg2_data_i) ? 1 : 0;
                `FUNCT3_BLT: flush <= (reg1_data_i < reg2_data_i) ? 1 : 0;
                `FUNCT3_BGE: flush <= (reg1_data_i >= reg2_data_i) ? 1 : 0;
                `FUNCT3_BLTU: flush <= (reg1_data_i < reg2_data_i) ? 1 : 0;
                `FUNCT3_BGEU: flush <= (reg1_data_i >= reg2_data_i) ? 1 : 0;
            
                default: flush <= 0;
            
            endcase 
        end
        else if ((instruct_i[6:0] == `OPCODE_UJ_STYLE) || (instruct_i[6:0] == `OPCODE_IJ_STYLE) ) begin
                flush <= 1;
        end
        else begin 
            flush <= 0;
        
        end
    end

endmodule 