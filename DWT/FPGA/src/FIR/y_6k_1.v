module y_6k_1 
#
( 
    parameter w_in = 7,//输入的位宽
    parameter y_out = 20,//输出的位宽
    parameter c_in = 5//系数的位宽
)
(
    input clk,
    input rstn,
    input  signed [w_in-1:0] x_6k,
    input  signed [w_in-1:0] x_6k_5,
    input  signed [w_in-1:0] x_6k_4,
    input  signed [w_in-1:0] x_6k_1,
    input  signed [c_in-1:0] c_0,
    input  signed [c_in-1:0] c_1,
    input  signed [c_in-1:0] c_2,
    input  signed [c_in-1:0] c_3,    
    output signed [y_out-1:0] y_6k_1
);
    parameter w_muti_y = 20;//乘法位宽
    parameter w_add_y = 25;//加法位宽

    wire signed [w_muti_y-1:0] muti_3;
    wire signed [w_muti_y-1:0] muti_2;
    wire signed [w_muti_y-1:0] muti_1;
    wire signed [w_muti_y-1:0] muti_0;

    assign muti_3 = x_6k_4 * c_3;
    assign muti_2 = x_6k_5 * c_2;
    assign muti_1 = x_6k * c_1;
    assign muti_0 = x_6k_1 * c_0;

    // wire [w_add_y-1:0] add_2;
    // assign add_2 = muti_3 + muti_2;

    reg signed [w_add_y-1:0] add_2;
    always @(*) begin
        add_2 <= muti_3 + muti_2;
    end    

    reg signed [w_add_y-1:0] add_2_reg; 
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            add_2_reg<= 0;
        else add_2_reg <= add_2;
    end

    // wire [y_out-1:0] add_0;
    // assign add_0 = add_2_reg + muti_0 + muti_1;

    reg signed [y_out-1:0] add_0;
    always @(*) begin
        add_0 <= add_2_reg + muti_0 + muti_1;
    end

    reg signed [y_out-1:0] out_data; 
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            out_data<= 0;
        else out_data <= add_0;
    end
    assign y_6k_1 = out_data;

endmodule //y_6k_1