module FIR 
#
( 
    parameter w_in = 7,//输入的位宽
    parameter y_out = 20,//输出的位宽
    parameter c_in = 5//系数的位宽
)
(
    input clk,
    input rstn,
    input signed [w_in-1:0] x_in,
    input signed [c_in-1:0] c_0,
    input signed [c_in-1:0] c_1,
    input signed [c_in-1:0] c_2,
    input signed [c_in-1:0] c_3,     
    output signed [y_out-1:0] y_6k,   
    output signed [y_out-1:0] y_6k_1,
    output signed [y_out-1:0] y_6k_2,
    output signed [y_out-1:0] y_6k_3,
    output signed [y_out-1:0] y_6k_4,
    output signed [y_out-1:0] y_6k_5 
    
);

// par_gen Outputs
wire  fir_clk;
wire  signed [w_in-1:0]  x_6k; 
wire  signed [w_in-1:0]  x_6k_1;
wire  signed [w_in-1:0]  x_6k_2;
wire  signed [w_in-1:0]  x_6k_3;
wire  signed [w_in-1:0]  x_6k_4;
wire  signed [w_in-1:0]  x_6k_5;

par_gen #(
    .w_in  ( w_in )
)
 u_par_gen (
    .clk                     ( clk               ),
    .rstn                    ( rstn              ),
    .data_in                 ( x_in           ),

    .valid_wire              ( fir_clk        ),
    .data_out_0_wire         ( x_6k    ),
    .data_out_1_wire         ( x_6k_1   ),
    .data_out_2_wire         ( x_6k_2   ),
    .data_out_3_wire         ( x_6k_3   ),
    .data_out_4_wire         ( x_6k_4   ),
    .data_out_5_wire         ( x_6k_5   )
);

// FIR_src Outputs
wire  signed [y_out-1:0]  y_k;

FIR_src #(
    .w_in     ( w_in  ),
    .y_out    ( y_out ),
    .c_in     ( c_in  ))
 u_FIR_src (
    .clk                     ( clk    ),
    .rstn                    ( rstn   ),
    .x_in                    ( x_in   ),
    .c_0                     ( c_0    ),
    .c_1                     ( c_1    ),
    .c_2                     ( c_2    ),
    .c_3                     ( c_3    ),
    .y_k                     ( y_k    )
);

y_6k #(
    .w_in     ( w_in  ),
    .y_out    ( y_out ),
    .c_in     ( c_in  ))
 u_y_6k (
    .clk                     ( fir_clk      ),
    .rstn                    ( rstn     ),
    .x_6k                    ( x_6k     ),
    .x_6k_5                  ( x_6k_5   ),
    .x_6k_4                  ( x_6k_4   ),
    .x_6k_3                  ( x_6k_3   ),
    .c_0                     ( c_0      ),
    .c_1                     ( c_1      ),
    .c_2                     ( c_2      ),
    .c_3                     ( c_3      ),
    .y_6k                    ( y_6k     )
);

y_6k_1 #(
    .w_in     ( w_in  ),
    .y_out    ( y_out ),
    .c_in     ( c_in  ))
 u_y_6k_1 (
    .clk                     ( fir_clk      ),
    .rstn                    ( rstn     ),
    .x_6k                    ( x_6k     ),
    .x_6k_5                  ( x_6k_5   ),
    .x_6k_4                  ( x_6k_4   ),
    .x_6k_1                  ( x_6k_1   ),
    .c_0                     ( c_0      ),
    .c_1                     ( c_1      ),
    .c_2                     ( c_2      ),
    .c_3                     ( c_3      ),
    .y_6k_1                  ( y_6k_1   )
);

y_6k_2 #(
    .w_in     ( w_in  ),
    .y_out    ( y_out ),
    .c_in     ( c_in  ))
 u_y_6k_2 (
    .clk                     ( fir_clk      ),
    .rstn                    ( rstn     ),
    .x_6k                    ( x_6k     ),
    .x_6k_5                  ( x_6k_5   ),
    .x_6k_2                  ( x_6k_2   ),
    .x_6k_1                  ( x_6k_1   ),
    .c_0                     ( c_0      ),
    .c_1                     ( c_1      ),
    .c_2                     ( c_2      ),
    .c_3                     ( c_3      ),
    .y_6k_2                  ( y_6k_2   )
);


// y_6k_3 #(
//     .w_in     ( w_in  ),
//     .y_out    ( y_out ),
//     .c_in     ( c_in  ))
//  u_y_6k_3 (
//     .clk                     ( fir_clk      ),
//     .rstn                    ( rstn     ),
//     .x_6k                    ( x_6k     ),
//     .x_6k_3                  ( x_6k_3   ),
//     .x_6k_2                  ( x_6k_2   ),
//     .x_6k_1                  ( x_6k_1   ),
//     .c_0                     ( c_0      ),
//     .c_1                     ( c_1      ),
//     .c_2                     ( c_2      ),
//     .c_3                     ( c_3      ),
//     .y_6k_3                  ( y_6k_3   )
// );

// y_6k_4 #(
//     .w_in     ( w_in  ),
//     .y_out    ( y_out ),
//     .c_in     ( c_in  ))
//  u_y_6k_4 (
//     .clk                     ( fir_clk      ),
//     .rstn                    ( rstn     ),
//     .x_6k_4                  ( x_6k_4   ),
//     .x_6k_3                  ( x_6k_3   ),
//     .x_6k_2                  ( x_6k_2   ),
//     .x_6k_1                  ( x_6k_1   ),
//     .c_0                     ( c_0      ),
//     .c_1                     ( c_1      ),
//     .c_2                     ( c_2      ),
//     .c_3                     ( c_3      ),
//     .y_6k_4                  ( y_6k_4   )
// );

// y_6k_5 #(
//     .w_in     ( w_in  ),
//     .y_out    ( y_out ),
//     .c_in     ( c_in  ))
//  u_y_6k_5 (
//     .clk                     ( fir_clk      ),
//     .rstn                    ( rstn     ),
//     .x_6k_4                  ( x_6k_4   ),
//     .x_6k_3                  ( x_6k_3   ),
//     .x_6k_2                  ( x_6k_2   ),
//     .x_6k_5                  ( x_6k_5   ),
//     .c_0                     ( c_0      ),
//     .c_1                     ( c_1      ),
//     .c_2                     ( c_2      ),
//     .c_3                     ( c_3      ),
//     .y_6k_5                  ( y_6k_5   )
// );

    reg signed [w_in-1:0] x_com [2:0] [3:0];
    wire signed [y_out-1:0] y_com [2:0];

    always @(*) begin
    x_com[0][0] <= x_6k_3; x_com[0][1] <= x_6k_2; x_com[0][2] <= x_6k_1; x_com[0][3] <=x_6k; 
    x_com[1][0] <= x_6k_4; x_com[1][1] <= x_6k_3; x_com[1][2] <= x_6k_2; x_com[1][3] <=x_6k_1; 
    x_com[2][0] <= x_6k_5; x_com[2][1] <= x_6k_4; x_com[2][2] <= x_6k_3; x_com[2][3] <=x_6k_2;         
    end

    // always @(*) begin
    // x_com[0][0] = x_6k_3; x_com[0][1] = x_6k_2; x_com[0][2] = x_6k_1; x_com[0][3] =x_6k; 
    // x_com[1][0] = x_6k_4; x_com[1][1] = x_6k_3; x_com[1][2] = x_6k_2; x_com[1][3] =x_6k_1; 
    // x_com[2][0] = x_6k_5; x_com[2][1] = x_6k_4; x_com[2][2] = x_6k_3; x_com[2][3] =x_6k_2;         
    // end
    
    genvar i ;
    generate
        for(i=0; i<=2; i=i+1) begin: com_gen
            com #(
                .w_in     ( w_in  ),
                .y_out    ( y_out ),
                .c_in     ( c_in  ))
            u_com (
                .clk                     ( fir_clk     ),
                .rstn                    ( rstn    ),
                .x_c0                    ( x_com[i][0]    ),
                .x_c1                    ( x_com[i][1]    ),
                .x_c2                    ( x_com[i][2]    ),
                .x_c3                    ( x_com[i][3]    ),
                .c_0                     ( c_0     ),
                .c_1                     ( c_1     ),
                .c_2                     ( c_2     ),
                .c_3                     ( c_3     ),
                .y_com                   ( y_com[i]   )
            );
        end
    endgenerate

    assign y_6k_3 = y_com[0];
    assign y_6k_4 = y_com[1];
    assign y_6k_5 = y_com[2];

endmodule //FIR