module DWT 
#(
    parameter w_in   = 9 ,//输入的位宽
    parameter w_in_1   = 25 ,//输入的位宽
    parameter y_out  = 25,//输出的位宽
    parameter y_out_2  = 40,//输出的位宽
    parameter c_in   = 9 //系数的位宽
)
(
    input clk,
    input rstn
);

// DWT_1 Outputs
wire  signed [y_out-1:0]  Hi_D_c_y_6k;
wire  signed [y_out-1:0]  Hi_D_c_y_6k_1;
wire  signed [y_out-1:0]  Hi_D_c_y_6k_2;
wire  signed [y_out-1:0]  Hi_D_c_y_6k_3;
wire  signed [y_out-1:0]  Hi_D_c_y_6k_4;
wire  signed [y_out-1:0]  Hi_D_c_y_6k_5;
wire  signed Hi_D_valid;
wire  signed [y_out-1:0]  Lo_D_c_y_6k;
wire  signed [y_out-1:0]  Lo_D_c_y_6k_1;
wire  signed [y_out-1:0]  Lo_D_c_y_6k_2;
wire  signed [y_out-1:0]  Lo_D_c_y_6k_3;
wire  signed [y_out-1:0]  Lo_D_c_y_6k_4;
wire  signed [y_out-1:0]  Lo_D_c_y_6k_5;
wire  Lo_D_valid;

DWT_1 #(
    .w_in  ( w_in  ),
    .y_out ( y_out ),
    .c_in  ( c_in  ))
 u_DWT_1 (
    .clk                     ( clk             ),
    .rstn                    ( rstn            ),

    .Hi_D_c_y_6k             ( Hi_D_c_y_6k     ),
    .Hi_D_c_y_6k_1           ( Hi_D_c_y_6k_1   ),
    .Hi_D_c_y_6k_2           ( Hi_D_c_y_6k_2   ),
    .Hi_D_c_y_6k_3           ( Hi_D_c_y_6k_3   ),
    .Hi_D_c_y_6k_4           ( Hi_D_c_y_6k_4   ),
    .Hi_D_c_y_6k_5           ( Hi_D_c_y_6k_5   ),
    .Hi_D_valid              ( Hi_D_valid      ),
    .Lo_D_c_y_6k             ( Lo_D_c_y_6k     ),
    .Lo_D_c_y_6k_1           ( Lo_D_c_y_6k_1   ),
    .Lo_D_c_y_6k_2           ( Lo_D_c_y_6k_2   ),
    .Lo_D_c_y_6k_3           ( Lo_D_c_y_6k_3   ),
    .Lo_D_c_y_6k_4           ( Lo_D_c_y_6k_4   ),
    .Lo_D_c_y_6k_5           ( Lo_D_c_y_6k_5   ),
    .Lo_D_valid              ( Lo_D_valid      )
);

// downsample Outputs
wire  signed [y_out-1:0]  Hi_D_y_down;
wire  Hi_D_down_valid;
wire  signed [y_out-1:0]  Lo_D_y_down;
wire  Lo_D_down_valid;
wire  D_down_clk;

downsample #(
    .y_out ( y_out ))
 u_downsample (
    .clk                     ( clk               ),
    .rstn                    ( rstn              ),
    .Hi_D_c_y_6k             ( Hi_D_c_y_6k       ),
    .Hi_D_c_y_6k_1           ( Hi_D_c_y_6k_1     ),
    .Hi_D_c_y_6k_2           ( Hi_D_c_y_6k_2     ),
    .Hi_D_c_y_6k_3           ( Hi_D_c_y_6k_3     ),
    .Hi_D_c_y_6k_4           ( Hi_D_c_y_6k_4     ),
    .Hi_D_c_y_6k_5           ( Hi_D_c_y_6k_5     ),
    .Hi_D_valid              ( Hi_D_valid        ),
    .Lo_D_c_y_6k             ( Lo_D_c_y_6k       ),
    .Lo_D_c_y_6k_1           ( Lo_D_c_y_6k_1     ),
    .Lo_D_c_y_6k_2           ( Lo_D_c_y_6k_2     ),
    .Lo_D_c_y_6k_3           ( Lo_D_c_y_6k_3     ),
    .Lo_D_c_y_6k_4           ( Lo_D_c_y_6k_4     ),
    .Lo_D_c_y_6k_5           ( Lo_D_c_y_6k_5     ),
    .Lo_D_valid              ( Lo_D_valid        ),

    .Hi_D_y_down             ( Hi_D_y_down       ),
    .Hi_D_down_valid         ( Hi_D_down_valid   ),
    .Lo_D_y_down             ( Lo_D_y_down       ),
    .Lo_D_down_valid         ( Lo_D_down_valid   ),
    .down_clk                ( D_down_clk          )
);

wire  signed [y_out-1:0]  data;
assign data = Lo_D_y_down/256;

// DWT_2 Outputs
wire  signed [y_out_2-1:0]  Hi_D2_c_y_6k;
wire  signed [y_out_2-1:0]  Hi_D2_c_y_6k_1;
wire  signed [y_out_2-1:0]  Hi_D2_c_y_6k_2;
wire  signed [y_out_2-1:0]  Hi_D2_c_y_6k_3;
wire  signed [y_out_2-1:0]  Hi_D2_c_y_6k_4;
wire  signed [y_out_2-1:0]  Hi_D2_c_y_6k_5;
wire   Hi_D2_valid;
wire  signed [y_out_2-1:0]  Lo_D2_c_y_6k;
wire  signed [y_out_2-1:0]  Lo_D2_c_y_6k_1;
wire  signed [y_out_2-1:0]  Lo_D2_c_y_6k_2;
wire  signed [y_out_2-1:0]  Lo_D2_c_y_6k_3;
wire  signed [y_out_2-1:0]  Lo_D2_c_y_6k_4;
wire  signed [y_out_2-1:0]  Lo_D2_c_y_6k_5;
wire  Lo_D2_valid;

DWT_2 #(
    .w_in  ( w_in_1  ),
    .y_out ( y_out_2 ),
    .c_in  ( c_in  ))
 u_DWT_2 (
    .clk                     ( D_down_clk               ),
    .rstn                    ( rstn              ),
    .Lo_D_down_valid         ( Lo_D_down_valid   ),
    .Lo_D_down_y_k           ( data     ),

    .Hi_D2_c_y_6k            ( Hi_D2_c_y_6k      ),
    .Hi_D2_c_y_6k_1          ( Hi_D2_c_y_6k_1    ),
    .Hi_D2_c_y_6k_2          ( Hi_D2_c_y_6k_2    ),
    .Hi_D2_c_y_6k_3          ( Hi_D2_c_y_6k_3    ),
    .Hi_D2_c_y_6k_4          ( Hi_D2_c_y_6k_4    ),
    .Hi_D2_c_y_6k_5          ( Hi_D2_c_y_6k_5    ),
    .Hi_D2_valid             ( Hi_D2_valid       ),
    .Lo_D2_c_y_6k            ( Lo_D2_c_y_6k      ),
    .Lo_D2_c_y_6k_1          ( Lo_D2_c_y_6k_1    ),
    .Lo_D2_c_y_6k_2          ( Lo_D2_c_y_6k_2    ),
    .Lo_D2_c_y_6k_3          ( Lo_D2_c_y_6k_3    ),
    .Lo_D2_c_y_6k_4          ( Lo_D2_c_y_6k_4    ),
    .Lo_D2_c_y_6k_5          ( Lo_D2_c_y_6k_5    ),
    .Lo_D2_valid             ( Lo_D2_valid       )
);



// downsample Outputs
wire  signed [y_out_2-1:0]  Hi_D2_y_down;
wire  Hi_D2_down_valid;
wire  signed [y_out_2-1:0]  Lo_D2_y_down;
wire  Lo_D2_down_valid;
wire  D2_down_clk;

downsample #(
    .y_out ( y_out_2 ))
 u_downsample_2 (
    .clk                     ( D_down_clk               ),
    .rstn                    ( rstn              ),
    .Hi_D_c_y_6k             ( Hi_D2_c_y_6k       ),
    .Hi_D_c_y_6k_1           ( Hi_D2_c_y_6k_1     ),
    .Hi_D_c_y_6k_2           ( Hi_D2_c_y_6k_2     ),
    .Hi_D_c_y_6k_3           ( Hi_D2_c_y_6k_3     ),
    .Hi_D_c_y_6k_4           ( Hi_D2_c_y_6k_4     ),
    .Hi_D_c_y_6k_5           ( Hi_D2_c_y_6k_5     ),
    .Hi_D_valid              ( Hi_D2_valid        ),
    .Lo_D_c_y_6k             ( Lo_D2_c_y_6k       ),
    .Lo_D_c_y_6k_1           ( Lo_D2_c_y_6k_1     ),
    .Lo_D_c_y_6k_2           ( Lo_D2_c_y_6k_2     ),
    .Lo_D_c_y_6k_3           ( Lo_D2_c_y_6k_3     ),
    .Lo_D_c_y_6k_4           ( Lo_D2_c_y_6k_4     ),
    .Lo_D_c_y_6k_5           ( Lo_D2_c_y_6k_5     ),
    .Lo_D_valid              ( Lo_D2_valid        ),

    .Hi_D_y_down             ( Hi_D2_y_down       ),
    .Hi_D_down_valid         ( Hi_D2_down_valid   ),
    .Lo_D_y_down             ( Lo_D2_y_down       ),
    .Lo_D_down_valid         ( Lo_D2_down_valid   ),
    .down_clk                ( D2_down_clk          )
);

wire  signed [y_out_2-1:0]  data2;
assign data2 = Lo_D2_y_down/256;

// upsample Outputs
wire  signed [w_in_1-1:0]  Lo_D2_y_up;
wire  Lo_D2_up_valid;
wire  up_clk;

upsample #(
    .w_in_1  ( w_in_1 ),
    .y_out_2 ( y_out_2 ))
 u_upsample (
    .clk                     ( D_down_clk                ),
    .rstn                    ( rstn               ),
    .Lo_D2_down_valid        ( Lo_D2_down_valid   ),
    .Lo_D2_y_down            ( data2       ),

    .Lo_D2_y_up              ( Lo_D2_y_up         ),
    .Lo_D2_up_valid          ( Lo_D2_up_valid     ),
    .up_clk                  ( up_clk             )
);

// DWT_3 Outputs
wire  signed [y_out_2-1:0]  Lo_R1_c_y_k;
wire  Lo_R1_valid;

DWT_3 #(
    .w_in  ( w_in_1  ),
    .y_out ( y_out_2 ),
    .c_in  ( c_in  ))
 u_DWT_3 (
    .clk                     ( up_clk             ),
    .rstn                    ( rstn            ),
    .Lo_D_up_valid           ( Lo_D2_up_valid   ),
    .Lo_R_up_y_k             ( Lo_D2_y_up     ),

    .Lo_R1_c_y_k             ( Lo_R1_c_y_k     ),
    .Lo_R1_valid             ( Lo_R1_valid     )
);


wire  signed [y_out_2-1:0]  data3;
assign data3 = Lo_R1_c_y_k/256;

// upsample Outputs
wire  signed [w_in_1-1:0]  Lo_R1_y_up;
wire  Lo_R1_up_valid;
wire  up_clk2;

upsample #(
    .w_in_1  ( w_in_1 ),
    .y_out_2 ( y_out_2 ))
 u_upsample2 (
    .clk                     ( clk                ),
    .rstn                    ( rstn               ),
    .Lo_D2_down_valid        ( Lo_R1_valid   ),
    .Lo_D2_y_down            ( data3       ),

    .Lo_D2_y_up              ( Lo_R1_y_up         ),
    .Lo_D2_up_valid          ( Lo_R1_up_valid     ),
    .up_clk                  ( up_clk2             )
);


// DWT_4 Outputs
wire  [y_out_2-1:0]  Lo_R2_c_y_k;
wire  Lo_R2_valid;

DWT_4 #(
    .w_in  ( w_in_1  ),
    .y_out ( y_out_2 ),
    .c_in  ( c_in  ))
 u_DWT_4 (
    .clk                     ( up_clk2             ),
    .rstn                    ( rstn            ),
    .Lo_D_up_valid           ( Lo_R1_up_valid   ),
    .Lo_R_up_y_k             ( Lo_R1_y_up     ),

    .Lo_R1_c_y_k             ( Lo_R2_c_y_k     ),
    .Lo_R1_valid             ( Lo_R2_valid     )
);

wire  signed [y_out_2-1:0]  data4;
assign data4 = Lo_R2_c_y_k/256;

endmodule //DWT