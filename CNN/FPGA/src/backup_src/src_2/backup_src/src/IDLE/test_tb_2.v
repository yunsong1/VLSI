//~ `New testbench
`timescale  1ns / 1ps

module tb_test;

// test Parameters
parameter PERIOD  = 10;


// test Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   [9:0]  addr                          = 0 ;

// test Outputs
wire  [8:0]  data                          ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

test  u_test (
    .clk                     ( clk         ),
    .rstn                    ( rstn        ),
    .addr                    ( addr  [9:0] ),

    .data                    ( data  [8:0] )
);

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        addr<= 0;
    else addr <= addr + 1;
    // addr <= {$random}%39;
end


parameter filename = "E:/spyder/FPGA/src/shift_in_data.txt";
integer fid;
initial begin
    fid = $fopen(filename,"w");
end
// CNN_windows Inputs
reg   signed [8:0]  shiftin;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        shiftin<= 0;
    else begin
        shiftin <= $random%251;
        $fwrite(fid,"%-4d\n",shiftin);
    end
end

// CNN_windows Outputs
wire  [8:0]  shiftout;
wire  [8:0]  taps0x;
wire  [8:0]  taps1x;
wire  [8:0]  taps2x;
wire  [8:0]  taps3x;
wire  [8:0]  taps4x;

CNN_windows_1  u_CNN_windows (
    .clock                   ( clk      ),
    .shiftin                 ( shiftin    ),

    .shiftout                ( shiftout   ),
    .taps0x                  ( taps0x     ),
    .taps1x                  ( taps1x     ),
    .taps2x                  ( taps2x     ),
    .taps3x                  ( taps3x     ),
    .taps4x                  ( taps4x     )
);

reg  [8:0]  taps0x_1,taps0x_2,taps0x_3,taps0x_4;
reg  [8:0]  taps1x_1,taps1x_2,taps1x_3,taps1x_4;
reg  [8:0]  taps2x_1,taps2x_2,taps2x_3,taps2x_4;
reg  [8:0]  taps3x_1,taps3x_2,taps3x_3,taps3x_4;
reg  [8:0]  taps4x_1,taps4x_2,taps4x_3,taps4x_4;

always @(posedge clk or negedge rstn) begin
    taps0x_4 <= taps0x;
    taps0x_3 <= taps0x_4;
    taps0x_2 <= taps0x_3;
    taps0x_1 <= taps0x_2;
end
always @(posedge clk or negedge rstn) begin
    taps1x_4 <= taps1x;
    taps1x_3 <= taps1x_4;
    taps1x_2 <= taps1x_3;
    taps1x_1 <= taps1x_2;
end
always @(posedge clk or negedge rstn) begin
    taps2x_4 <= taps2x;
    taps2x_3 <= taps2x_4;
    taps2x_2 <= taps2x_3;
    taps2x_1 <= taps2x_2;
end
always @(posedge clk or negedge rstn) begin
    taps3x_4 <= taps3x;
    taps3x_3 <= taps3x_4;
    taps3x_2 <= taps3x_3;
    taps3x_1 <= taps3x_2;
end
always @(posedge clk or negedge rstn) begin
    taps4x_4 <= taps4x;
    taps4x_3 <= taps4x_4;
    taps4x_2 <= taps4x_3;
    taps4x_1 <= taps4x_2;
end
endmodule