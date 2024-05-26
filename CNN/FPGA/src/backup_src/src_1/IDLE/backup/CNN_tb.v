//~ `New testbench
`timescale  1ns / 1ps

module tb_CNN;

// CNN Parameters
parameter PERIOD  = 10;


// CNN Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   [1349:0]  weights                    = 0 ;
reg   [53:0]  bias                         = 0 ;

// CNN Outputs
wire  data                                 ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

reg signed [8:0] conv1_weight [0:4][0:4][0:5]; 

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
    #10
    for(i=0;i<6;i = i + 1) begin
        for (j = 0; j<5; j = j + 1) begin
            for (k = 0; k<5; k = k + 1) begin
                weights = {weights[1340:0],conv1_weight[k][j][i]};
            end
        end
    end
end

CNN  u_CNN (
    .clk                     ( clk               ),
    .rstn                    ( rstn              ),
    .weights                 ( weights  [1349:0] ),
    .bias                    ( bias     [53:0]   ),

    .data                    ( data              )
);


endmodule