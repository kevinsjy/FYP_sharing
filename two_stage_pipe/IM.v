
//Instrution memory
  `include "definitions.svh"

module IM
  

    (
        input wire [31:0] im_rd_ads,        //read address of Instruction memory 
        output wire [31:0] ist              //Instruction memory output 

    );

    reg[31:0] im_size [31:0];                
    

    always @(*) begin
        // right shift 2 bit for matching order  The first PC value is 4, therefore in case statement from 1
        case(im_rd_ads>>2)                  
        // 1:  im_size[0] <= {12'h004,5'h00,`FUNCT3_LW,5'h01,`OPCODE_LW};                   // lw x1, 4(x2)    4 is the offset due to byte address
        // 2:  im_size[1] <= {12'h008,5'h00,`FUNCT3_LW,5'h02,`OPCODE_LW};                   // lw x2, 8(x0)    
        // 3:  im_size[2] <= {`FUNCT7_ADD, 5'h02,5'h01,`FUNCT3_ADD,5'h03,`OPCODE_ADD};      // add x3, x1, x2
        // 4:  im_size[3] <= {12'h002,5'h02,`FUNCT3_ADDI,5'h01,`OPCODE_ADDI};               // addi x1, x2, 2
        // 5:  im_size[4] <= {7'h00,5'h03,5'h01,`FUNCT3_SW,5'h04,`OPCODE_SW};               // sw x3, 4(x1)
        // 6:  im_size[5] <= {`FUNCT7_AND, 5'h03, 5'h01, `FUNCT3_AND, 5'h04, `OPCODE_AND};  // and x4, x1, x3
        // 7:  im_size[6] <= {`FUNCT7_OR, 5'h02, 5'h01, `FUNCT3_OR, 5'h05, `OPCODE_OR};     // or x5, x1, x2
        // 8:  im_size[7] <= {7'h00, 5'h04, 5'h02, `FUNCT3_BEQ,5'b01100,`OPCODE_BEQ};       // beq x2, x4, 12
        // 9:  im_size[8] <= {12'h001,5'h04,`FUNCT3_ADDI,5'h04,`OPCODE_ADDI};               // addi x4, x4, 1
        // 10: im_size[9] <= {20'hff9ff,5'h0b, `OPCODE_JAL};                                // jal x11, -8
        // 11: im_size[10]<= {`FUNCT7_SUB,5'h03,5'h02,`FUNCT3_SUB,5'h06,`OPCODE_SUB};       // sub x6 x2 x3
        // 12: im_size[11]<= {`FUNCT7_XOR,5'h03,5'h02,`FUNCT3_XOR,5'h07,`OPCODE_XOR};       // xor x7 x2 x3
        // 13: im_size[12]<= {20'h12345,5'h08,`OPCODE_LUI};                                 // lui x8 0x12345
        // 14: im_size[13]<= {`FUNCT7_SLL,5'h02,5'h01,`FUNCT3_SLL,5'h09,`OPCODE_SLL};       // sll x9 x1 x2
        // 15: im_size[14]<= {`FUNCT7_SRL,5'h02,5'h01,`FUNCT3_SRL,5'h0a,`OPCODE_SRL};       // srl x10 x1 x2
        // 16: im_size[15]<= {7'h00, 5'h07, 5'h06, `FUNCT3_BGE,5'b10000,`OPCODE_BGE};       // bge x6 x7 16
        // 17: im_size[16]<= {`FUNCT7_ADD, 5'h07,5'h06,`FUNCT3_ADD,5'h06,`OPCODE_ADD};      // add x6 x6 x7
        // 18: im_size[17]<= {`FUNCT7_SLLI,5'h01,5'h0a,`FUNCT3_SLLI,5'h0a,`OPCODE_SLLI};    // slli x10 x10 1
        // 19: im_size[18]<= {12'h014,5'h0b,`FUNCT3_JALR,5'h0d,`OPCODE_JALR};				 // jalr x13 20(x11)
        // 20: im_size[19]<= {32'bx};
         1:  im_size[0] <= 32'h02010113;
         2:  im_size[1] <= 32'h00010413;          
         3:  im_size[2] <= 32'h00178793;
         4:  im_size[3] <= 32'hfef42623;
         5:  im_size[4] <= 32'hfe042223;          
         6:  im_size[5] <= 32'hfe442783;
         7:  im_size[6] <= 32'hfec42703;         
         8:  im_size[7] <= 32'h00e7a023;         
         9:  im_size[8] <= 32'hfec42783;        
         10:  im_size[9] <= 32'h00178793;        
         11:  im_size[10] <= 32'hfef42623;        
         12:  im_size[11] <= 32'hfe042423;       
         13:  im_size[12] <= 32'h010000ef;      
         14:  im_size[13] <= 32'hfe842783;     
         15:  im_size[14] <= 32'h00178793;          
         16:  im_size[15] <= 32'hfef42423;          
         17:  im_size[16] <= 32'hfe842703;          
         18:  im_size[17] <= 32'h000007b7;          
         19:  im_size[18] <= 32'h00578793;  
         20:  im_size[19] <= 32'hfee7d4e3;          
         21:  im_size[20] <= 32'hfc5ff0ef;         
        // // //         1:  im_size[0] <= 32'h01c10113;
        // // // 2:  im_size[1] <= 32'h00010413;          
        // // // 3:  im_size[2] <= 32'h00178793;
        // // // 4:  im_size[3] <= 32'hfef42623;
        // // // 5:  im_size[4] <= 32'hfe042223;          
        // // // 6:  im_size[5] <= 32'hfe442783;
        // // // 7:  im_size[6] <= 32'hfec42703;
        // // // 8:  im_size[7] <= 32'h00070f13;
        // // // 9:  im_size[8] <= 32'h00e7a023;         
        // // // 10:  im_size[9] <= 32'hfec42783;        
        // // // 11:  im_size[10] <= 32'h00178793;        
        // // // 12:  im_size[11] <= 32'hfef42623;        
        // // // 13:  im_size[12] <= 32'hfe042423;       
        // // // 14:  im_size[13] <= 32'h010000ef;      
        // // // 15:  im_size[14] <= 32'hfe842783;     
        // // // 16:  im_size[15] <= 32'h00178793;          
        // // // 17:  im_size[16] <= 32'hfef42423;          
        // // // 18:  im_size[17] <= 32'hfe842703;          
        // // // 19:  im_size[18] <= 32'h000f47b7;          
        // // // 20:  im_size[19] <= 32'h00578793;  
        // // // 21:  im_size[20] <= 32'hfee7d4e3;          
        // // // 22:  im_size[21] <= 32'hfc1ff0ef;    

        default: im_size[(im_rd_ads>>2)-1] <= 32'h00000000;
        endcase 
    end

    assign ist = (im_rd_ads) ? im_size[(im_rd_ads>>2)-1]: 32'h00000000;

endmodule 