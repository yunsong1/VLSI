#set the src code home dir;设置源文件目录
set src_home E:/quartus/VLSI/DWT/FPGA/src

#clean the environment and remove trash files
#set delfiles [glob work *.qdb *.qtl *qpg _vmake _info]
#file delete -force {*}$delfiles

vlib  work
vmap  work ./work
vlog ${src_home}/*.v
vlog ${src_home}/IP/*.v
vlog ${src_home}/FIR/*.v





