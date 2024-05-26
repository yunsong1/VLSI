//~ `New testbench
`timescale  1ns / 1ps

module tb_maxpool;

// maxpool Parameters
parameter PERIOD        = 10;
// defparam maxpool.u_gen_2_2.reludata_num  = 6;
parameter reludata_num  = 6;

// maxpool Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   relu_valid                           = 0 ;
reg   [21:0]  relu_data                    = 0 ;

// maxpool Outputs
wire  maxpool_valid                        ;
wire  [21:0]  maxpool_data                 ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

maxpool #(
    .reludata_num ( reludata_num ))
 u_maxpool (
    .clk                     ( clk                   ),
    .rstn                    ( rstn                  ),
    .relu_valid              ( relu_valid            ),
    .relu_data               ( relu_data      [21:0] ),

    .maxpool_valid           ( maxpool_valid         ),
    .maxpool_data            ( maxpool_data   [21:0] )
);

reg [1:0] cnt;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        cnt<= 0;
    else cnt <= cnt + 1;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0) begin 
        relu_valid<= 0;
        relu_data <= 0;
    end
    else if(cnt == 3) begin         
        relu_valid <= 1;
        relu_data <= {$random}%50;
    end        
    else begin
        relu_valid<= 0;
        relu_data <= 0;
    end
end

endmodule