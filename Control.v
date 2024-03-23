//Control Unite now design for add instruction
`include "definitions.svh"
module Control
    (
        input wire [6:0]    Control_op,
        
        output reg             Branch,
        output reg             MemRead,
        output reg             MemtoReg,
        output reg [1:0]       ALUOp,
        output reg             MemWrite,   
        output reg             ALUSrc,
        output reg             RegWrite,
        output reg             Jal,
        output reg             Jalr
    
    );

    always @(*) begin
        case(Control_op)
        `OPCODE_R_ST: begin                     // ADD AND SUB SLL SLT ... 11 instructions OR 

                        ALUSrc <= 0;
                        MemtoReg <= 0;
                        RegWrite <= 1'b1;
                        MemRead <= 0;
                        MemWrite <= 0;
                        Branch <= 0;
                        ALUOp <= 2'b10;
                        Jal <= 0;
                        Jalr<= 0;              
        end 
        //********************************************** I-style ********************************************
        `OPCODE_LW: begin
                        ALUSrc <= 1'b1;
                        MemtoReg <= 1'b1;
                        RegWrite <= 1'b1;
                        MemRead <= 1'b1;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        ALUOp <= 2'b00;
                        Jal <= 0;
                        Jalr<= 0;      
        end        
        `OPCODE_ADDI: begin                     
                        ALUSrc <= 1'b1;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b1;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        ALUOp <= 2'b11;         // Different from LW 
                        Jal <= 0;
                        Jalr<= 0; 
            
        end          
       //********************************************** S-style ********************************************
        `OPCODE_SW: begin
                        ALUSrc <= 1'b1;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b1;
                        Branch <= 1'b0;
                        ALUOp <= 2'b00;
                        Jal <= 0;
                        Jalr<= 0;   
        end
        //********************************************** SB-style ********************************************
        `OPCODE_BEQ: begin                  
                        ALUSrc <= 1'b0;
                        MemtoReg <= 1'bx;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b1;
                        ALUOp <= 2'b01;
                        Jal <= 0;
                        Jalr<= 0;  
        end 

        `OPCODE_JAL: begin
                        ALUSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b1;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'bX;
                        ALUOp <= 2'bxx;   /// Whatever the ALU result, the value write in register won't be effect because the register value is wrote by PC + 4
                        Jal <= 1;
                        Jalr<= 0;
        end
        `OPCODE_JALR: begin
                        ALUSrc <= 1'b1;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b1;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        ALUOp <= 2'b00;
                        Jal <= 0;
                        Jalr<= 1;
        end
        `OPCODE_LUI: begin
                        ALUSrc <= 1'b1;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b1;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        ALUOp <= 2'b00;
                        Jal <= 0;
                        Jalr<= 0;
        end

        default: begin
                        ALUSrc <= 1'b0;
                        MemtoReg <= 1'b0;
                        RegWrite <= 1'b0;
                        MemRead <= 1'b0;
                        MemWrite <= 1'b0;
                        Branch <= 1'b0;
                        ALUOp <= 2'bxx; 
						Jal <= 0;
                        Jalr<= 0;  
            
        end         // Should not happen
        endcase
    end
endmodule 