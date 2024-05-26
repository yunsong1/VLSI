module conv (
    input clk,
    input rstn,
    input x_valid,
    input [44:0] x_m_1,//第一列
    input [44:0] x_m_2,
    input [44:0] x_m_3,
    input [44:0] x_m_4,
    input [44:0] x_m_5,

    input [44:0] weight_m_1,//第一列权重
    input [44:0] weight_m_2,
    input [44:0] weight_m_3,
    input [44:0] weight_m_4,
    input [44:0] weight_m_5,

    input [8:0] bias,//偏置

    output conv_valid,
    output [8:0] conv_data
);
    parameter idle = 6'b000001;
    parameter m_1 = 6'b000010;//第一列
    parameter m_2 = 6'b000100;
    parameter m_3 = 6'b001000;
    parameter m_4 = 6'b010000; 
    parameter m_5 = 6'b100000;

    reg [5:0] state ;

    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0)
            state<= idle;
        else case (state)   
                idle:   
                    if(x_valid) 
                        state <= m_1;
                    else state<= idle;
                m_1:state <= m_2;
                m_2:state <= m_3;
                m_3:state <= m_4;
                m_4:state <= m_5;
                m_5:state <= m_1;
            default: state<= idle;
        endcase
    end
reg signed [8:0] dataa [5:0];
reg signed [8:0] datab [5:0];
wire signed [17:0] result  [5:0];

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        begin
           dataa[1]<= 0; dataa[2]<= 0; dataa[3]<= 0; dataa[4]<= 0; dataa[5]<= 0;
           datab[1]<= 0; datab[2]<= 0; datab[3]<= 0; datab[4]<= 0; datab[5]<= 0;
        end 
    else case (state)
                m_1://第一行
                    begin
                        dataa[1]<= x_m_1[44:36]; dataa[2]<= x_m_2[44:36];
                        dataa[3]<= x_m_3[44:36]; dataa[4]<= x_m_4[44:36]; dataa[5]<= x_m_5[44:36]; 

                        datab[1]<= weight_m_1[44:36]; datab[2]<= weight_m_2[44:36];
                        datab[3]<= weight_m_3[44:36]; datab[4]<= weight_m_4[44:36]; datab[5]<= weight_m_5[44:36];  
                    end                   
                m_2:
                    begin
                        dataa[1]<= x_m_1[35:27]; dataa[2]<= x_m_2[35:27];
                        dataa[3]<= x_m_3[35:27]; dataa[4]<= x_m_4[35:27]; dataa[5]<= x_m_5[35:27]; 

                        datab[1]<= weight_m_1[35:27]; datab[2]<= weight_m_2[35:27];
                        datab[3]<= weight_m_3[35:27]; datab[4]<= weight_m_4[35:27]; datab[5]<= weight_m_5[35:27];  
                    end                                     
                m_3:
                    begin
                        dataa[1]<= x_m_1[26:18]; dataa[2]<= x_m_2[26:18];
                        dataa[3]<= x_m_3[26:18]; dataa[4]<= x_m_4[26:18]; dataa[5]<= x_m_5[26:18];   

                        datab[1]<= weight_m_1[26:18]; datab[2]<= weight_m_2[26:18];
                        datab[3]<= weight_m_3[26:18]; datab[4]<= weight_m_4[26:18]; datab[5]<= weight_m_5[26:18]; 
                    end                                     
                m_4:
                    begin
                        dataa[1]<= x_m_1[17:9]; dataa[2]<= x_m_2[17:9];
                        dataa[3]<= x_m_3[17:9]; dataa[4]<= x_m_4[17:9]; dataa[5]<= x_m_5[17:9];  

                        datab[1]<= weight_m_1[17:9]; datab[2]<= weight_m_2[17:9];
                        datab[3]<= weight_m_3[17:9]; datab[4]<= weight_m_4[17:9]; datab[5]<= weight_m_5[17:9];  
                    end                                    
                m_5:
                    begin
                        dataa[1]<= x_m_1[8:0]; dataa[2]<= x_m_2[8:0];
                        dataa[3]<= x_m_3[8:0]; dataa[4]<= x_m_4[8:0]; dataa[5]<= x_m_5[8:0];  

                        datab[1]<= weight_m_1[8:0]; datab[2]<= weight_m_2[8:0];
                        datab[3]<= weight_m_3[8:0]; datab[4]<= weight_m_4[8:0]; datab[5]<= weight_m_5[8:0];
                    end                         

        default: 
                begin
                    dataa[1]<= 0; dataa[2]<= 0; dataa[3]<= 0; dataa[4]<= 0; dataa[5]<= 0;
                    datab[1]<= 0; datab[2]<= 0; datab[3]<= 0; datab[4]<= 0; datab[5]<= 0;
                end
        
    endcase
end

    genvar i ;
    generate
        for(i=1; i<=5; i=i+1) begin: block1
            MULT_ACCUM	MULT_ACCUM_inst (
                .clock0 ( clk ),
                .dataa ( dataa[i] ),
                .datab ( datab[i] ),//权重
                .result ( result[i] )
                );
        end
    endgenerate

    
endmodule //conv