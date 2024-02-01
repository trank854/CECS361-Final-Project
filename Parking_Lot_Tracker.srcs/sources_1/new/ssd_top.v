`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CECS 361 - Fall 2022
// Engineer: Kevin Martinez
//////////////////////////////////////////////////////////////////////////////////

module ssd_top(
    input clk, reset,
    input [15:0] sw,
    output [7:0] cathode,
    output [7:0] anode
    );
    wire [4:0] Q; 
    
    BCD_To_7seg BCD(.Q(Q), .cathode(cathode), .anode(anode));
    Sync_BCD_counter counter(.clk(clk), .reset(reset), .Q(Q), .sw(sw), .anode(anode));   
endmodule
