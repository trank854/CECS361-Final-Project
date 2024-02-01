`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CECS 361 - Fall 2022
// Engineer: Kevin Martinez
//////////////////////////////////////////////////////////////////////////////////

module BCD_To_7seg(
    input [4:0] Q,
    output reg [7:0] cathode,
    input wire [7:0] anode
    );
    reg [7:0] list_0_9 [0:9];
    integer tenths;
    
    always@(*) 
    begin
        list_0_9 [0] <= 8'b00000011;
        list_0_9 [1] <= 8'b10011111;
        list_0_9 [2] <= 8'b00100101;
        list_0_9 [3] <= 8'b00001101; 
        list_0_9 [4] <= 8'b10011001; 
        list_0_9 [5] <= 8'b01001001; 
        list_0_9 [6] <= 8'b01000001; 
        list_0_9 [7] <= 8'b00011111; 
        list_0_9 [8] <= 8'b00000001; 
        list_0_9 [9] <= 8'b00001001;
        
        tenths = Q / 10;
        
        if (Q <= 9)
        begin
            if (anode == 8'b1111_1101)
                cathode = list_0_9[tenths];
                
            else if (anode == 8'b1111_1110)
                cathode = list_0_9[Q];
            
            else
                cathode = 8'b11111111;
        end
        
        else if ((10 <= Q) && (Q <= 11))
        begin
            if (anode == 8'b1111_1101)
                cathode = list_0_9[tenths];
            
            else if (anode == 8'b1111_1110)
                cathode = list_0_9[(Q % 10)];
                
            else
                cathode = 8'b11111111;
        end
        
        else    // Q >= 12
            if (anode == 8'b1111_0111)
                cathode = 8'b01110001;  // F
            else if (anode == 8'b1111_1011)
                cathode = 8'b10000011;  // U
            else if ((anode == 8'b1111_1110) || (anode == 8'b1111_1101))
                cathode = 8'b11100011; // LL
    end
endmodule
