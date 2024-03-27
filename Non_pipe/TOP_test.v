`timescale 1ns/1ns
module TOP_test();

    // Generate the clock and reset
    reg clk;
    reg rst;

    TOP_CPU top_pu(.clk(clk), .rst(rst));

    //integer i =0;
 
    //integer k =0;
    
    initial begin       
       
        clk = 0;
        rst = 1'b1;
        #25 rst = 0;
       // i=0;
       // k=0;
        
   
    end

    
    always #10 clk = ~ clk;
   /* always @(posedge clk, rst) begin
               for ( i = 0; i<=31; i= i+1 ) begin

                $display("Register : %0d ; Value: %0d ", i, top_pu.U_rf.rgs[i]);
    
        end

        for ( k = 0; k<20; k= k+1 ) begin

                $display("Data memory : %0d ; Value: %0d ", k, top_pu.U_dm.mem_data[k]);
        
        end
        
    end
    */
  
 



endmodule 