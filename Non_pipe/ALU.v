module ALU
    `include "definitions.svh"
    #(
        parameter ALU_INSTRUCTION_WIDTH = 4            // 12,13,14,30 bit as representative of choice
    )

    (
       input  wire [ALU_INSTRUCTION_WIDTH-1:0]      ALUCtl,                            
       input  wire [31:0]                           a,
       input  wire [31:0]                           b,
       output reg  [31:0]                           alu_o,
       output reg                                  Zero
    );
    //reg flag;

                      // Conditional branch;;; 
    always @(*) begin 
        case (ALUCtl)
            `ALU_ADD:    alu_o <= a + b;
            `ALU_SUB:   begin
                        alu_o <= a - b;
                        Zero <= ((a - b) == 0) ? 1 : 0;
            end 
            `ALU_NOR:    alu_o <= ~(a | b);             // result is nor
            `ALU_AND:    alu_o <= a & b;
            `ALU_OR:     alu_o <= a | b;
            `ALU_XOR:    alu_o <= a ^ b;
            // shfit
            `ALU_SLL:    alu_o <= a << b[4:0];          // The biggst shift bit is 32, so it only need 5bits 
            `ALU_SRL:    alu_o <= a >> b[4:0];
            `ALU_SRA:    alu_o <= $signed(a) >>> b[4:0];
            // SB-type  bgeu bge and R-type  
            `ALU_SLT:    begin
                         alu_o <= ($signed(a) < $signed(b)) ? 1: 0;         // R-type slt instruction... preven overflow -7>6 Page: A.82 A.24
                         Zero  <=  ($signed(a) < $signed(b)) ? 1: 0;
            end
            
            `ALU_SLTU:   begin
                        alu_o <= (a < b) ? 1 : 0;
                        Zero  <= (a < b) ? 1 : 0;
            end
            // SB-type 
            `ALU_SB_BNE: Zero <= (a != b) ? 1 :0;                  
            `ALU_SB_BGE: Zero <= ($signed(a) >= $signed(b)) ? 1: 0;         //we set alu_o == 0 excute branch order
            `ALU_SB_BGEU:Zero <= (a >= b) ? 1 : 0;

            default:    begin
                        alu_o <= 0;
                        Zero  <= 0;
            end
        endcase 
    end



endmodule 
