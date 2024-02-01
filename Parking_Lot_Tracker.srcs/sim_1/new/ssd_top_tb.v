`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 03:00:52 PM
// Design Name: 
// Module Name: ssd_top_tb
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


module ssd_top_tb();

reg clk_tb;
reg reset_tb;
reg [15:0] sw_tb;
wire [7:0] cathode_tb;
wire [7:0] anode_tb;

ssd_top uut (.clk(clk_tb), .reset(reset_tb), .sw(sw_tb), .cathode(cathode_tb), .anode(anode_tb));

integer x;

always
    #5 clk_tb = ~clk_tb;

initial begin
    clk_tb = 0;
    reset_tb = 1;
    #10
    reset_tb = 0;
    for(x = 0; x < 65536; x = x + 1)begin
        //Q_tb = 1;
        sw_tb = x;
        #50;
    end
    reset_tb = 1;
    $finish;
    
end

endmodule
