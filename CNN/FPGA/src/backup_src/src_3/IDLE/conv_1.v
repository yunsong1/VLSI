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
reg signed [8:0] dataa1,dataa2,dataa3,dataa4,dataa5
reg signed [8:0] datab1,datab2,datab3,datab4,datab5
wire signed [17:0] result1,result2,result3,result4,result5


always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0)
        begin
           dataa1<= 0; dataa2<= 0; dataa3<= 0; dataa4<= 0; dataa5<= 0;
           datab1<= 0; datab2<= 0; datab3<= 0; datab4<= 0; datab5<= 0;
        end 
    else case (state)
                m_1://第一行
                    dataa1<= x_m_1[44:36]; dataa2<= x_m_2[44:36];
                    dataa3<= x_m_3[44:36]; dataa4<= x_m_4[44:36]; dataa5<= x_m_5[44:36]; 

                    datab1<= weight_m_1[44:36]; datab2<= weight_m_2[44:36];
                    datab3<= weight_m_3[44:36]; datab4<= weight_m_4[44:36]; datab5<= weight_m_5[44:36];                     
                m_2:
                    dataa1<= x_m_1[35:27]; dataa2<= x_m_2[35:27];
                    dataa3<= x_m_3[35:27]; dataa4<= x_m_4[35:27]; dataa5<= x_m_5[35:27]; 

                    datab1<= weight_m_1[35:27]; datab2<= weight_m_2[35:27];
                    datab3<= weight_m_3[35:27]; datab4<= weight_m_4[35:27]; datab5<= weight_m_5[35:27];                                       
                m_3:
                    dataa1<= x_m_1[26:18]; dataa2<= x_m_2[26:18];
                    dataa3<= x_m_3[26:18]; dataa4<= x_m_4[26:18]; dataa5<= x_m_5[26:18];   

                    datab1<= weight_m_1[26:18]; datab2<= weight_m_2[26:18];
                    datab3<= weight_m_3[26:18]; datab4<= weight_m_4[26:18]; datab5<= weight_m_5[26:18];                                      
                m_4:
                    dataa1<= x_m_1[17:9]; dataa2<= x_m_2[17:9];
                    dataa3<= x_m_3[17:9]; dataa4<= x_m_4[17:9]; dataa5<= x_m_5[17:9];  

                    datab1<= weight_m_1[17:9]; datab2<= weight_m_2[17:9];
                    datab3<= weight_m_3[17:9]; datab4<= weight_m_4[17:9]; datab5<= weight_m_5[17:9];                                      
                m_5:
                    dataa1<= x_m_1[8:0]; dataa2<= x_m_2[8:0];
                    dataa3<= x_m_3[8:0]; dataa4<= x_m_4[8:0]; dataa5<= x_m_5[8:0];  

                    datab1<= weight_m_1[8:0]; datab2<= weight_m_2[8:0];
                    datab3<= weight_m_3[8:0]; datab4<= weight_m_4[8:0]; datab5<= weight_m_5[8:0];                         

        default: dataa1<= 0; dataa2<= 0; dataa3<= 0; dataa4<= 0; dataa5<= 0;
                 datab1<= 0; datab2<= 0; datab3<= 0; datab4<= 0; datab5<= 0;
        
    endcase
end
MULT_ACCUM	MULT_ACCUM_inst1 (
    .clock0 ( clk ),
    .dataa ( dataa ),//权重
    .datab ( datab ),
    .result ( result )
    );

    
endmodule //conv