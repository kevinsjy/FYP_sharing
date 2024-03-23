// This is Immediate generation logi part
`include "definitions.svh"


module IG(

    input wire [31:0]   ist_o,
    output wire [31:0]  ig_o
    

);  
    assign ig_o = ( ist_o[6:0] ==  `OPCODE_I_STYLE)  ? {{20{ist_o[31]}}, ist_o[31:20]}                                  :  // LOAD instruction belongs to I-style 
                  ( ist_o[6:0] ==  `OPCODE_Ii_STYLE) ? {{20{ist_o[31]}}, ist_o[31:20]}                                  :
                  ( ist_o[6:0] ==  `OPCODE_IJ_STYLE) ? {{20{ist_o[31]}}, ist_o[31:20]}                                  :
                  ( ist_o[6:0] ==  `OPCODE_S_STYLE)  ? {{20{ist_o[31]}}, ist_o[31:25], ist_o[11:7]}                     :   // format from page 274 Fig 4.18   
                  ( ist_o[6:0] ==  `OPCODE_SB_STYLE) ? {{20{ist_o[31]}}, ist_o[7], ist_o[30:25], ist_o[11:8], {1'b0}} :
                  ( ist_o[6:0] ==  `OPCODE_UJ_STYLE) ? {{12{ist_o[31]}}, ist_o[19:12], ist_o[20], ist_o[30:21], {1'b0}} :   //Beq bne instr  belongs to SB SB-style 
                  ( ist_o[6:0] ==  `OPCODE_U_STYLE)  ? {ist_o[31:12],{12{1'b0}}}                                      : 32'h00000000;

endmodule 