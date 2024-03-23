
//Registers file 
module RF//(r_rg_1, r_rg_2, w_rg, w_data, data_o1, data_o2);
    `include "definitions.svh"

    #(
      
        parameter REG_DATA_WIDTH      = 32,
        parameter REG_DEPTH           = 32,
        parameter REG_CODE_LENGTH     = 5

    )(
        input wire                              clk,
        input                                   rst,
        input wire                              RegWrite,     // Register wire signal from Control
        input wire [REG_CODE_LENGTH-1:0]        r_rg_1,       // read register 1
        input wire [REG_CODE_LENGTH-1:0]        r_rg_2,       // read register 2
        input wire [REG_CODE_LENGTH-1:0]        w_rg,         // write register
        input wire [REG_DATA_WIDTH-1:0]         w_data,       // write data
        output wire [REG_DATA_WIDTH-1:0]        data_o_1,     // read data output 
        output wire [REG_DATA_WIDTH-1:0]        data_o_2      // read data output
        //output wire [31:0]                      output_x11_debug_led        // debug led for I/O
    );


    reg  [31:0] rgs [REG_DEPTH-1:0];                            // 32 registers each 32 bits long
  
    integer i;

    initial begin
        for ( i = 0; i<=31; i=i+1 ) begin
            rgs[i] =0; 
        end
    end

   // For the two stage pipeline design there is no necessary to consider RAW 
   // Because he decode and execute at the same stage ( the second stage )
    // assign data_o_2 = (r_rg_1 ==0) ? 32'h00000000 :
    //                   ((w_rg == r_rg_1) && RegWrite ) ? w_data : rgs[r_rg_1];     //This is combinational logic 
    //                                                                               // Handle read after write issue, so the value could directly read from write data 
    // assign data_o_2 = (r_rg_2 ==0) ? 32'h00000000 :                               // No need to wait next cycle time make sure read the correct data
    //                   ((w_rg == r_rg_2) && RegWrite ) ? w_data : rgs[r_rg_2]; 

        
    assign data_o_1 = (r_rg_1) ? rgs[r_rg_1] : 32'h00000000;

    assign data_o_2 = (r_rg_2) ? rgs[r_rg_2] : 32'h00000000;

        

    // write the register with new value if RegWrite is high;  The reset update is synchronize with posedge clk
    always @(posedge clk) begin                                 //posedge clk 
        if (rst == 1) begin
            for( i = 0 ; i<=31; i = i+1 ) begin
            rgs[i] <= 0;
        end
        end else if ((RegWrite) && (w_rg != 0)) begin
            rgs[w_rg] <= w_data;                             //
        end    
       // else rgs[w_rg] = rgs[w_rg];

    end 

    //assign output_x11_debug_led = rgs[30];


endmodule

