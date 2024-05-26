//~ `New testbench
`timescale  1ns / 1ps

module tb_compare;

// compare Parameters
parameter PERIOD  = 10;


// compare Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   valid                                = 0 ;
reg   [43:0]  x_m_1                        = 0 ;
reg   [43:0]  x_m_2                        = 0 ;

// compare Outputs
wire  compare_valid                        ;
wire  [21:0]  data                         ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

compare  u_compare (
    .clk                     ( clk                   ),
    .rstn                    ( rstn                  ),
    .valid                   ( valid                 ),
    .x_m_1                   ( x_m_1          [43:0] ),
    .x_m_2                   ( x_m_2          [43:0] ),

    .compare_valid           ( compare_valid         ),
    .data                    ( data           [21:0] )
);
reg signed [21:0] x_m_1_a;
reg signed [21:0] x_m_1_b;
reg signed [21:0] x_m_2_a;
reg signed [21:0] x_m_2_b;

always @(posedge clk or negedge rstn) begin
    x_m_1_a <= $random%50;
    x_m_1_b <= $random%50;
    x_m_2_a <= $random%50;
    x_m_2_b <= $random%50;
end
always @(posedge clk or negedge rstn) begin
    x_m_1 <= {x_m_1_a,x_m_1_b};
    x_m_2 <= {x_m_2_a,x_m_2_b};
end

endmodule