//~ `New testbench
`timescale  1ns / 1ps

module tb_data_gen;

// data_gen Parameters
parameter PERIOD  = 10;


// data_gen Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;

// data_gen Outputs
wire  valid                                ;
wire  [8:0]  data                          ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

data_gen  u_data_gen (
    .clk                     ( clk          ),
    .rstn                    ( rstn         ),

    .valid                   ( valid        ),
    .data                    ( data   [8:0] )
);



endmodule