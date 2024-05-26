//~ `New testbench
`timescale  1ns / 1ps

module tb_FIR_src;

// FIR_src Parameters
parameter PERIOD    = 10;
parameter w_in      = 7 ;
parameter y_out     = 20;
parameter c_in      = 5 ;
parameter w_muti_y  = 16;
parameter w_add_y   = 20;

// FIR_src Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   signed [w_in-1:0]  x_in                     = 0 ;
reg   signed [c_in-1:0]  c_0                      = 1 ;
reg   signed [c_in-1:0]  c_1                      = 1 ;
reg   signed [c_in-1:0]  c_2                      = 2 ;
reg   signed [c_in-1:0]  c_3                      = 3 ;

// FIR_src Outputs
wire  signed [y_out-1:0]  y_k                     ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

FIR_src #(
    .w_in     ( w_in     ),
    .y_out    ( y_out    ),
    .c_in     ( c_in     ))
 u_FIR_src (
    .clk                     ( clk               ),
    .rstn                    ( rstn              ),
    .x_in                    ( x_in  [w_in-1:0]  ),
    .c_0                     ( c_0   [c_in-1:0]  ),
    .c_1                     ( c_1   [c_in-1:0]  ),
    .c_2                     ( c_2   [c_in-1:0]  ),
    .c_3                     ( c_3   [c_in-1:0]  ),

    .y_k                     ( y_k   [y_out-1:0] )
);
    always @(posedge clk or negedge rstn) begin
        x_in <={$random}%15;
    end

endmodule