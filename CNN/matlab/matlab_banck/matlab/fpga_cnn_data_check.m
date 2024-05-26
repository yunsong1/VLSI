clc;
% 查看当前工作区的变量列表
varList = who;
data = importdata('E:\spyder\FPGA\src\TXT\conv1_data_check.txt');
matlab_data = (eval(varList{49}));
fpga_data = transpose(reshape(data, 28, 28));

% 比较两个数组是否相等
if isequal(matlab_data, fpga_data)
    disp('两个数组相等');
else
    disp('两个数组不相等');
end


