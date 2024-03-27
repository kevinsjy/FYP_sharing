

`include "definitions.svh"
module Jal_Jalr_RF
(
    input wire [31:0]   pc_o,
    input wire [31:0]   dm_mux_o,
    input wire          Jal,
    input wire          Jalr,   
    output wire [31:0]  rf_write
);
    assign rf_write = ((Jal ==1) || (Jalr ==1)) ? (pc_o + 4) : dm_mux_o;
endmodule