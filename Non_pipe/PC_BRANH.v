`include "definitions.svh"


module PC_BRANCH
(
    input wire [31:0]   pc_o,
    input wire [31:0]   ig_o,
    input wire [31:0]   alu_o,
    input wire          Branch,
    input wire          Zero,
    input wire          Jal,
    input wire          Jalr,
    output wire [31:0]  pc_new
);
    assign pc_new = (Zero && Branch ) ? (pc_o + ig_o)   :
                    (Jal == 1)        ? (pc_o + ig_o)   :
                    (Jalr == 1)       ? (alu_o)         : (pc_o + 4);
   
endmodule 
