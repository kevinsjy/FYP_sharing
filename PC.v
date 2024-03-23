`timescale 1ns/1ns
//Program counter
module PC (

    input               clk,
    input               rst,                //reset signal high value
    input      [31:0]   pc_i,
    output reg [31:0]   pc_o

);

    initial begin
        pc_o = 0;
    end

    always@ (*) begin 
        if(rst == 1'b1) 
            pc_o <= 32'b0;
        else 
            pc_o <= pc_i; 

    end
endmodule 





