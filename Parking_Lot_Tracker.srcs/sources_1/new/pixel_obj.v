`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  CECS 361 - Fall 2022
// Engineer: Kevin Martinez
//////////////////////////////////////////////////////////////////////////////////

module pixel_obj
    (
    input wire video_on,
    input wire [9:0] pix_x, pix_y,
    input wire [15:0] sw,
    output reg [11:0] graph_rgb
    ); 
    // constant and signal declaration
    // x, y coordinates (0, 0) to (639, 479)
    localparam MAX_X = 640;
    localparam MAX_Y = 480;
    
    // _______________________________
    // Car object lengths
    // _______________________________
    localparam CAR_X_SIZE = 45;
    localparam CAR_Y_SIZE = 72;
    
    // _______________________________
    // Parking Lot
    // _______________________________
    
    // Top border
    localparam T_BORDER_Y_T = 0;
    localparam T_BORDER_Y_B = 2;
    
    // Bottom border
    localparam B_BORDER_Y_T = MAX_Y - 3;
    localparam B_BORDER_Y_B = MAX_Y - 1;
    
    // Left Border
    localparam L_BORDER_X_L = 0;
    localparam L_BORDER_X_R = 2;
    
    // Right Border with entrance
    localparam R_BORDER_X_L = MAX_X - 3;
    localparam R_BORDER_X_R = MAX_X - 1;
    // Top portion of Right Border
    localparam R_T_BORDER_Y_T = 0;
    localparam R_T_BORDER_Y_B = (MAX_Y / 2) - (CAR_Y_SIZE / 2);
    // Bottom portion of Right Border
    localparam R_B_BORDER_Y_T = (MAX_Y / 2) + (CAR_Y_SIZE / 2);
    localparam R_B_BORDER_Y_B = MAX_Y - 1;
    
    // Parking space
    localparam X_SPACE = 106;
    localparam Y_SPACE = CAR_Y_SIZE + 40;
    // Parking lines [Line #][Top & Left(0) or Bottom & Right(1)]
    localparam T_Line_Y_T = 0;
    localparam T_Line_Y_B = Y_SPACE;
    localparam B_Line_Y_T = MAX_Y - Y_SPACE;
    localparam B_Line_Y_B = MAX_Y - 1;
    
    // _______________________________
    // Car object
    // _______________________________
    // Top & Bottom Car (y pramaters)
    // reuse y paramters for top row cars
    localparam T_CAR_Y_T = T_BORDER_Y_B + 20;
    localparam T_CAR_Y_B = T_CAR_Y_T + CAR_Y_SIZE;
    // reuse y paramters for bottom row cars
    localparam B_CAR_Y_B = B_BORDER_Y_B - 20;
    localparam B_CAR_Y_T = B_CAR_Y_B - CAR_Y_SIZE;
    // Overflow (car 13-16)
    // Custom paramaters
    localparam OF_CAR_Y_T = ((MAX_Y - 1) / 2) - (CAR_X_SIZE / 2);
    localparam OF_CAR_Y_B = ((MAX_Y - 1) / 2) + (CAR_X_SIZE / 2);

    // _______________________________
    // Parking Lot
    // _______________________________
    // Parking lines
    localparam Line_1_X_L = X_SPACE * 1 - 2;
    localparam Line_1_X_R = X_SPACE * 1;
    localparam Line_2_X_L = X_SPACE * 2 - 2;
    localparam Line_2_X_R = X_SPACE * 2;
    localparam Line_3_X_L = X_SPACE * 3 - 2;
    localparam Line_3_X_R = X_SPACE * 3;
    localparam Line_4_X_L = X_SPACE * 4 - 2;
    localparam Line_4_X_R = X_SPACE * 4;
    localparam Line_5_X_L = X_SPACE * 5 - 2;
    localparam Line_5_X_R = X_SPACE * 5;
    
    
    // _______________________________
    // Car object
    // _______________________________
    // Car positions (x paramaters)
    // reuse x paramters for top and bottom row (Car 7-12)
    localparam Car_1_X_L = ((Line_1_X_L + 1) - (X_SPACE / 2)) - (CAR_X_SIZE / 2);
    localparam Car_1_X_R = ((Line_1_X_R - 1) - (X_SPACE / 2)) + (CAR_X_SIZE / 2);
    localparam Car_2_X_L = ((Line_2_X_L + 1) - (X_SPACE / 2)) - (CAR_X_SIZE / 2);
    localparam Car_2_X_R = ((Line_2_X_R - 1) - (X_SPACE / 2)) + (CAR_X_SIZE / 2);
    localparam Car_3_X_L = ((Line_3_X_L + 1) - (X_SPACE / 2)) - (CAR_X_SIZE / 2);
    localparam Car_3_X_R = ((Line_3_X_R - 1) - (X_SPACE / 2)) + (CAR_X_SIZE / 2);
    localparam Car_4_X_L = ((Line_4_X_L + 1) - (X_SPACE / 2)) - (CAR_X_SIZE / 2);
    localparam Car_4_X_R = ((Line_4_X_R - 1) - (X_SPACE / 2)) + (CAR_X_SIZE / 2);
    localparam Car_5_X_L = ((Line_5_X_L + 1) - (X_SPACE / 2)) - (CAR_X_SIZE / 2);
    localparam Car_5_X_R = ((Line_5_X_R - 1) - (X_SPACE / 2)) + (CAR_X_SIZE / 2);
    localparam Car_6_X_L = ((Line_5_X_R - 1) + (X_SPACE / 2)) - (CAR_X_SIZE / 2);
    localparam Car_6_X_R = ((Line_5_X_R - 1) + (X_SPACE / 2)) + (CAR_X_SIZE / 2);
    // Overflow (car 13-16)
    // Custom paramaters
    localparam Car_13_X_L = Line_1_X_R + 20;
    localparam Car_13_X_R = Car_13_X_L + CAR_Y_SIZE;
    localparam Car_14_X_L = Line_2_X_R + 20;
    localparam Car_14_X_R = Car_14_X_L + CAR_Y_SIZE;
    localparam Car_15_X_L = Line_3_X_R + 20;
    localparam Car_15_X_R = Car_15_X_L + CAR_Y_SIZE;
    localparam Car_16_X_L = Line_4_X_R + 20;
    localparam Car_16_X_R = Car_16_X_L + CAR_Y_SIZE;

    wire car_1_on, car_2_on, car_3_on, car_4_on, car_5_on, car_6_on,    // top row
         car_7_on, car_8_on, car_9_on, car_10_on, car_11_on, car_12_on, // bottom row
         car_13_on, car_14_on, car_15_on, car_16_on,                    // Overflow
         lot_on;
    wire [11:0] car_rgb, lot_rgb;
    
    // draw object if pix_x && pix_y do these conditions
    assign car_1_on = (Car_1_X_L <= pix_x) && (pix_x <= Car_1_X_R) && (T_CAR_Y_T <= pix_y) && (pix_y <= T_CAR_Y_B);
    assign car_2_on = (Car_2_X_L <= pix_x) && (pix_x <= Car_2_X_R) && (T_CAR_Y_T <= pix_y) && (pix_y <= T_CAR_Y_B);
    assign car_3_on = (Car_3_X_L <= pix_x) && (pix_x <= Car_3_X_R) && (T_CAR_Y_T <= pix_y) && (pix_y <= T_CAR_Y_B);
    assign car_4_on = (Car_4_X_L <= pix_x) && (pix_x <= Car_4_X_R) && (T_CAR_Y_T <= pix_y) && (pix_y <= T_CAR_Y_B);
    assign car_5_on = (Car_5_X_L <= pix_x) && (pix_x <= Car_5_X_R) && (T_CAR_Y_T <= pix_y) && (pix_y <= T_CAR_Y_B);
    assign car_6_on = (Car_6_X_L <= pix_x) && (pix_x <= Car_6_X_R) && (T_CAR_Y_T <= pix_y) && (pix_y <= T_CAR_Y_B);
    assign car_7_on = (Car_1_X_L <= pix_x) && (pix_x <= Car_1_X_R) && (B_CAR_Y_T <= pix_y) && (pix_y <= B_CAR_Y_B);
    assign car_8_on = (Car_2_X_L <= pix_x) && (pix_x <= Car_2_X_R) && (B_CAR_Y_T <= pix_y) && (pix_y <= B_CAR_Y_B);
    assign car_9_on = (Car_3_X_L <= pix_x) && (pix_x <= Car_3_X_R) && (B_CAR_Y_T <= pix_y) && (pix_y <= B_CAR_Y_B);
    assign car_10_on = (Car_4_X_L <= pix_x) && (pix_x <= Car_4_X_R) && (B_CAR_Y_T <= pix_y) && (pix_y <= B_CAR_Y_B);
    assign car_11_on = (Car_5_X_L <= pix_x) && (pix_x <= Car_5_X_R) && (B_CAR_Y_T <= pix_y) && (pix_y <= B_CAR_Y_B);
    assign car_12_on = (Car_6_X_L <= pix_x) && (pix_x <= Car_6_X_R) && (B_CAR_Y_T <= pix_y) && (pix_y <= B_CAR_Y_B);
    assign car_13_on = (Car_13_X_L <= pix_x) && (pix_x <= Car_13_X_R) && (OF_CAR_Y_T <= pix_y) && (pix_y <= OF_CAR_Y_B);
    assign car_14_on = (Car_14_X_L <= pix_x) && (pix_x <= Car_14_X_R) && (OF_CAR_Y_T <= pix_y) && (pix_y <= OF_CAR_Y_B);
    assign car_15_on = (Car_15_X_L <= pix_x) && (pix_x <= Car_15_X_R) && (OF_CAR_Y_T <= pix_y) && (pix_y <= OF_CAR_Y_B);
    assign car_16_on = (Car_16_X_L <= pix_x) && (pix_x <= Car_16_X_R) && (OF_CAR_Y_T <= pix_y) && (pix_y <= OF_CAR_Y_B);
    assign car_rgb = 12'b000011111111;
    
    assign lot_on = ((T_BORDER_Y_T <= pix_y) && (pix_y <= T_BORDER_Y_B)) ||
    ((B_BORDER_Y_T <= pix_y) && (pix_y <= B_BORDER_Y_B)) ||
    ((L_BORDER_X_L <= pix_x) && (pix_x <= L_BORDER_X_R)) ||
    ((R_BORDER_X_L <= pix_x) && (pix_x <= R_BORDER_X_R) && (R_T_BORDER_Y_T <= pix_y) && (pix_y <= R_T_BORDER_Y_B)) ||
    ((R_BORDER_X_L <= pix_x) && (pix_x <= R_BORDER_X_R) && (R_B_BORDER_Y_T <= pix_y) && (pix_y <= R_B_BORDER_Y_B)) ||
    ((Line_1_X_L <= pix_x) && (pix_x <= Line_1_X_R) && (T_Line_Y_T <= pix_y) && (pix_y <= T_Line_Y_B))  ||
    ((Line_1_X_L <= pix_x) && (pix_x <= Line_1_X_R) && (B_Line_Y_T <= pix_y) && (pix_y <= B_Line_Y_B))  ||
    ((Line_2_X_L <= pix_x) && (pix_x <= Line_2_X_R) && (T_Line_Y_T <= pix_y) && (pix_y <= T_Line_Y_B))  ||
    ((Line_2_X_L <= pix_x) && (pix_x <= Line_2_X_R) && (B_Line_Y_T <= pix_y) && (pix_y <= B_Line_Y_B))  ||
    ((Line_3_X_L <= pix_x) && (pix_x <= Line_3_X_R) && (T_Line_Y_T <= pix_y) && (pix_y <= T_Line_Y_B))  ||
    ((Line_3_X_L <= pix_x) && (pix_x <= Line_3_X_R) && (B_Line_Y_T <= pix_y) && (pix_y <= B_Line_Y_B))  ||
    ((Line_4_X_L <= pix_x) && (pix_x <= Line_4_X_R) && (T_Line_Y_T <= pix_y) && (pix_y <= T_Line_Y_B))  ||
    ((Line_4_X_L <= pix_x) && (pix_x <= Line_4_X_R) && (B_Line_Y_T <= pix_y) && (pix_y <= B_Line_Y_B))  ||
    ((Line_5_X_L <= pix_x) && (pix_x <= Line_5_X_R) && (T_Line_Y_T <= pix_y) && (pix_y <= T_Line_Y_B))  ||
    ((Line_5_X_L <= pix_x) && (pix_x <= Line_5_X_R) && (B_Line_Y_T <= pix_y) && (pix_y <= B_Line_Y_B));
    assign lot_rgb = 12'b111111111111;  // white
    
    wire [0:15] car_arr;
    assign car_arr = {car_1_on, car_2_on, car_3_on, car_4_on, car_5_on, car_6_on,    // top row
             car_7_on, car_8_on, car_9_on, car_10_on, car_11_on, car_12_on, // bottom row
             car_13_on, car_14_on, car_15_on, car_16_on};
     
     wire [4:0] count;
     reg [0:15] count_arr;
    
    integer idx;
    
    // instantiate car counter
    Car_count car_count_unit (.sw(sw), .count(count));
    // _______________________________
    //  rgb multiplexing circuit
    // _______________________________    
    always @*
        if (~video_on)
            graph_rgb = 12'b0;   // blank
        else
        begin
            for (idx = 0; idx < 16; idx = idx + 1)
            begin
                if ((0 < count) && (idx <= count - 1))
                    count_arr[idx] = 1;
                else
                    count_arr[idx] = 0;
            end
            
            if (lot_on)
                graph_rgb = lot_rgb;

            else if (car_1_on || car_2_on || car_3_on || car_4_on || car_5_on || car_6_on ||
                    car_7_on || car_8_on || car_9_on || car_10_on || car_11_on || car_12_on ||
                    car_13_on || car_14_on || car_15_on || car_16_on)
            begin
                    for(idx = 0; idx < 16; idx = idx + 1)
                    begin
                        if (car_arr[idx] && (count_arr[idx] == 1))
                            graph_rgb = car_rgb;
                        else if(car_arr[idx] && (count_arr[idx] == 0))
                            graph_rgb = 12'b0;   // blank
                    end
            end
            
            else
                graph_rgb = 12'b0;   // black background
        end

endmodule
