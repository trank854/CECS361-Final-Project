`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 03:41:59 PM
// Design Name: 
// Module Name: Sync_BCD_tb
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


module Sync_BCD_tb();

reg clk_tb;
reg reset_tb;
reg [15:0] sw_tb;
wire [7:0] anode_tb;
wire [4:0] Q_tb;

Sync_BCD_counter uut (.clk(clk_tb), .reset(reset_tb), .sw(sw_tb), .anode(anode_tb), .Q(Q_tb));

//Only testing certain cases
initial begin
    clk_tb = 0;
    reset_tb = 0;
    sw_tb = 12;
    #50;
//    reset_tb = 1;
//    $finish;
end

always
    #100 clk_tb = ~clk_tb;

endmodule
