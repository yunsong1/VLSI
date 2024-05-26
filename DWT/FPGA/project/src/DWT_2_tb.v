//~ `New testbench
`timescale  1ns / 1ps

module tb_DWT_2;

// DWT_2 Parameters
parameter PERIOD = 10;
parameter w_in   = 9 ;
parameter y_out  = 25;
parameter c_in   = 9 ;

// DWT_2 Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   Lo_D_down_valid                      = 0 ;
reg   [y_out-1:0]  Lo_D_down_y_k           = 0 ;

// DWT_2 Outputs
wire  [y_out-1:0]  Hi_D2_c_y_6k            ;
wire  [y_out-1:0]  Hi_D2_c_y_6k_1          ;
wire  [y_out-1:0]  Hi_D2_c_y_6k_2          ;
wire  [y_out-1:0]  Hi_D2_c_y_6k_3          ;
wire  [y_out-1:0]  Hi_D2_c_y_6k_4          ;
wire  [y_out-1:0]  Hi_D2_c_y_6k_5          ;
wire  Hi_D2_valid                          ;
wire  [y_out-1:0]  Lo_D2_c_y_6k            ;
wire  [y_out-1:0]  Lo_D2_c_y_6k_1          ;
wire  [y_out-1:0]  Lo_D2_c_y_6k_2          ;
wire  [y_out-1:0]  Lo_D2_c_y_6k_3          ;
wire  [y_out-1:0]  Lo_D2_c_y_6k_4          ;
wire  [y_out-1:0]  Lo_D2_c_y_6k_5          ;
wire  Lo_D2_valid                          ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

DWT_2 #(
    .w_in  ( w_in  ),
    .y_out ( y_out ),
    .c_in  ( c_in  ))
 u_DWT_2 (
    .clk                     ( clk                          ),
    .rstn                    ( rstn                         ),
    .Lo_D_down_valid         ( Lo_D_down_valid              ),
    .Lo_D_down_y_k           ( Lo_D_down_y_k    [y_out-1:0] ),

    .Hi_D2_c_y_6k            ( Hi_D2_c_y_6k     [y_out-1:0] ),
    .Hi_D2_c_y_6k_1          ( Hi_D2_c_y_6k_1   [y_out-1:0] ),
    .Hi_D2_c_y_6k_2          ( Hi_D2_c_y_6k_2   [y_out-1:0] ),
    .Hi_D2_c_y_6k_3          ( Hi_D2_c_y_6k_3   [y_out-1:0] ),
    .Hi_D2_c_y_6k_4          ( Hi_D2_c_y_6k_4   [y_out-1:0] ),
    .Hi_D2_c_y_6k_5          ( Hi_D2_c_y_6k_5   [y_out-1:0] ),
    .Hi_D2_valid             ( Hi_D2_valid                  ),
    .Lo_D2_c_y_6k            ( Lo_D2_c_y_6k     [y_out-1:0] ),
    .Lo_D2_c_y_6k_1          ( Lo_D2_c_y_6k_1   [y_out-1:0] ),
    .Lo_D2_c_y_6k_2          ( Lo_D2_c_y_6k_2   [y_out-1:0] ),
    .Lo_D2_c_y_6k_3          ( Lo_D2_c_y_6k_3   [y_out-1:0] ),
    .Lo_D2_c_y_6k_4          ( Lo_D2_c_y_6k_4   [y_out-1:0] ),
    .Lo_D2_c_y_6k_5          ( Lo_D2_c_y_6k_5   [y_out-1:0] ),
    .Lo_D2_valid             ( Lo_D2_valid                  )
);


always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        Lo_D_down_valid<= 0;
    else Lo_D_down_valid <= 1;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        Lo_D_down_y_k<= 0;
    else Lo_D_down_y_k <= $random%50;
end
endmodule