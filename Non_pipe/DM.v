// Data memory
module DM
    (
        input               clk,
        input               rst,
        input               MemWrite,
        input               MemRead,
        input wire [31:0]   w_addr_i,
        input wire [31:0]   w_data_i,
        output wire [31:0]   r_data_o
    );
    
    reg [31:0]mem_data [255:0];                 // Supposing the numbers of 32bit data is 2^8 = 255 

    integer i;

    assign r_data_o = (MemRead) ? mem_data[w_addr_i>>2] : 32'b0;

    always @(posedge clk) begin 
        if (rst==1) begin                              // initialling the numbers of Data memory 20 is 20  
            for(i = 0; i< 256; i = i+1 ) begin
            mem_data [i] <= i;
            end
        end else if (MemWrite)  begin
            mem_data[w_addr_i>>2] <= w_data_i;
        end

    end
    
endmodule 

