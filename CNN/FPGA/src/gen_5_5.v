module gen_5_5 (
    input clk,
    input clk_orig,
    input rstn,
    output valid,
    output [44:0] x_m_1,//第一列
    output [44:0] x_m_2,
    output [44:0] x_m_3,
    output [44:0] x_m_4,
    output [44:0] x_m_5
);
parameter CNT_MAX = 164*7 - 2;//采集数据需要7个时钟

reg   [9:0]  address;
wire  [8:0]  q;

IMAGE_ROM  u_IMAGE_ROM (
    .address                 ( address   ),
    .clock                   ( clk     ),

    .q                       ( q         )
);   

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        address<= 0;
    else address <= address + 1;
end


reg   clken;
wire  [44:0]  taps;//=============     move <---------    =============//

CNN_windows  u_CNN_windows (
    .clken                   ( clken      ),
    .clock                   ( clk      ),
    .shiftin                 ( q    ),

    .shiftout                (    ),
    .taps                    ( taps       )
);

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        clken<= 0;
    else clken <= 1;
end

reg [12:0] clken_cnt;
always @(posedge clk_orig or negedge rstn) begin
    if(rstn == 1'b0)
        clken_cnt<= 0;
    else if(clken)
        clken_cnt<= clken_cnt + 1;
    else clken_cnt <= 0;
end

reg valid_reg;
always @(posedge clk_orig or negedge rstn) begin
    if(rstn == 1'b0)
        valid_reg<= 0;
    else if(clken_cnt == CNT_MAX)
        valid_reg<= 1;
    else valid_reg<= valid_reg;
end

reg  [44:0]  taps_1,taps_2,taps_3,taps_4;
always @(posedge clk or negedge rstn) begin
    taps_4 <= taps;
    taps_3 <= taps_4;
    taps_2 <= taps_3;
    taps_1 <= taps_2;
end    

assign x_m_1 = taps_1;
assign x_m_2 = taps_2;
assign x_m_3 = taps_3;
assign x_m_4 = taps_4;
assign x_m_5 = taps;

assign valid = valid_reg;


// wire  [8:0]  x_1_1,x_1_2,x_1_3,x_1_4,x_1_5;//第一行
// wire  [8:0]  x_2_1,x_2_2,x_2_3,x_2_4,x_2_5;
// wire  [8:0]  x_3_1,x_3_2,x_3_3,x_3_4,x_3_5;
// wire  [8:0]  x_4_1,x_4_2,x_4_3,x_4_4,x_4_5;
// wire  [8:0]  x_5_1,x_5_2,x_5_3,x_5_4,x_5_5;

// assign x_5_5 = taps[8:0];
// assign x_4_5 = taps[17:9];
// assign x_3_5 = taps[26:18];
// assign x_2_5 = taps[35:27];
// assign x_1_5 = taps[44:36];

// assign x_5_4 = taps_4[8:0];
// assign x_4_4 = taps_4[17:9];
// assign x_3_4 = taps_4[26:18];
// assign x_2_4 = taps_4[35:27];
// assign x_1_4 = taps_4[44:36];

// assign x_5_3 = taps_3[8:0];
// assign x_4_3 = taps_3[17:9];
// assign x_3_3 = taps_3[26:18];
// assign x_2_3 = taps_3[35:27];
// assign x_1_3 = taps_3[44:36];

// assign x_5_2 = taps_2[8:0];
// assign x_4_2 = taps_2[17:9];
// assign x_3_2 = taps_2[26:18];
// assign x_2_2 = taps_2[35:27];
// assign x_1_2 = taps_2[44:36];

// assign x_5_1 = taps_1[8:0];
// assign x_4_1 = taps_1[17:9];
// assign x_3_1 = taps_1[26:18];
// assign x_2_1 = taps_1[35:27];
// assign x_1_1 = taps_1[44:36];

endmodule //gen_5_5