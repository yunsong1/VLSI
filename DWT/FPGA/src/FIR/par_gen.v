module par_gen 
#(
    parameter w_in = 15
)
(
    input clk,
    input rstn,
    input signed [w_in-1:0] data_in,
    output  valid_wire,
    output  signed [w_in-1:0] data_out_0_wire ,//6k
    output  signed [w_in-1:0] data_out_1_wire ,//6k+1
    output  signed [w_in-1:0] data_out_2_wire ,//6k+2
    output  signed [w_in-1:0] data_out_3_wire ,//6k+3
    output  signed [w_in-1:0] data_out_4_wire ,//6k+4
    output  signed [w_in-1:0] data_out_5_wire  //6k+5
    );
    reg [2:0] clk_cnt;
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            clk_cnt<= 0;
        else if(clk_cnt == 6)
            clk_cnt<= 1;//从1开始而不是0，避免复位结束后0的影响
        else 
            clk_cnt <= clk_cnt + 1;
    end
    reg valid;
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            valid<= 0;
        else if(clk_cnt == 6)//clk
            valid<= 1;
        else valid<= 0;
    end

    reg signed [w_in-1:0] data_out_0 ;
    reg signed [w_in-1:0] data_out_1 ;
    reg signed [w_in-1:0] data_out_2 ;
    reg signed [w_in-1:0] data_out_3 ;
    reg signed [w_in-1:0] data_out_4 ;
    reg signed [w_in-1:0] data_out_5 ;

    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            begin
                data_out_0<= 0;
                data_out_1<= 0;
                data_out_2<= 0;
                data_out_3<= 0;
                data_out_4<= 0;
                data_out_5<= 0;
            end
        else 
            begin
                data_out_5<= data_in;
                data_out_4<= data_out_5;
                data_out_3<= data_out_4;
                data_out_2<= data_out_3;
                data_out_1<= data_out_2;
                data_out_0<= data_out_1;
            end        
    end

    assign data_out_0_wire = data_out_0;
    assign data_out_1_wire = data_out_1;
    assign data_out_2_wire = data_out_2;
    assign data_out_3_wire = data_out_3;
    assign data_out_4_wire = data_out_4;
    assign data_out_5_wire = data_out_5;
    assign valid_wire = valid;
endmodule //par_gen