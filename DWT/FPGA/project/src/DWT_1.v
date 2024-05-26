module DWT_1 
#(
    parameter w_in   = 9 ,//输入的位宽
    parameter y_out  = 25,//输出的位宽
    parameter c_in   = 9 //系数的位宽
)
(
    input clk,
    input rstn,
    // FIR Outputs
    output  signed [y_out-1:0]  Hi_D_c_y_6k  ,
    output  signed [y_out-1:0]  Hi_D_c_y_6k_1,
    output  signed [y_out-1:0]  Hi_D_c_y_6k_2,
    output  signed [y_out-1:0]  Hi_D_c_y_6k_3,
    output  signed [y_out-1:0]  Hi_D_c_y_6k_4,
    output  signed [y_out-1:0]  Hi_D_c_y_6k_5,
    output                      Hi_D_valid,
    // FIR Outputs
    output  signed [y_out-1:0]  Lo_D_c_y_6k  ,
    output  signed [y_out-1:0]  Lo_D_c_y_6k_1,
    output  signed [y_out-1:0]  Lo_D_c_y_6k_2,
    output  signed [y_out-1:0]  Lo_D_c_y_6k_3,
    output  signed [y_out-1:0]  Lo_D_c_y_6k_4,
    output  signed [y_out-1:0]  Lo_D_c_y_6k_5,
    output                      Lo_D_valid    

);
// data_gen Outputs
wire  valid;
wire  signed [8:0]  data;

data_gen  u_data_gen (
    .clk                     ( clk     ),
    .rstn                    ( rstn    ),

    .valid                   ( valid   ),
    .data                    ( data    )
); 

reg [44:0] data_reg;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        data_reg<= 0;
    else data_reg <= {data_reg[35:0],data};
end

wire signed [8:0] Hi_D_x_in;
assign Hi_D_x_in = data_reg[44:36];

// reg   signed [w_in-1:0]  x_in;
reg   signed [c_in-1:0]  Hi_D_c_0=-124;
reg   signed [c_in-1:0]  Hi_D_c_1=214;
reg   signed [c_in-1:0]  Hi_D_c_2=-58;
reg   signed [c_in-1:0]  Hi_D_c_3=-34;

// // FIR Outputs
// wire  signed [y_out-1:0]  Hi_D_c_y_6k  ;
// wire  signed [y_out-1:0]  Hi_D_c_y_6k_1;
// wire  signed [y_out-1:0]  Hi_D_c_y_6k_2;
// wire  signed [y_out-1:0]  Hi_D_c_y_6k_3;
// wire  signed [y_out-1:0]  Hi_D_c_y_6k_4;
// wire  signed [y_out-1:0]  Hi_D_c_y_6k_5;

FIR #(
    .w_in  ( w_in  ),
    .y_out ( y_out ),
    .c_in  ( c_in  ))
 u_FIR_1 (
    .clk                     ( clk      ),
    .rstn                    ( rstn     ),
    .x_in                    ( Hi_D_x_in     ),
    .c_0                     ( Hi_D_c_0      ),
    .c_1                     ( Hi_D_c_1      ),
    .c_2                     ( Hi_D_c_2      ),
    .c_3                     ( Hi_D_c_3      ),

    .y_6k                    ( Hi_D_c_y_6k     ),
    .y_6k_1                  ( Hi_D_c_y_6k_1   ),
    .y_6k_2                  ( Hi_D_c_y_6k_2   ),
    .y_6k_3                  ( Hi_D_c_y_6k_3   ),
    .y_6k_4                  ( Hi_D_c_y_6k_4   ),
    .y_6k_5                  ( Hi_D_c_y_6k_5   )
);

reg [12:0] Hi_D_valid_reg;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        Hi_D_valid_reg<= 0;
    else Hi_D_valid_reg <= {Hi_D_valid_reg[11:0],valid};
end

// wire Hi_D_valid;
assign Hi_D_valid = Hi_D_valid_reg[12];
//18



// reg   signed [w_in-1:0]  x_in;
reg   signed [c_in-1:0]  Lo_D_c_0=-34;
reg   signed [c_in-1:0]  Lo_D_c_1=57;
reg   signed [c_in-1:0]  Lo_D_c_2=214;
reg   signed [c_in-1:0]  Lo_D_c_3=123;

// // FIR Outputs
// wire  signed [y_out-1:0]  Lo_D_c_y_6k  ;
// wire  signed [y_out-1:0]  Lo_D_c_y_6k_1;
// wire  signed [y_out-1:0]  Lo_D_c_y_6k_2;
// wire  signed [y_out-1:0]  Lo_D_c_y_6k_3;
// wire  signed [y_out-1:0]  Lo_D_c_y_6k_4;
// wire  signed [y_out-1:0]  Lo_D_c_y_6k_5;


wire signed [8:0] Lo_D_x_in;
assign Lo_D_x_in = Hi_D_x_in;

FIR #(
    .w_in  ( w_in  ),
    .y_out ( y_out ),
    .c_in  ( c_in  ))
 u_FIR_2 (
    .clk                     ( clk      ),
    .rstn                    ( rstn     ),
    .x_in                    ( Lo_D_x_in     ),
    .c_0                     ( Lo_D_c_0      ),
    .c_1                     ( Lo_D_c_1      ),
    .c_2                     ( Lo_D_c_2      ),
    .c_3                     ( Lo_D_c_3      ),

    .y_6k                    ( Lo_D_c_y_6k     ),
    .y_6k_1                  ( Lo_D_c_y_6k_1   ),
    .y_6k_2                  ( Lo_D_c_y_6k_2   ),
    .y_6k_3                  ( Lo_D_c_y_6k_3   ),
    .y_6k_4                  ( Lo_D_c_y_6k_4   ),
    .y_6k_5                  ( Lo_D_c_y_6k_5   )
);

// wire Lo_D_valid;
assign Lo_D_valid = Hi_D_valid;

endmodule //DWT