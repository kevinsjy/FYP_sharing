`timescale 1ns/1ps
module SOC
(
    input wire          clk,
    input wire          rst,
    output wire [15:0] led,
    output wire [6:0]   seg,
    output wire [3:0]   an
);
wire [31:0] output_data_0;

// instantiate processor

TOP_CPU cpu_pipe(
    .clk(clk),
    .rst(rst),
    .led_101100_dubug(output_data_0)
);

assign led = output_data_0[15:0];

seven_segment_display seven_led(
    .clock_100Mhz(clk),
    .reset(rst),
    .data_i(led),
    .Anode_Activate(an),
    .LED_out(seg)
);
endmodule
