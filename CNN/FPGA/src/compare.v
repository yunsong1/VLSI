module compare (
    input clk,
    input rstn,
    input  valid,
    input  [43:0]  x_m_1,
    input  [43:0]  x_m_2, 
    output compare_valid, 
    output signed [21:0]  data   
);
    wire  signed [21:0]  x_1_1,x_1_2;//第一行
    wire  signed [21:0]  x_2_1,x_2_2;

    assign x_2_1 = x_m_1[21:0];
    assign x_1_1 = x_m_1[43:22];

    assign x_2_2 = x_m_2[21:0];
    assign x_1_2 = x_m_2[43:22];

    reg signed [21:0] reg_data_1;
    reg signed [21:0] reg_data_2;
    reg signed [21:0] reg_data;

    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            reg_data_1<= 0;
        else if(x_1_1 >= x_1_2)
            reg_data_1<= x_1_1;
        else if(x_1_2 >= x_1_1)
            reg_data_1<= x_1_2;  
        else reg_data_1<= reg_data_1;          
    end

    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            reg_data_2<= 0;
        else if(x_2_1 >= x_2_2)
            reg_data_2<= x_2_1;
        else if(x_2_2 >= x_2_1)
            reg_data_2<= x_2_2;  
        else reg_data_2<= reg_data_2;          
    end 

    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            reg_data<= 0;
        else if(reg_data_1 >= reg_data_2)
            reg_data<= reg_data_1;
        else if(reg_data_2 >= reg_data_1)
            reg_data<= reg_data_2;  
        else reg_data<= reg_data;          
    end  

    reg [1:0] reg_valid;
    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            reg_valid<= 0;
        else reg_valid <= {reg_valid[0],valid};
    end     

    assign compare_valid = reg_valid[1];
    assign data = reg_data;



endmodule //compare