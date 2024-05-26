module maxpool (
    input clk,
    input rstn,
    input  relu_valid,
    input  signed [21:0]  relu_data,
    output  maxpool_valid,
    output  signed [21:0]  maxpool_data    
);
// gen_2_2 Parameters
parameter reludata_num  = 28;
// gen_2_2 Outputs
wire  gen_2_2_valid;
wire  [43:0]  x_m_1;
wire  [43:0]  x_m_2;

gen_2_2 #(
    .reludata_num ( reludata_num ))
u_gen_2_2 (
    .clk                     ( clk             ),
    .rstn                    ( rstn            ),
    .relu_valid              ( relu_valid      ),
    .relu_data               ( relu_data       ),

    .gen_2_2_valid           ( gen_2_2_valid   ),
    .x_m_1                   ( x_m_1           ),
    .x_m_2                   ( x_m_2           )
);    

compare  u_compare (
    .clk                     ( clk             ),
    .rstn                    ( rstn            ),
    .valid                   ( gen_2_2_valid           ),
    .x_m_1                   ( x_m_1           ),
    .x_m_2                   ( x_m_2           ),

    .compare_valid           ( maxpool_valid   ),
    .data                    ( maxpool_data            )
);
endmodule //maxpool