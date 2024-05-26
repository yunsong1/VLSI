//~ `New testbench
`timescale  1ns / 1ps

module tb_FIR;

//  Parameters
parameter PERIOD    = 10;
parameter w_in      = 5 ;
parameter y_out     = 12;
parameter c_in      = 3 ;

// FIR Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   signed [w_in-1:0]  x_in                     = 0 ;
reg   signed [c_in-1:0]  c_0                      = -1 ;
reg   signed [c_in-1:0]  c_1                      = -1 ;
reg   signed [c_in-1:0]  c_2                      = -2 ;
reg   signed [c_in-1:0]  c_3                      = 3 ;

// FIR Outputs
wire  signed [y_out-1:0]  y_6k                    ;
wire  signed [y_out-1:0]  y_6k_1                  ;
wire  signed [y_out-1:0]  y_6k_2                  ;
wire  signed [y_out-1:0]  y_6k_3                  ;
wire  signed [y_out-1:0]  y_6k_4                  ;
wire  signed [y_out-1:0]  y_6k_5                  ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

    // GTP_GRS GRS_INST(
    // .GRS_N(1'b1)
    // ) ;
    
FIR #(
    .w_in  ( w_in  ),
    .y_out ( y_out ),
    .c_in  ( c_in  ))
 u_FIR (
    .clk                     ( clk                 ),
    .rstn                    ( rstn                ),
    .x_in                    ( x_in    [w_in-1:0]  ),
    .c_0                     ( c_0     [c_in-1:0]  ),
    .c_1                     ( c_1     [c_in-1:0]  ),
    .c_2                     ( c_2     [c_in-1:0]  ),
    .c_3                     ( c_3     [c_in-1:0]  ),

    .y_6k                    ( y_6k    [y_out-1:0] ),
    .y_6k_1                  ( y_6k_1  [y_out-1:0] ),
    .y_6k_2                  ( y_6k_2  [y_out-1:0] ),
    .y_6k_3                  ( y_6k_3  [y_out-1:0] ),
    .y_6k_4                  ( y_6k_4  [y_out-1:0] ),
    .y_6k_5                  ( y_6k_5  [y_out-1:0] )
);

    wire fir_clk;
    assign fir_clk = u_FIR.u_par_gen.valid_wire;

    //x_in.txt
    integer file_x_in;
    always @(posedge clk or negedge rstn) begin
        x_in <={$random}%15;
        if(rstn == 0) begin 
            file_x_in = $fopen("x_in.txt","w");
            $fwrite(file_x_in, "%-10d\n", 0);   
            $fwrite(file_x_in, "%-10d\n", 0);
            $fwrite(file_x_in, "%-10d\n", 0);
            $fwrite(file_x_in, "%-10d\n", 0);
            $fwrite(file_x_in, "%-10d\n", 0);
            $fwrite(file_x_in, "%-10d\n", 0);
            $display("start");   
        end
        else begin
            $fwrite(file_x_in, "%-10d\n", x_in);//左对齐,宽10个字符
        end
    end

    //y_k.txt
    integer file_y_k;
    always @(posedge fir_clk or negedge rstn) begin
        if(rstn == 0) begin 
            file_y_k = $fopen("y_k.txt","w");
            $display("start");   
        end
        else begin
            $fwrite(file_y_k, "%-10d\n", y_6k);
            $fwrite(file_y_k, "%-10d\n", y_6k_1);
            $fwrite(file_y_k, "%-10d\n", y_6k_2);
            $fwrite(file_y_k, "%-10d\n", y_6k_3);
            $fwrite(file_y_k, "%-10d\n", y_6k_4);
            $fwrite(file_y_k, "%-10d\n", y_6k_5);
        end
    end

    wire [y_out-1:0] FIR_s_data;
    assign FIR_s_data = u_FIR.u_FIR_src.y_k;
    //data.txt
    integer file_data;
    always @(posedge clk or negedge rstn) begin
        if(rstn == 0) begin 
            file_data = $fopen("data.txt","w");
            $display("start");   
        end
        else begin
            $fwrite(file_data, "%-10d\n", FIR_s_data);
        end
    end

endmodule