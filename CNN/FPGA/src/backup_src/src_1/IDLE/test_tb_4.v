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
    taps_4 <= taps;
    taps_3 <= taps_4;
    taps_2 <= taps_3;
    taps_1 <= taps_2;
end

wire  [8:0]  x_1_1,x_1_2,x_1_3,x_1_4,x_1_5;//第一行
wire  [8:0]  x_2_1,x_2_2,x_2_3,x_2_4,x_2_5;
wire  [8:0]  x_3_1,x_3_2,x_3_3,x_3_4,x_3_5;
wire  [8:0]  x_4_1,x_4_2,x_4_3,x_4_4,x_4_5;
wire  [8:0]  x_5_1,x_5_2,x_5_3,x_5_4,x_5_5;

assign x_5_5 = taps[8:0];
assign x_4_5 = taps[17:9];
assign x_3_5 = taps[26:18];
assign x_2_5 = taps[35:27];
assign x_1_5 = taps[44:36];

assign x_5_4 = taps_4[8:0];
assign x_4_4 = taps_4[17:9];
assign x_3_4 = taps_4[26:18];
assign x_2_4 = taps_4[35:27];
assign x_1_4 = taps_4[44:36];

assign x_5_3 = taps_3[8:0];
assign x_4_3 = taps_3[17:9];
assign x_3_3 = taps_3[26:18];
assign x_2_3 = taps_3[35:27];
assign x_1_3 = taps_3[44:36];

assign x_5_2 = taps_2[8:0];
assign x_4_2 = taps_2[17:9];
assign x_3_2 = taps_2[26:18];
assign x_2_2 = taps_2[35:27];
assign x_1_2 = taps_2[44:36];

assign x_5_1 = taps_1[8:0];
assign x_4_1 = taps_1[17:9];
assign x_3_1 = taps_1[26:18];
assign x_2_1 = taps_1[35:27];
assign x_1_1 = taps_1[44:36];



// initial begin
//     #10
//     for(i=0;i<6;i = i + 1) begin
//         for (j = 0; j<5; j = j + 1) begin
//                 conv1_weight_1[j][i] = {conv1_weight[0][j][i],conv1_weight[1][j][i],conv1_weight[2][j][i]
//                                     ,conv1_weight[3][j][i],conv1_weight[4][j][i] };            
//         end
//     end
// end

endmodule