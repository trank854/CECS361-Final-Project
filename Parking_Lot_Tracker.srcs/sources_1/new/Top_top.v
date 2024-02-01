`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 01:30:21 PM
// Design Name: 
// Module Name: Top_top
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


module Top_top(
    input clk, reset,
    input [15:0] sw,
    
    //I/O ssd_top
    output [7:0] cathode,
    output [7:0] anode
    );

ssd_top ssd ();
vga_top vga ();
endmodule
