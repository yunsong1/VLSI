module CNN (
    input clk,
    input rstn,
    input [1349:0] weights,//5*5*6*9
    input [53:0] bias,//6*9
    output data
);

wire  valid;
wire  [44:0]  x_m_1;
wire  [44:0]  x_m_2;
wire  [44:0]  x_m_3;
wire  [44:0]  x_m_4;
wire  [44:0]  x_m_5;

gen_5_5 u_gen_5_5 
(
    .clk                     ( clk     ),
    .rstn                    ( rstn    ),
    .valid                   ( valid   ),
    .x_m_1                   ( x_m_1   ),
    .x_m_2                   ( x_m_2   ),
    .x_m_3                   ( x_m_3   ),
    .x_m_4                   ( x_m_4   ),
    .x_m_5                   ( x_m_5   )
);

genvar p ;
generate
    for(p=1; p<=4; p=p+1) begin: block//最大4
        conv u_conv 
        (
            .clk                     ( clk          ),
            .rstn                    ( rstn         ),
            .x_valid                 ( valid      ),
            .x_m_1                   ( x_m_1        ),
            .x_m_2                   ( x_m_2        ),
            .x_m_3                   ( x_m_3        ),
            .x_m_4                   ( x_m_4        ),
            .x_m_5                   ( x_m_5        ),
            .weight_m_1              ( weights[225*p-1-45*4 : 225*p-45*5]),
            .weight_m_2              ( weights[225*p-1-45*3 : 225*p-45*4]),
            .weight_m_3              ( weights[225*p-1-45*2 : 225*p-45*3]),
            .weight_m_4              ( weights[225*p-1-45*1 : 225*p-45*2]),
            .weight_m_5              ( weights[225*p-1 : 225*p-45*1]   ),
            .bias                    ( bias[9*p-1 : 9*p-9]         ),       

            .conv_valid              (    ),
            .conv_data               (     )
        );
    end
endgenerate


        // conv u_conv1 
        // (
        //     .clk                     ( clk          ),
        //     .rstn                    ( rstn         ),
        //     .x_valid                 ( valid      ),
        //     .x_m_1                   ( x_m_1        ),
        //     .x_m_2                   ( x_m_2        ),
        //     .x_m_3                   ( x_m_3        ),
        //     .x_m_4                   ( x_m_4        ),
        //     .x_m_5                   ( x_m_5        ),
        //     .weight_m_1              ( weights[225*1-1-45*4 : 225*1-45*5]),
        //     .weight_m_2              ( weights[225*1-1-45*3 : 225*1-45*4]),
        //     .weight_m_3              ( weights[225*1-1-45*2 : 225*1-45*3]),
        //     .weight_m_4              ( weights[225*1-1-45*1 : 225*1-45*2]),
        //     .weight_m_5              ( weights[225*1-1 : 225*1-45*1]   ),
        //     .bias                    ( bias[9*1-1 : 9*1-9]         ),       

        //     .conv_valid              (    ),
        //     .conv_data               (     )
        // );


        // conv u_conv2 
        // (
        //     .clk                     ( clk          ),
        //     .rstn                    ( rstn         ),
        //     .x_valid                 ( valid      ),
        //     .x_m_1                   ( x_m_1        ),
        //     .x_m_2                   ( x_m_2        ),
        //     .x_m_3                   ( x_m_3        ),
        //     .x_m_4                   ( x_m_4        ),
        //     .x_m_5                   ( x_m_5        ),
        //     .weight_m_1              ( weights[225*2-1-45*4 : 225*2-45*5]),
        //     .weight_m_2              ( weights[225*2-1-45*3 : 225*2-45*4]),
        //     .weight_m_3              ( weights[225*2-1-45*2 : 225*2-45*3]),
        //     .weight_m_4              ( weights[225*2-1-45*1 : 225*2-45*2]),
        //     .weight_m_5              ( weights[225*2-1 : 225*2-45*1]   ),
        //     .bias                    ( bias[9*2-1 : 9*2-9]         ),       

        //     .conv_valid              (    ),
        //     .conv_data               (     )
        // );

        // conv u_conv3 
        // (
        //     .clk                     ( clk          ),
        //     .rstn                    ( rstn         ),
        //     .x_valid                 ( valid      ),
        //     .x_m_1                   ( x_m_1        ),
        //     .x_m_2                   ( x_m_2        ),
        //     .x_m_3                   ( x_m_3        ),
        //     .x_m_4                   ( x_m_4        ),
        //     .x_m_5                   ( x_m_5        ),
        //     .weight_m_1              ( weights[225*3-1-45*4 : 225*3-45*5]),
        //     .weight_m_2              ( weights[225*3-1-45*3 : 225*3-45*4]),
        //     .weight_m_3              ( weights[225*3-1-45*2 : 225*3-45*3]),
        //     .weight_m_4              ( weights[225*3-1-45*1 : 225*3-45*2]),
        //     .weight_m_5              ( weights[225*3-1 : 225*3-45*1]   ),
        //     .bias                    ( bias[9*3-1 : 9*3-9]         ),       

        //     .conv_valid              (    ),
        //     .conv_data               (     )
        // );

        // conv u_conv4 
        // (
        //     .clk                     ( clk          ),
        //     .rstn                    ( rstn         ),
        //     .x_valid                 ( valid      ),
        //     .x_m_1                   ( x_m_1        ),
        //     .x_m_2                   ( x_m_2        ),
        //     .x_m_3                   ( x_m_3        ),
        //     .x_m_4                   ( x_m_4        ),
        //     .x_m_5                   ( x_m_5        ),
        //     .weight_m_1              ( weights[225*4-1-45*4 : 225*4-45*5]),
        //     .weight_m_2              ( weights[225*4-1-45*3 : 225*4-45*4]),
        //     .weight_m_3              ( weights[225*4-1-45*2 : 225*4-45*3]),
        //     .weight_m_4              ( weights[225*4-1-45*1 : 225*4-45*2]),
        //     .weight_m_5              ( weights[225*4-1 : 225*4-45*1]   ),
        //     .bias                    ( bias[9*4-1 : 9*4-9]         ),       

        //     .conv_valid              (    ),
        //     .conv_data               (     )
        // );

        // conv u_conv5 
        // (
        //     .clk                     ( clk          ),
        //     .rstn                    ( rstn         ),
        //     .x_valid                 ( valid      ),
        //     .x_m_1                   ( x_m_1        ),
        //     .x_m_2                   ( x_m_2        ),
        //     .x_m_3                   ( x_m_3        ),
        //     .x_m_4                   ( x_m_4        ),
        //     .x_m_5                   ( x_m_5        ),
        //     .weight_m_1              ( weights[225*5-1-45*4 : 225*5-45*5]),
        //     .weight_m_2              ( weights[225*5-1-45*3 : 225*5-45*4]),
        //     .weight_m_3              ( weights[225*5-1-45*2 : 225*5-45*3]),
        //     .weight_m_4              ( weights[225*5-1-45*1 : 225*5-45*2]),
        //     .weight_m_5              ( weights[225*5-1 : 225*5-45*1]   ),
        //     .bias                    ( bias[9*5-1 : 9*5-9]         ),       

        //     .conv_valid              (    ),
        //     .conv_data               (     )
        // );

        // conv u_conv6 
        // (
        //     .clk                     ( clk          ),
        //     .rstn                    ( rstn         ),
        //     .x_valid                 ( valid      ),
        //     .x_m_1                   ( x_m_1        ),
        //     .x_m_2                   ( x_m_2        ),
        //     .x_m_3                   ( x_m_3        ),
        //     .x_m_4                   ( x_m_4        ),
        //     .x_m_5                   ( x_m_5        ),
        //     .weight_m_1              ( weights[225*6-1-45*4 : 225*6-45*5]),
        //     .weight_m_2              ( weights[225*6-1-45*3 : 225*6-45*4]),
        //     .weight_m_3              ( weights[225*6-1-45*2 : 225*6-45*3]),
        //     .weight_m_4              ( weights[225*6-1-45*1 : 225*6-45*2]),
        //     .weight_m_5              ( weights[225*6-1 : 225*6-45*1]   ),
        //     .bias                    ( bias[9*6-1 : 9*6-9]         ),       

        //     .conv_valid              (    ),
        //     .conv_data               (     )
        // );

endmodule //CNN