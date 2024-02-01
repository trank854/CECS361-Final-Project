`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 04:41:02 PM
// Design Name: 
// Module Name: vga_sync_tb
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


module vga_sync_tb();
reg clk_tb;
reg reset_tb;
wire hsync_tb, vsync_tb, video_on, p_tick;
wire [9:0] pixel_x, pixel_y;

vga_sync uut (.clk(clk_tb), .reset(reset_tb), .hsync(hsync_tb), .vsync(vsync_tb), .video_on(video_on), .p_tick(p_tick), .pixel_x(pixel_x), . pixel_y(pixel_y));

initial begin
    clk_tb = 0;
    reset_tb = 0;
end

always
    #50 clk_tb = ~clk_tb;
endmodule
