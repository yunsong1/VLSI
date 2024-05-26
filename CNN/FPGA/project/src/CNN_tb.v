//~ `New testbench
`timescale  1ns / 1ps

module tb_CNN;

// CNN Parameters
parameter PERIOD  = 10;
parameter number = 6;//1---6//
parameter weight_bias_number = number - 1;//0---5//

// CNN Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   [44:0]  weight_m_1                   = 0 ;
reg   [44:0]  weight_m_2                   = 0 ;
reg   [44:0]  weight_m_3                   = 0 ;
reg   [44:0]  weight_m_4                   = 0 ;
reg   [44:0]  weight_m_5                   = 0 ;
reg   signed [8:0]  bias                   = 0 ;

// CNN Outputs
wire  conv_valid                                 ;
wire  signed [21:0]  conv_data                   ;
wire  maxpool_valid                              ;
wire  signed [21:0]  maxpool_data                ;

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

    // 定义一个5x5x6的三维数组
    reg signed [8:0] conv1_weight [0:4][0:4][0:5]; 
    reg signed [44:0] conv1_weight_1_m_n [0:4];
    reg signed [8:0] conv1_bias [0:5];

    parameter filename = "E:/spyder/matlab/conv1_weight_data.txt";
    integer fid; // 文件句柄
    integer i,j,k; // 
    initial begin
        fid = $fopen(filename, "r");
        
            if(fid != 0) begin
                for(i=0;i<6;i = i + 1) begin
                    for (j = 0; j<5; j = j + 1) begin
                        for (k = 0; k<5; k = k + 1) begin
                            $fscanf(fid, "%b\n", conv1_weight[j][k][i]);
                        end

                    end
                end
            end 

        $fclose(fid);

    end

    initial begin
        #30
            for (j = 0; j<5; j = j + 1) begin
                for (k = 0; k<5; k = k + 1) begin
                    // #1
                    conv1_weight_1_m_n[j] = {conv1_weight_1_m_n[j][35:0],conv1_weight[k][j][weight_bias_number]};
                end
                
            end
    end

    parameter file_bias = "E:/spyder/matlab/conv1_bias_data.txt";
    integer bias_fid; // 文件句柄
    initial begin
        bias_fid = $fopen(file_bias, "r");
        for(i=0; i<6; i = i + 1) begin
            $fscanf(bias_fid, "%b\n", conv1_bias[i]);
        end
        $fclose(fid);
    end


always @(*) begin
    weight_m_1 <= conv1_weight_1_m_n[0];
    weight_m_2 <= conv1_weight_1_m_n[1];
    weight_m_3 <= conv1_weight_1_m_n[2];
    weight_m_4 <= conv1_weight_1_m_n[3];
    weight_m_5 <= conv1_weight_1_m_n[4];
end

CNN  u_CNN (
    .clk                     ( clk                ),
    .rstn                    ( rstn               ),
    .weight_m_1              ( weight_m_1  [44:0] ),
    .weight_m_2              ( weight_m_2  [44:0] ),
    .weight_m_3              ( weight_m_3  [44:0] ),
    .weight_m_4              ( weight_m_4  [44:0] ),
    .weight_m_5              ( weight_m_5  [44:0] ),
    .bias                    ( conv1_bias  [weight_bias_number]  ),
    .conv_valid              ( conv_valid         ),
    .conv_data               ( conv_data          ),
    .maxpool_valid              ( maxpool_valid         ),
    .maxpool_data               ( maxpool_data          )     
);

    integer file_conv1;
    initial begin
        #10
        file_conv1 = $fopen("E:/spyder/FPGA/src/TXT/conv1_data_check.txt","w");
    end

    reg [9:0] conv_data_cnt1;
    reg write_flag1;

    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0) begin
                conv_data_cnt1<= 0;
                write_flag1 <= 1;
            end
        else if(conv_valid&&write_flag1) begin 
                $fwrite(file_conv1, "%-15d\n", conv_data);
                conv_data_cnt1 <= conv_data_cnt1 + 1;
            end
        else if(conv_data_cnt1 == 28*28) begin
                conv_data_cnt1<= 0;
                write_flag1 <= 0;
                $fclose(file_conv1);
            end
        else begin
                conv_data_cnt1<= conv_data_cnt1;
                write_flag1 <= write_flag1;
            end
    end

    integer file_conv2;
    initial begin
        #10
        file_conv2 = $fopen("E:/spyder/FPGA/src/TXT/pool_data_check.txt","w");   
    end

    reg [9:0] conv_data_cnt2;
    reg write_flag2;

    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0) begin
                conv_data_cnt2<= 0;
                write_flag2 <= 1;
            end
        else if(maxpool_valid&&write_flag2) begin 
                $fwrite(file_conv2, "%-15d\n", maxpool_data);
                conv_data_cnt2 <= conv_data_cnt2 + 1;
            end
        else if(conv_data_cnt2 == 14*14) begin
                conv_data_cnt2<= 0;
                write_flag2 <= 0;
                $fclose(file_conv2);
            end
        else begin
                conv_data_cnt2<= conv_data_cnt2;
                write_flag2 <= write_flag2;
            end
    end
 
endmodule