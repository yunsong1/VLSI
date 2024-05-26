module relu (
    input clk,
    input rstn,
    input  conv_valid,
    input  signed [21:0]  conv_data,    
    output  relu_valid,
    output  signed [21:0]  relu_data  
);

    reg  valid_reg;
    reg  signed [21:0]  data_reg; 

    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            data_reg<= 0;
        else if((conv_valid == 1) && (conv_data[21] == 1))
            data_reg<= 0;
        else data_reg<= conv_data;
    end

    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            valid_reg<= 0;
        else valid_reg <= conv_valid;
    end

    assign relu_valid = valid_reg;
    assign relu_data = data_reg;

endmodule //relu