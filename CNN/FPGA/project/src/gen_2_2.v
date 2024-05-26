module gen_2_2 (
    input clk,
    input rstn,
    input  relu_valid,
    input  signed [21:0]  relu_data,  
    output  gen_2_2_valid,
    output [43:0] x_m_1,//第一列
    output [43:0] x_m_2
);
parameter reludata_num = 28;

reg   rdreq;
wire  [21:0]  q;

Pool_fifo  u_Pool_fifo (
    .aclr                    ( !rstn    ),//高电平有效
    .clock                   ( clk   ),
    .data                    ( relu_data    ),
    .rdreq                   ( rdreq   ),
    .wrreq                   ( relu_valid   ),

    .empty                   (    ),
    .full                    (     ),
    .q                       ( q       ),
    .usedw                   (    )
);

reg [5:0] valid_cnt;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        valid_cnt<= 0;
    else if(valid_cnt == reludata_num)
        valid_cnt<= 0;
    else if(relu_valid)
        valid_cnt<= valid_cnt + 1;
    else valid_cnt<= valid_cnt;
end

reg rd_flag;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        rd_flag<= 0;
    else if(valid_cnt == reludata_num)
        rd_flag<= 1;
    else rd_flag<= rd_flag;
end


always @(*) begin
    if(rstn == 1'b0)
        rdreq<= 0;
    else if(rd_flag)
        rdreq<= relu_valid;
    else rdreq<= rdreq;        
end

reg  [21:0]  q_d;
reg  [21:0]  relu_data_d;
reg  [21:0]  relu_data_d1;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0) begin
        q_d<= 0;
        relu_data_d1<= 0;
    end        
    else begin 
        q_d <= q;   
        relu_data_d1<= relu_data_d; 
    end 
end           

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0) 
        relu_data_d<= 0;   
    else if(relu_valid)
        relu_data_d<= relu_data;
    else relu_data_d<= relu_data_d;
end

reg [5:0] rd_cnt_hor;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        rd_cnt_hor<= 0;
    else if(rd_cnt_hor == reludata_num)
        rd_cnt_hor<= 0;
    else if(rdreq)
        rd_cnt_hor <= rd_cnt_hor + 1;
    else rd_cnt_hor<= rd_cnt_hor;
end

reg rd_cnt_ver;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        rd_cnt_ver<= 1;
    else if(rd_cnt_hor == reludata_num)
        rd_cnt_ver <= ~rd_cnt_ver;    
    else rd_cnt_ver <= rd_cnt_ver;
end

reg valid_reg;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        valid_reg<= 0;
    else if(rd_cnt_hor[0] && rd_cnt_ver)
        valid_reg<= rdreq;
    else valid_reg<= 0;
end

assign gen_2_2_valid = valid_reg;
assign x_m_1 = valid_reg ? {q_d,relu_data_d1} : 0;
assign x_m_2 = valid_reg ? {q,relu_data_d} : 0;

endmodule //gen_2_2