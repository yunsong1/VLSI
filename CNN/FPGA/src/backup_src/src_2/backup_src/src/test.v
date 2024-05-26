module test (
    input clk,
    input rstn,
    input [9:0] addr,
    output [8:0] data
);
IMAGE_ROM	IMAGE_ROM_inst (
	.address ( addr ),
	.clock ( clk ),
	.q ( data )
	);

endmodule //test