module data_gen (
    input clk,
    input rstn,
    output valid,
    output [8:0] data 
);
localparam mif_num = 201;
// signal_data Inputs
reg   [7:0]  address;

// signal_data Outputs
wire  [8:0]  q;
signal_data  u_signal_data (
    .address                 ( address   ),
    .clock                   ( clk     ),

    .q                       ( q         )
);    

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        address<= 0;
    else if(address == mif_num-1)
        address<= 0;
    else address<= address + 1;
end

assign data = q;

reg valid_reg;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        valid_reg<= 0;
    else valid_reg <= 1;
end

assign valid = valid_reg;

endmodule //data_gen