`include "definitions.svh"

module IF_ID(
    input               clk,
    input               rst,
    input               flush,
    //data input
    input       [31:0]  pc_i,
    input   wire [31:0]  instruct_in,
    //data output
    output  reg [31:0]  pc_out             ,
    output  reg [31:0]  instruct_out      
);

 localparam NOP = 32'b0000000_00000_00000_000_00000_0110011;

    always @(posedge clk or negedge rst) begin
        if(rst) begin
            pc_out <= 32'd0;        
            instruct_out <= NOP;
        end
        else if(flush == 1'b1) begin
            pc_out <= pc_i -4;           // xx // Due to structure of PC_BRANCH, if nothing happen pc + 4 as dyfault value
            instruct_out <= NOP;
        end
        else begin
            pc_out <= pc_i;
            instruct_out <= instruct_in;
        end
    end

  //  assign  instruct_out = instruct_in;

endmodule