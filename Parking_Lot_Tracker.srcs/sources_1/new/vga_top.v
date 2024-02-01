`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  CECS 361 - Fall 2022
// Engineer: Kevin Martinez
//////////////////////////////////////////////////////////////////////////////////

module vga_top
    (
    input wire clk, reset,
    input wire [15:0] sw,
    output wire hsync, vsync,
    output wire [11:0] rgb
    );
    
    // signal declaration
    wire [9:0] pixel_x, pixel_y;
    wire video_on, pixel_tick;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    // instantiate vga sync circuit
    vga_sync vsync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), 
    .video_on(video_on), .p_tick(pixel_tick), .pixel_x(pixel_x), .pixel_y(pixel_y));
    // instantiate graphic generator
    pixel_obj pixel_obj_unit (.video_on(video_on), .pix_x(pixel_x), .sw(sw),
    .pix_y(pixel_y), .graph_rgb(rgb_next));
    // rgb buffer
    always @(posedge clk)
        if (pixel_tick)
            rgb_reg <= rgb_next;
    // output 
    assign rgb = rgb_reg;
endmodule
