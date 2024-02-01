`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CECS 301 - Spring 2022
// Engineer: Kevin Martinez
//////////////////////////////////////////////////////////////////////////////////

module Sync_BCD_counter(
    input clk, reset,
    input [15:0] sw,
    output reg [7:0] anode,
    output reg [4:0] Q
    );
    reg [26:0] tick; //What size?
    reg [4:0] count;
    integer temp_count, idx;
    
    always@(posedge clk, posedge reset) 
    begin
        temp_count = 0;
        for (idx = 0; idx <= 15; idx = idx + 1)
        begin
            if (sw[idx] == 1)
                temp_count = temp_count + 1;
        end
        count = temp_count;
        
        if(reset) 
        begin
            tick <= 27'b0;
            Q <= 5'b0;
        end
        
        else if (tick == 20000)
        begin
            anode = 8'b1111_0111;
            Q = count;
        end
        
        else if (tick == 40000)
        begin
            anode = 8'b1111_1011;
            Q = count;
        end
        
        else if(tick == 80000)
        begin 
            anode = 8'b1111_1101;
            Q = count;
        end
        
        else if(tick == 160000)
        begin
            tick = 27'b0; //Reset the tick
            anode = 8'b1111_1110;
            Q = count;
        end
        
        tick = tick + 1'b1;
    end
endmodule