`timescale 1ns/1ps
module SOC
(
    input wire          clk,
    output wire [15:0] led
);

// instantiate processor

TOP_CPU cpu_signle(
    .clk(clk),
    .rst(),
    .led_101100_dubug(led)
);

endmodule

