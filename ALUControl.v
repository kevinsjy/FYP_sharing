module ALUControl
    `include "definitions.svh"
    (
        input wire [1:0] ALUOp,
        input wire [3:0] FunCode,               // 4bits consist of bit 30,14,13,12 
        output reg [3:0] ALUCtl
    );

    always @(FunCode, ALUOp) begin
        case (ALUOp)
		2'b00:   ALUCtl <= `ALU_ADD;               // lw sw addi jalr ALUOp = 00 
                                		
        //`ALUOP_LW_SW_ADDI:  ALUCtl <= `ALU_ADD;                 
		//`ALUOP_ALU
        //`ALUOP_BEQ:         ALUCtl <= `ALU_SUB;                 
        //`ALUOP_JALR:        ALUCtl <= `ALU_ADD;                 // Jalr register _o + IG	ALUOp = 00
        2'b01:  casex(FunCode)
                4'bx000:    ALUCtl <= `ALU_SUB;         // BEQ
                4'bx001:    ALUCtl <= `ALU_SB_BNE;      // BNE
                4'bx100:    ALUCtl <= `ALU_SLT;         // BLT    
                4'bx101:    ALUCtl <= `ALU_SB_BGE;      // BGE
                4'bx110:    ALUCtl <= `ALU_SLTU;        // BLTU
                4'bx111:    ALUCtl <= `ALU_SB_BGEU;     // BGEU
                default:    ALUCtl <= 4'b1111;
        endcase 
        2'b10:  casex(FunCode)
                4'b0000:    ALUCtl <= `ALU_ADD;     // FUNCode = 0000 add  
                4'b1000:    ALUCtl <= `ALU_SUB;     // FunCode = 1000 sub       ALUop=10 or 11 can not combine toether because it can not handle "sub" instruction in this case
                                                    // what if [30]=1 in the addi instuction the alu will calulate sub not add
                4'b0111:    ALUCtl <= `ALU_AND;     // FUNCode = xxx1 AND
                4'b0110:    ALUCtl <= `ALU_OR;     // FUNCode =       OR
                4'b0100:    ALUCtl <= `ALU_XOR;
                // shift 
                4'b0001:    ALUCtl <= `ALU_SLL;     
                4'b0010:    ALUCtl <= `ALU_SLT;
                4'b0101:    ALUCtl <= `ALU_SRL;
                4'b1101:    ALUCtl <= `ALU_SRA;
                default:    ALUCtl <= 4'b1111;     // should not happen
        endcase
        2'b11:  casex(FunCode)
                4'bx000:    ALUCtl <= `ALU_ADDI;    
                4'b0001:    ALUCtl <= `ALU_SLLI;
                4'bx010:    ALUCtl <= `ALU_SLTI;
                4'bx011:    ALUCtl <= `ALU_SLTIU;
                4'bx100:    ALUCtl <= `ALU_XORI;
                4'b0101:    ALUCtl <= `ALU_SRLI;
                4'b1101:    ALUCtl <= `ALU_SRAI;
                4'bx110:    ALUCtl <= `ALU_ORI;
                4'bx111:    ALUCtl <= `ALU_ANDI;
                default     ALUCtl <= 4'b1111;
        endcase
        default: ALUCtl <= 4'b1111;                // should not happen in reality circuit     For jal jalr ALUOp = 11 so ALUCtl =1111, Then the ALU result = 0
        endcase

    end
endmodule