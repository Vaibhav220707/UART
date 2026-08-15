`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2026 00:21:19
// Design Name: 
// Module Name: uart_tb
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

module uart_tb;

reg clk;
reg rst;
reg tx_start;
reg [7:0] din;

wire tx;
wire [7:0] dout;
wire rx_done;
wire baud_tick;


//-----------------------------------------
// CLOCK
//-----------------------------------------
initial begin
    clk = 0;
    forever #10 clk = ~clk;
end


//-----------------------------------------
// BAUD GENERATOR
//-----------------------------------------
baud_rate_gen baud_gen (
    .rst(rst),
    .clk(clk),
    .baud_tick(baud_tick)
);


//-----------------------------------------
// UART TX
//-----------------------------------------
uart_tx transmitter (
    .rst(rst),
    .tx_start(tx_start),
    .baud_tick(baud_tick),
    .clk(clk),
    .din(din),
    .tx(tx)
);


//-----------------------------------------
// UART RX
//-----------------------------------------
uart_rx receiver (
    .rst(rst),
    .rx(tx),              // LOOPBACK
    .baud_tick(baud_tick),
    .clk(clk),
    .dout(dout),
    .rx_done(rx_done)
);


//-----------------------------------------
// TEST
//-----------------------------------------
initial begin

    // Initial values
    rst = 1'b1;
    tx_start = 1'b0;
    din = 8'b0;

    // Reset
    #100;
    rst = 1'b0;

    // Send A5
    #100;
    din = 8'b10100101;
    tx_start = 1'b1;

    #20;
    tx_start = 1'b0;

    // Wait for reception
    wait(rx_done);


    $monitor("Received data = %b", dout);

    #100;

    $finish;

end

endmodule
