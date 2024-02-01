`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 03:24:28 PM
// Design Name: 
// Module Name: BCD_tb
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


module BCD_tb();

reg [4:0] Q_tb;
reg [7:0] anode_tb;
wire [7:0] cathode_tb;

BCD_To_7seg uut (.Q(Q_tb), .anode(anode_tb), .cathode(cathode_tb));

integer num;

initial begin
    for(num = 0; num < 32; num = num + 1) begin
        anode_tb = 8'b1111_1110;
        Q_tb[0] = num[0];
        Q_tb[1] = num[1];
        Q_tb[2] = num[2];
        Q_tb[3] = num[3];
        Q_tb[4] = num[4];
        if(Q_tb == num) 
            $display(Q_tb, " passed.");
        else
            $display(Q_tb, " failed.");
        #50;
        anode_tb = 8'b1111_1101;
        #50;
        anode_tb = 8'b1111_1011;
        #50;
        anode_tb = 8'b1111_0111;
        #50;
    end
    
end

endmodule
