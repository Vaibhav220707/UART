`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.08.2026 19:51:00
// Design Name: 
// Module Name: baud_rate_gen
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


module baud_rate_gen(input rst,input clk,output reg baud_tick);
reg [12:0]counter;
always @(posedge clk or posedge rst)begin
if(rst)begin counter<=13'd0;baud_tick<=1'b0;end else
if(counter==13'd5207)begin counter=13'b0;baud_tick=1; end
else begin counter<=counter+1;baud_tick<=1'b0;end
end
endmodule
