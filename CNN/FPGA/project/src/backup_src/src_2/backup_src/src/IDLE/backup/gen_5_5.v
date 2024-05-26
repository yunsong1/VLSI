module gen_5_5 (
    input clk,
    input rstn,
    output valid,
    output [44:0] x_m_1,//第一列
    output [44:0] x_m_2,
    output [44:0] x_m_3,
    output [44:0] x_m_4,
    output [44:0] x_m_5
);
parameter CNT_MAX = 33;

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

reg [7:0] clken_cnt;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        clken_cnt<= 0;
    else if(clken)
        clken_cnt<= clken_cnt + 1;
    else clken_cnt <= 0;
end

reg valid_reg;
always @(posedge clk or negedge rstn) begin
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
endmodule //gen_5_5