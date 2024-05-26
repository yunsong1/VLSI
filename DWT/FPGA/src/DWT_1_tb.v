//~ `New testbench
`timescale  1ns / 1ps

module tb_DWT_1;

// DWT_1 Parameters
parameter PERIOD = 10;
parameter w_in   = 9 ;
parameter y_out  = 25;
parameter c_in   = 9 ;

// DWT_1 Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;

// DWT_1 Outputs
wire  [y_out-1:0]  Hi_D_c_y_6k             ;
wire  [y_out-1:0]  Hi_D_c_y_6k_1           ;
wire  [y_out-1:0]  Hi_D_c_y_6k_2           ;
wire  [y_out-1:0]  Hi_D_c_y_6k_3           ;
wire  [y_out-1:0]  Hi_D_c_y_6k_4           ;
wire  [y_out-1:0]  Hi_D_c_y_6k_5           ;
wire  Hi_D_valid                           ;
wire  [y_out-1:0]  Lo_D_c_y_6k             ;
wire  [y_out-1:0]  Lo_D_c_y_6k_1           ;
wire  [y_out-1:0]  Lo_D_c_y_6k_2           ;
wire  [y_out-1:0]  Lo_D_c_y_6k_3           ;
wire  [y_out-1:0]  Lo_D_c_y_6k_4           ;
wire  [y_out-1:0]  Lo_D_c_y_6k_5           ;
wire  Lo_D_valid                           ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

DWT_1 #(
    .w_in  ( w_in  ),
    .y_out ( y_out ),
    .c_in  ( c_in  ))
 u_DWT_1 (
    .clk                     ( clk                        ),
    .rstn                    ( rstn                       ),

    .Hi_D_c_y_6k             ( Hi_D_c_y_6k    [y_out-1:0] ),
    .Hi_D_c_y_6k_1           ( Hi_D_c_y_6k_1  [y_out-1:0] ),
    .Hi_D_c_y_6k_2           ( Hi_D_c_y_6k_2  [y_out-1:0] ),
    .Hi_D_c_y_6k_3           ( Hi_D_c_y_6k_3  [y_out-1:0] ),
    .Hi_D_c_y_6k_4           ( Hi_D_c_y_6k_4  [y_out-1:0] ),
    .Hi_D_c_y_6k_5           ( Hi_D_c_y_6k_5  [y_out-1:0] ),
    .Hi_D_valid              ( Hi_D_valid                 ),
    .Lo_D_c_y_6k             ( Lo_D_c_y_6k    [y_out-1:0] ),
    .Lo_D_c_y_6k_1           ( Lo_D_c_y_6k_1  [y_out-1:0] ),
    .Lo_D_c_y_6k_2           ( Lo_D_c_y_6k_2  [y_out-1:0] ),
    .Lo_D_c_y_6k_3           ( Lo_D_c_y_6k_3  [y_out-1:0] ),
    .Lo_D_c_y_6k_4           ( Lo_D_c_y_6k_4  [y_out-1:0] ),
    .Lo_D_c_y_6k_5           ( Lo_D_c_y_6k_5  [y_out-1:0] ),
    .Lo_D_valid              ( Lo_D_valid                 )
);


endmodule