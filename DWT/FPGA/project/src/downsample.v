module downsample 
#(
    parameter y_out  = 25//输出的位宽
)
(
    input clk,
    input rstn,
    input  signed [y_out-1:0]  Hi_D_c_y_6k  ,
    input  signed [y_out-1:0]  Hi_D_c_y_6k_1,
    input  signed [y_out-1:0]  Hi_D_c_y_6k_2,
    input  signed [y_out-1:0]  Hi_D_c_y_6k_3,
    input  signed [y_out-1:0]  Hi_D_c_y_6k_4,
    input  signed [y_out-1:0]  Hi_D_c_y_6k_5,
    input                      Hi_D_valid,
    // FIR Outputs
    input  signed [y_out-1:0]  Lo_D_c_y_6k  ,
    input  signed [y_out-1:0]  Lo_D_c_y_6k_1,
    input  signed [y_out-1:0]  Lo_D_c_y_6k_2,
    input  signed [y_out-1:0]  Lo_D_c_y_6k_3,
    input  signed [y_out-1:0]  Lo_D_c_y_6k_4,
    input  signed [y_out-1:0]  Lo_D_c_y_6k_5,
    input                      Lo_D_valid,   

    output  signed [y_out-1:0]  Hi_D_y_down  ,  
    output Hi_D_down_valid,
    output  signed [y_out-1:0]  Lo_D_y_down  ,
    output Lo_D_down_valid,   
    output down_clk
);
    reg [3:0] cnt;
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            cnt<= 0;
        else if(cnt==5)
            cnt<= 0;
        else if(Hi_D_valid)
            cnt<= cnt + 1;
        else cnt <= cnt;
    end

    reg down_clk_reg;
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            down_clk_reg<= 0;
        else if(!cnt[0]&&Hi_D_valid)
            down_clk_reg<= 1;
        else down_clk_reg<= 0;
    end

    reg  signed [y_out-1:0]  Hi_D_y_down_reg; 
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            Hi_D_y_down_reg<= 0;
        else if((cnt == 0)&&Hi_D_valid)
            Hi_D_y_down_reg<= Hi_D_c_y_6k;
        else if((cnt == 2)&&Hi_D_valid)
            Hi_D_y_down_reg<= Hi_D_c_y_6k_2;
        else if((cnt == 4)&&Hi_D_valid)
            Hi_D_y_down_reg<= Hi_D_c_y_6k_4;
        else  Hi_D_y_down_reg <= Hi_D_y_down_reg;                   
    end

    reg  signed [y_out-1:0]  Lo_D_y_down_reg; 
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            Lo_D_y_down_reg<= 0;
        else if((cnt == 0)&&Hi_D_valid)
            Lo_D_y_down_reg<= Lo_D_c_y_6k;
        else if((cnt == 2)&&Hi_D_valid)
            Lo_D_y_down_reg<= Lo_D_c_y_6k_2;
        else if((cnt == 4)&&Hi_D_valid)
            Lo_D_y_down_reg<= Lo_D_c_y_6k_4;
        else  Lo_D_y_down_reg <= Lo_D_y_down_reg;                   
    end    

    reg valid;
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            valid<= 0;
        else valid <= Hi_D_valid;

    end

    assign down_clk = down_clk_reg;
    assign Hi_D_down_valid = valid;
    assign Lo_D_down_valid = valid;
    assign Hi_D_y_down = Hi_D_y_down_reg;
    assign Lo_D_y_down = Lo_D_y_down_reg;

endmodule //downsample