//~ `New testbench
`timescale  1ns / 1ps

module tb_y_6k_2;

// y_6k Parameters
parameter PERIOD    = 10;
parameter w_in      = 5 ;
parameter y_out     = 12;
parameter c_in      = 3 ;
parameter w_muti_y  = 10;
parameter w_add_y   = 12;

// y_6k_2 Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   signed [w_in-1:0]  x_6k                     = 0 ;
reg   signed [w_in-1:0]  x_6k_5                   = 0 ;
reg   signed [w_in-1:0]  x_6k_2                   = 0 ;
reg   signed [w_in-1:0]  x_6k_1                   = 0 ;
reg   signed [c_in-1:0]  c_0                      = 0 ;
reg   signed [c_in-1:0]  c_1                      = 1 ;
reg   signed [c_in-1:0]  c_2                      = 2 ;
reg   signed [c_in-1:0]  c_3                      = 3 ;

// y_6k_2 Outputs
wire  signed [y_out-1:0]  y_6k_2                  ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

y_6k_2 #(
    .w_in     ( w_in     ),
    .y_out    ( y_out    ),
    .c_in     ( c_in     ))
 u_y_6k_2 (
    .clk                     ( clk                 ),
    .rstn                    ( rstn                ),
    .x_6k                    ( x_6k    [w_in-1:0]  ),
    .x_6k_5                  ( x_6k_5  [w_in-1:0]  ),
    .x_6k_2                  ( x_6k_2  [w_in-1:0]  ),
    .x_6k_1                  ( x_6k_1  [w_in-1:0]  ),
    .c_0                     ( c_0     [c_in-1:0]  ),
    .c_1                     ( c_1     [c_in-1:0]  ),
    .c_2                     ( c_2     [c_in-1:0]  ),
    .c_3                     ( c_3     [c_in-1:0]  ),

    .y_6k_2                  ( y_6k_2  [y_out-1:0] )
);

    always @(posedge clk or negedge rstn) begin
        x_6k <={$random}%15;
        x_6k_5 <={$random}%15;
        x_6k_2 <={$random}%15;
        x_6k_1 <={$random}%15;
    end

endmodule