`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2026 17:31:13
// Design Name: 
// Module Name: uart_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_top(
    input clk,
    input rst,
    input tx_start,
    input [7:0] din,
    input rx,
    output tx,
    output [7:0] dout,
    output rx_done
);
wire baud_tick;
baud_rate_gen baud_gen (
    .rst(rst),
    .clk(clk),
    .baud_tick(baud_tick) );

uart_tx transmitter (
    .rst(rst),
    .tx_start(tx_start),
    .baud_tick(baud_tick),
    .clk(clk),
    .din(din),
    .tx(tx) );
uart_rx receiver (
    .rst(rst),
    .rx(rx),
    .baud_tick(baud_tick),
    .clk(clk),
    .dout(dout),
    .rx_done(rx_done) );
endmodule
