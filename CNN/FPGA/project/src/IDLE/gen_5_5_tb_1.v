`timescale  1ns / 1ps
module gen_5_5_tb (
    input clk
);
    // 定义一个5x5x6的三维数组
    reg signed [8:0] conv1_weight [0:4][0:4][0:5]; 
    reg signed [44:0] conv1_weight_1 [0:4][0:5];
    reg signed [8:0] conv1_weight_2 [0:4];
    reg signed [8:0] conv1_weight_3;

    reg signed [8:0] a;
    initial begin
        a = -3;
    end

    parameter filename = "E:/spyder/matlab/conv1_weight_data.txt";
    integer fid; // 文件句柄
    integer file_x_in;
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
        file_x_in = $fopen("E:/spyder/FPGA/src/weights_in.txt","w");
        #30
        for(i=0;i<6;i = i + 1) begin
            for (j = 0; j<5; j = j + 1) begin
                for (k = 0; k<5; k = k + 1) begin
                    #4
                    conv1_weight_3 = conv1_weight[j][k][i];
                    $fwrite(file_x_in, "%-3d\n", conv1_weight_3);
                end
                
            end
        end
        // $fclose(file_x_in);
        // conv1_weight_3 = conv1_weight[0][0][0];
    end

    

endmodule //gen_5_5_tb