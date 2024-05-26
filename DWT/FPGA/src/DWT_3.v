module DWT_3 
#(
    parameter w_in   = 9 ,//输入的位宽
    parameter y_out  = 25,//输出的位宽
    parameter c_in   = 9 //系数的位宽
)
(
    input clk,
    input rstn,
    input Lo_D_up_valid,
    input  signed [w_in-1:0]  Lo_R_up_y_k    ,
    output  signed [y_out-1:0]  Lo_R1_c_y_k  ,
    output                      Lo_R1_valid       
);

reg [4:0] Lo_R1_valid_reg;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        Lo_R1_valid_reg<= 0;
    else Lo_R1_valid_reg <= {Lo_R1_valid_reg[3:0],Lo_D_up_valid};
end

assign Lo_R1_valid = Lo_R1_valid_reg[4];

reg   signed [c_in-1:0]  Lo_R1_c_0=123;
reg   signed [c_in-1:0]  Lo_R1_c_1=214;
reg   signed [c_in-1:0]  Lo_R1_c_2=57;
reg   signed [c_in-1:0]  Lo_R1_c_3=-34;


FIR_src #(
    .w_in     ( w_in  ),
    .y_out    ( y_out ),
    .c_in     ( c_in  )
    )
 u_FIR_src (
    .clk                     ( clk    ),
    .rstn                    ( rstn   ),
    .x_in                    ( Lo_R_up_y_k   ),
    .c_0                     ( Lo_R1_c_0     ),
    .c_1                     ( Lo_R1_c_1     ),
    .c_2                     ( Lo_R1_c_2     ),
    .c_3                     ( Lo_R1_c_3     ),

    .y_k                     ( Lo_R1_c_y_k    )
);

endmodule //DWT_3