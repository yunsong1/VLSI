//~ `New testbench
`timescale  1ns / 1ps

module tb_conv;

// conv Parameters
parameter PERIOD = 10       ;
parameter idle  = 6'b000001;
parameter m_1   = 6'b000010;
parameter m_2   = 6'b000100;
parameter m_3   = 6'b001000;
parameter m_4   = 6'b010000;
parameter m_5   = 6'b100000;

// conv Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   x_valid                              = 0 ;
reg   [44:0]  x_m_1                        = 1000000 ;
reg   [44:0]  x_m_2                        = 1000000 ;
reg   [44:0]  x_m_3                        = 1000000 ;
reg   [44:0]  x_m_4                        = 1000000 ;
reg   [44:0]  x_m_5                        = 1000000 ;
reg   [44:0]  weight_m_1                   = 1000000 ;
reg   [44:0]  weight_m_2                   = 1000000 ;
reg   [44:0]  weight_m_3                   = 1000000 ;
reg   [44:0]  weight_m_4                   = 1000000 ;
reg   [44:0]  weight_m_5                   = 1000000 ;
reg   [8:0]  bias                          = 0 ;

// conv Outputs
wire  conv_valid                           ;
wire  [8:0]  conv_data                     ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

initial begin
    #100
    x_valid = 1;
end
conv #(
    .idle ( idle ),
    .m_1  ( m_1  ),
    .m_2  ( m_2  ),
    .m_3  ( m_3  ),
    .m_4  ( m_4  ),
    .m_5  ( m_5  ))
 u_conv (
    .clk                     ( clk                ),
    .rstn                    ( rstn               ),
    .x_valid                 ( x_valid            ),
    .x_m_1                   ( x_m_1       [44:0] ),
    .x_m_2                   ( x_m_2       [44:0] ),
    .x_m_3                   ( x_m_3       [44:0] ),
    .x_m_4                   ( x_m_4       [44:0] ),
    .x_m_5                   ( x_m_5       [44:0] ),
    .weight_m_1              ( weight_m_1  [44:0] ),
    .weight_m_2              ( weight_m_2  [44:0] ),
    .weight_m_3              ( weight_m_3  [44:0] ),
    .weight_m_4              ( weight_m_4  [44:0] ),
    .weight_m_5              ( weight_m_5  [44:0] ),
    .bias                    ( bias        [8:0]  ),

    .conv_valid              ( conv_valid         ),
    .conv_data               ( conv_data   [8:0]  )
);



endmodule