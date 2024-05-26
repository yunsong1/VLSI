module upsample 
#(
    parameter w_in_1   = 25 ,//输出的位宽
    parameter y_out_2  = 40//输入的位宽
)
(
    input clk,
    input rstn,
    input  Lo_D2_down_valid,
    input  signed [y_out_2-1:0]  Lo_D2_y_down,
    output  signed [w_in_1-1:0]  Lo_D2_y_up  ,  
    output Lo_D2_up_valid,
    output up_clk

);
    assign up_clk =clk;

    reg flag;
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            flag<= 0;
        else if(Lo_D2_down_valid)
            flag<= !flag;
        else flag<= flag;
    end

    wire  signed [w_in_1-1:0]  Lo_D2_data;
    assign Lo_D2_data = {Lo_D2_y_down[y_out_2-1],Lo_D2_y_down[w_in_1-2:0]};

    assign Lo_D2_up_valid = Lo_D2_down_valid;
    assign Lo_D2_y_up = (flag==1) ? 0 :Lo_D2_data;

endmodule //upsample