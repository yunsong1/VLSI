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

    reg signed [8:0] dataa,datab;
    wire signed [17:0] result;
    parameter filenamea = "E:/spyder/FPGA/src/TXT/a.txt";
    parameter filenameb = "E:/spyder/FPGA/src/TXT/b.txt";
    integer fida; // 文件句柄
    integer fidb; // 文件句柄

    initial begin
        fida = $fopen(filenamea, "w");
        fidb = $fopen(filenameb, "w"); 
    end

    always @(posedge clk or negedge rstn) begin

        if(rstn == 1'b0) begin
            dataa <= 0;
            datab <= 0;
        end else begin
            dataa <= $random%10;
            datab <= $random%10;
            $fwrite(fida, "%-3d\n", dataa);
            $fwrite(fidb, "%-3d\n", datab);
        end
    end


    MULT_ACCUM	MULT_ACCUM_inst (
        .clock0 ( clk ),
        .dataa ( dataa ),
        .datab ( datab ),
        .result ( result )
        );


endmodule