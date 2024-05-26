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


parameter filename = "E:/spyder/FPGA/src/TXT/shift_in_data.txt";
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
wire  [44:0]  taps;//=============     move <---------    =============//

CNN_windows  u_CNN_windows (
    .clock                   ( clk      ),
    .shiftin                 ( shiftin    ),

    .shiftout                ( shiftout   ),
    .taps                    ( taps       )
); 

reg  [44:0]  taps_1,taps_2,taps_3,taps_4;
always @(posedge clk or negedge rstn) begin
    taps_1 <= taps;
    taps_2 <= taps_1;
    taps_3 <= taps_2;
    taps_4 <= taps_3;
end

wire  [8:0]  taps0x_1,taps0x_2,taps0x_3,taps0x_4,taps0x_5;
wire  [8:0]  taps1x_1,taps1x_2,taps1x_3,taps1x_4,taps1x_5;
wire  [8:0]  taps2x_1,taps2x_2,taps2x_3,taps2x_4,taps2x_5;
wire  [8:0]  taps3x_1,taps3x_2,taps3x_3,taps3x_4,taps3x_5;
wire  [8:0]  taps4x_1,taps4x_2,taps4x_3,taps4x_4,taps4x_5;


assign taps0x_1 = taps[8:0];
assign taps0x_2 = taps[17:9];
assign taps0x_3 = taps[26:18];
assign taps0x_4 = taps[35:27];
assign taps0x_5 = taps[44:36];

assign taps1x_1 = taps_1[8:0];
assign taps1x_2 = taps_1[17:9];
assign taps1x_3 = taps_1[26:18];
assign taps1x_4 = taps_1[35:27];
assign taps1x_5 = taps_1[44:36];

assign taps2x_1 = taps_2[8:0];
assign taps2x_2 = taps_2[17:9];
assign taps2x_3 = taps_2[26:18];
assign taps2x_4 = taps_2[35:27];
assign taps2x_5 = taps_2[44:36];

assign taps3x_1 = taps_3[8:0];
assign taps3x_2 = taps_3[17:9];
assign taps3x_3 = taps_3[26:18];
assign taps3x_4 = taps_3[35:27];
assign taps3x_5 = taps_3[44:36];

assign taps4x_1 = taps_4[8:0];
assign taps4x_2 = taps_4[17:9];
assign taps4x_3 = taps_4[26:18];
assign taps4x_4 = taps_4[35:27];
assign taps4x_5 = taps_4[44:36];





endmodule