`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.08.2026 19:51:22
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(input rst,input tx_start,input baud_tick,input clk,input [7:0]din,output reg tx);
reg [1:0]state,nextstate;
reg [2:0]bitcounter;
reg [7:0]dout;
parameter idle=2'b00,start=2'b01,data=2'b10,stop=2'b11;
always@(posedge clk)begin
if(rst)state<=idle;
else if(baud_tick)begin 
state<=nextstate; end
end
always@(*)begin//next state logic
case(state)
 idle:begin 
 if(tx_start)nextstate<=start;
 else nextstate<=idle;
 end
 start:begin 
 if(baud_tick)nextstate<=data;
 else nextstate<=start;
 end
 data:begin
  if(baud_tick && bitcounter<=3'd7)nextstate<=stop;
  else nextstate<=data;
  end
 stop:begin 
 if(baud_tick)nextstate<=idle;
 else nextstate<=stop;
 end
 default: nextstate=idle;
 endcase
end
always@(posedge clk)begin //shift logic
if(rst)begin tx=1'b1;dout=8'd0;bitcounter=3'd0;end
else begin
case(state)
idle:begin
 tx=1'b1; if(tx_start)
 dout<=din;bitcounter=3'd0;
 end
start:tx=1'b0;
data: if(baud_tick && bitcounter==3'd7)begin
 tx<=dout[0]; dout<=dout>>1;
 bitcounter=bitcounter+3'd1;
 end
stop:tx=1'b1;
 default: tx=1'b1;
endcase
end
end
endmodule
