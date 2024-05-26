onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/clk
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/rstn
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/relu_valid
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/relu_data
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/gen_2_2_valid
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/x_m_1
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/x_m_2
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/rdreq
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/q
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/valid_cnt
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/rd_flag
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/q_d
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/relu_data_d
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/relu_data_d1
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/rd_cnt_hor
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/rd_cnt_ver
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_gen_2_2/valid_reg
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/clk
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/rstn
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/valid
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/x_m_1
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/x_m_2
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/compare_valid
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/data
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/x_1_1
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/x_1_2
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/x_2_1
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/x_2_2
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/reg_data_1
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/reg_data_2
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/reg_data
add wave -noupdate -radix decimal /tb_maxpool/u_maxpool/u_compare/reg_valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1235000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits ps
update
WaveRestoreZoom {841250 ps} {1628750 ps}
