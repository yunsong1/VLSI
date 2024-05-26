#set testbench name;设置顶层仿真module名

# 设置仿真内存大小为4GB
#vish -memory_size 1GB

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  tb_DWT

#do ./wave.do 
#add wave tb_data_gen/u_data_gen/*
#add wave tb_DWT_1/u_DWT_1/u_FIR/u_y_6k/*
#add wave tb_DWT_1/u_DWT_1/*
add wave tb_DWT/u_DWT/*
#add wave /*

view wave
view structure
view signals

run 30us
#run 3ms

