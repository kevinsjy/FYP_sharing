// Write Data back to register file
module WB(
    input               MemtoReg,
    input [31:0]        memory_data,
    input [31:0]        alu_data,
    output reg [31:0]   write_data_o
);

    always @(*) begin
        case(MemtoReg)
        1'b1:       write_data_o <= memory_data;
        1'b0:       write_data_o <= alu_data;
        default:    write_data_o <= 32'b0;
        endcase
    end
endmodule 
    

