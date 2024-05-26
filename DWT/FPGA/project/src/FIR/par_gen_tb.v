//~ `New testbench
`timescale  1ns / 1ps

module tb_par_gen;

// par_gen Parameters
parameter PERIOD = 10;
parameter w_in   = 15;

// par_gen Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   signed [w_in-1:0]  data_in                  = 0 ;

// par_gen Outputs
wire  valid_wire                           ;
wire  signed [w_in-1:0]  data_out_0_wire          ;
wire  signed [w_in-1:0]  data_out_1_wire          ;
wire  signed [w_in-1:0]  data_out_2_wire          ;
wire  signed [w_in-1:0]  data_out_3_wire          ;
wire  signed [w_in-1:0]  data_out_4_wire          ;
wire  signed [w_in-1:0]  data_out_5_wire          ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

par_gen #(
    .w_in  ( w_in  )
    )
 u_par_gen (
    .clk                     ( clk                         ),
    .rstn                    ( rstn                        ),
    .data_in                 ( data_in          [w_in-1:0] ),

    .valid_wire              ( valid_wire                  ),
    .data_out_0_wire         ( data_out_0_wire  [w_in-1:0] ),
    .data_out_1_wire         ( data_out_1_wire  [w_in-1:0] ),
    .data_out_2_wire         ( data_out_2_wire  [w_in-1:0] ),
    .data_out_3_wire         ( data_out_3_wire  [w_in-1:0] ),
    .data_out_4_wire         ( data_out_4_wire  [w_in-1:0] ),
    .data_out_5_wire         ( data_out_5_wire  [w_in-1:0] )
);

    always #10 data_in = {$random}%50;

endmodule


