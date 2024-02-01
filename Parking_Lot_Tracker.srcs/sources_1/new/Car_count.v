`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  CECS 361 - Fall 2022
// Engineer: Kevin Martinez
//////////////////////////////////////////////////////////////////////////////////

module Car_count
    (
    input wire [15:0] sw, // sw = car
    output reg [4:0] count // 16 max cars -> 1 0000
    );
    
    integer temp_count, idx;
    
    always@*
    begin
        temp_count = 0;
        for (idx = 0; idx <= 15; idx = idx + 1) // 16 switches: sw[0] -> sw[15]
        begin
            if (sw[idx] == 1)
                temp_count = temp_count + 1;
        end
        count = temp_count;
    end
endmodule
