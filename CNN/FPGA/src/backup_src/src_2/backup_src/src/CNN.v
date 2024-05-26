module CNN (
    input clk,
    input rstn,
    input [44:0] weight_m_1,//第一列权重
    input [44:0] weight_m_2,
    input [44:0] weight_m_3,
    input [44:0] weight_m_4,
    input [44:0] weight_m_5,

    input [8:0] bias,//偏置
    output  conv_valid,
    output  signed [21:0]  conv_data
);
parameter clk_cnt_max = 7;//采集数据需要7个时钟
wire  valid;
wire  [44:0]  x_m_1;
wire  [44:0]  x_m_2;
wire  [44:0]  x_m_3;
wire  [44:0]  x_m_4;
wire  [44:0]  x_m_5;

reg [3:0] clk_cnt;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        clk_cnt<= 0;
    else if(clk_cnt == clk_cnt_max - 1)
        clk_cnt<= 0;
    else clk_cnt <= clk_cnt + 1;
end

reg clk_valid;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        clk_valid<= 0;
    else if(clk_cnt == clk_cnt_max - 1)
        clk_valid<= 1;
    else clk_valid<= 0;
end

gen_5_5 u_gen_5_5 
(
    .clk                     ( clk_valid     ),
    .clk_orig                (clk      ),
    .rstn                    ( rstn    ),
    .valid                   ( valid   ),
    .x_m_1                   ( x_m_1   ),
    .x_m_2                   ( x_m_2   ),
    .x_m_3                   ( x_m_3   ),
    .x_m_4                   ( x_m_4   ),
    .x_m_5                   ( x_m_5   )
);
// conv Outputs
// wire  conv_valid;
// wire  signed [21:0]  conv_data;

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
    .weight_m_1              ( weight_m_1   ),
    .weight_m_2              ( weight_m_2   ),
    .weight_m_3              ( weight_m_3   ),
    .weight_m_4              ( weight_m_4   ),
    .weight_m_5              ( weight_m_5   ),
    .bias                    ( bias         ),

    .conv_valid              ( conv_valid   ),
    .conv_data               ( conv_data    )
);

endmodule //CNN