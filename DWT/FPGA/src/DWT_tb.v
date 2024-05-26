//~ `New testbench
`timescale  1ns / 1ps

module tb_DWT;

// DWT Parameters
parameter PERIOD = 10;
parameter w_in   = 9 ;//输入的位宽
parameter w_in_1   = 25 ;//输入的位宽
parameter y_out  = 25;//输出的位宽
parameter y_out_2  = 40;//输出的位宽
parameter c_in   = 9; //系数的位宽

// DWT Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;

// DWT Outputs



initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

DWT #(
    .w_in  ( w_in  ),
    .y_out ( y_out ),
    .c_in  ( c_in  ))
 u_DWT (
    .clk                     ( clk    ),
    .rstn                    ( rstn   )
);

    wire down_clk;
    assign down_clk = u_DWT.up_clk2;

    wire  signed [y_out_2-1:0]  data;
    assign data = u_DWT.Lo_R1_y_up;

    wire  Hi_D_down_valid;    
    assign Hi_D_down_valid = u_DWT.Lo_R1_up_valid;    

    integer file_conv2;
    initial begin
        #10
        file_conv2 = $fopen("E:/quartus/VLSI/DWT/FPGA/src/TXT/down_data.txt","w");   
    end

    reg [9:0] conv_data_cnt2;
    reg write_flag2;

    always @(posedge down_clk or negedge rstn) begin
        if(rstn == 1'b0) begin
                conv_data_cnt2<= 0;
                write_flag2 <= 1;
            end
        else if(Hi_D_down_valid&&write_flag2) begin 
                $fwrite(file_conv2, "%-15d\n", data);
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