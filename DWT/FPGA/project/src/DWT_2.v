module DWT_2 
#(
    parameter w_in   = 9 ,//输入的位宽
    parameter y_out  = 25,//输出的位宽
    parameter c_in   = 9 //系数的位宽
)
(
    input clk,
    input rstn,
    input Lo_D_down_valid,
    input  signed [w_in-1:0]  Lo_D_down_y_k    ,

    output  signed [y_out-1:0]  Hi_D2_c_y_6k  ,
    output  signed [y_out-1:0]  Hi_D2_c_y_6k_1,
    output  signed [y_out-1:0]  Hi_D2_c_y_6k_2,
    output  signed [y_out-1:0]  Hi_D2_c_y_6k_3,
    output  signed [y_out-1:0]  Hi_D2_c_y_6k_4,
    output  signed [y_out-1:0]  Hi_D2_c_y_6k_5,
    output                      Hi_D2_valid,
    // FIR Outputs
    output  signed [y_out-1:0]  Lo_D2_c_y_6k  ,
    output  signed [y_out-1:0]  Lo_D2_c_y_6k_1,
    output  signed [y_out-1:0]  Lo_D2_c_y_6k_2,
    output  signed [y_out-1:0]  Lo_D2_c_y_6k_3,
    output  signed [y_out-1:0]  Lo_D2_c_y_6k_4,
    output  signed [y_out-1:0]  Lo_D2_c_y_6k_5,
    output                      Lo_D2_valid     

);

reg [6:0] Hi_D2_valid_reg;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        Hi_D2_valid_reg<= 0;
    else Hi_D2_valid_reg <= {Hi_D2_valid_reg[5:0],Lo_D_down_valid};
end

assign Hi_D2_valid = Hi_D2_valid_reg[6];
assign Lo_D2_valid = Hi_D2_valid_reg[6];

reg   signed [c_in-1:0]  Hi_D2_c_0=-124;
reg   signed [c_in-1:0]  Hi_D2_c_1=214;
reg   signed [c_in-1:0]  Hi_D2_c_2=-58;
reg   signed [c_in-1:0]  Hi_D2_c_3=-34;

FIR #(
    .w_in  ( w_in  ),
    .y_out ( y_out ),
    .c_in  ( c_in  ))
 u_FIR_D (
    .clk                     ( clk      ),
    .rstn                    ( rstn     ),
    .x_in                    ( Lo_D_down_y_k     ),
    .c_0                     ( Hi_D2_c_0      ),
    .c_1                     ( Hi_D2_c_1      ),
    .c_2                     ( Hi_D2_c_2      ),
    .c_3                     ( Hi_D2_c_3      ),

    .y_6k                    ( Hi_D2_c_y_6k     ),
    .y_6k_1                  ( Hi_D2_c_y_6k_1   ),
    .y_6k_2                  ( Hi_D2_c_y_6k_2   ),
    .y_6k_3                  ( Hi_D2_c_y_6k_3   ),
    .y_6k_4                  ( Hi_D2_c_y_6k_4   ),
    .y_6k_5                  ( Hi_D2_c_y_6k_5   )
);


reg   signed [c_in-1:0]  Lo_D2_c_0=-34;
reg   signed [c_in-1:0]  Lo_D2_c_1=57;
reg   signed [c_in-1:0]  Lo_D2_c_2=214;
reg   signed [c_in-1:0]  Lo_D2_c_3=123;


FIR #(
    .w_in  ( w_in  ),
    .y_out ( y_out ),
    .c_in  ( c_in  ))
 u_FIR_R (
    .clk                     ( clk      ),
    .rstn                    ( rstn     ),
    .x_in                    ( Lo_D_down_y_k     ),
    .c_0                     ( Lo_D2_c_0      ),
    .c_1                     ( Lo_D2_c_1      ),
    .c_2                     ( Lo_D2_c_2      ),
    .c_3                     ( Lo_D2_c_3      ),

    .y_6k                    ( Lo_D2_c_y_6k     ),
    .y_6k_1                  ( Lo_D2_c_y_6k_1   ),
    .y_6k_2                  ( Lo_D2_c_y_6k_2   ),
    .y_6k_3                  ( Lo_D2_c_y_6k_3   ),
    .y_6k_4                  ( Lo_D2_c_y_6k_4   ),
    .y_6k_5                  ( Lo_D2_c_y_6k_5   )
);


endmodule //DWT_2