#set testbench name;设置顶层仿真module名

vsim -novopt -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  tb_CNN

#do ./wave.do
#add wave tb_CNN/u_CNN/u_gen_5_5/*
#add wave tb_CNN/u_CNN/u_conv/dataa tb_CNN/u_CNN/u_conv/datab tb_CNN/u_CNN/u_conv/* 
add wave tb_CNN/u_CNN/*
#add wave /*

view wave
view structure
view signals

run 300us
#run 3ms

