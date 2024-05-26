//~ `New testbench
`timescale  1ns / 1ps

module tb_gen_5_5;

// gen_5_5 Parameters
parameter PERIOD  = 10;


// gen_5_5 Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;

// gen_5_5 Outputs
wire  valid                                ;
wire  [44:0]  x_m_1                        ;
wire  [44:0]  x_m_2                        ;
wire  [44:0]  x_m_3                        ;
wire  [44:0]  x_m_4                        ;
wire  [44:0]  x_m_5                        ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

gen_5_5  u_gen_5_5 (
    .clk                     ( clk           ),
    .rstn                    ( rstn          ),

    .valid                   ( valid         ),
    .x_m_1                   ( x_m_1  [44:0] ),
    .x_m_2                   ( x_m_2  [44:0] ),
    .x_m_3                   ( x_m_3  [44:0] ),
    .x_m_4                   ( x_m_4  [44:0] ),
    .x_m_5                   ( x_m_5  [44:0] )
);

// initial
// begin

//     $finish;
// end

// wire  [8:0]  x_1_1,x_1_2,x_1_3,x_1_4,x_1_5;//第一行
// wire  [8:0]  x_2_1,x_2_2,x_2_3,x_2_4,x_2_5;
// wire  [8:0]  x_3_1,x_3_2,x_3_3,x_3_4,x_3_5;
// wire  [8:0]  x_4_1,x_4_2,x_4_3,x_4_4,x_4_5;
// wire  [8:0]  x_5_1,x_5_2,x_5_3,x_5_4,x_5_5;

// assign x_5_5 = taps[8:0];
// assign x_4_5 = taps[17:9];
// assign x_3_5 = taps[26:18];
// assign x_2_5 = taps[35:27];
// assign x_1_5 = taps[44:36];

// assign x_5_4 = taps_4[8:0];
// assign x_4_4 = taps_4[17:9];
// assign x_3_4 = taps_4[26:18];
// assign x_2_4 = taps_4[35:27];
// assign x_1_4 = taps_4[44:36];

// assign x_5_3 = taps_3[8:0];
// assign x_4_3 = taps_3[17:9];
// assign x_3_3 = taps_3[26:18];
// assign x_2_3 = taps_3[35:27];
// assign x_1_3 = taps_3[44:36];

// assign x_5_2 = taps_2[8:0];
// assign x_4_2 = taps_2[17:9];
// assign x_3_2 = taps_2[26:18];
// assign x_2_2 = taps_2[35:27];
// assign x_1_2 = taps_2[44:36];

// assign x_5_1 = taps_1[8:0];
// assign x_4_1 = taps_1[17:9];
// assign x_3_1 = taps_1[26:18];
// assign x_2_1 = taps_1[35:27];
// assign x_1_1 = taps_1[44:36];

endmodule