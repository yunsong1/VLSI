module com 
#
( 
    parameter w_in = 7,//输入的位宽
    parameter y_out = 20,//输出的位宽
    parameter c_in = 5//系数的位宽
)
(
    input clk,
    input rstn,
    input  signed [w_in-1:0] x_c0,
    input  signed [w_in-1:0] x_c1,
    input  signed [w_in-1:0] x_c2,
    input  signed [w_in-1:0] x_c3,
    input  signed [c_in-1:0] c_0,
    input  signed [c_in-1:0] c_1,
    input  signed [c_in-1:0] c_2,
    input  signed [c_in-1:0] c_3,    
    output signed [y_out-1:0] y_com
);
    parameter w_muti_y = 20;//乘法位宽
    parameter w_add_y = 25;//加法位宽

    wire signed [w_muti_y-1:0] muti_3;
    wire signed [w_muti_y-1:0] muti_2;
    wire signed [w_muti_y-1:0] muti_1;
    wire signed [w_muti_y-1:0] muti_0;

    assign muti_3 = x_c3 * c_3;
    assign muti_2 = x_c2 * c_2;
    assign muti_1 = x_c1 * c_1;
    assign muti_0 = x_c0 * c_0;

    wire signed [y_out-1:0] add_0;
    assign add_0 = muti_3 + muti_2 + muti_1 + muti_0;
    reg signed [y_out-1:0] out_data; 
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            out_data<= 0;
        else out_data <= add_0;
    end
    assign y_com = out_data;

endmodule //com