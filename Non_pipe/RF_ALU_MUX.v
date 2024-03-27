`include "definitions.svh"
module RF_ALU_MUX

(
        input wire               ALUSrc,
        input wire [31:0]       rf_data,
        input wire [31:0]       ig_data,
        output wire [31:0]       alu_b_i
);

    assign alu_b_i = (ALUSrc == 1) ? ig_data : rf_data;

endmodule 