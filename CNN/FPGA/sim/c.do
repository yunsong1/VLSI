#set the src code home dir;设置源文件目录
set src_home E:/spyder/FPGA/src

#clean the environment and remove trash files
set delfiles [glob work *.qdb *.qtl *qpg _vmake _info]
file delete -force {*}$delfiles

vlib  work
vmap  work ./work
vlog  -incr ${src_home}/*.v
#vlog  -incr ${src_home}/*.sv
vlog  -incr ${src_home}/IP/*.v
#vlog  -incr ${src_home}/System_verilog/*.sv





