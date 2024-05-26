clc;
number = 6;%//1---6//
weight_bias_number = number;%//1---6//

% 调用当前工作区的变量列表
varName1 = 'test_convResults';
data = importdata('E:\spyder\FPGA\src\TXT\conv1_data_check.txt');
conv1_data = eval(varName1);
conv1_data = floor((conv1_data(:,:,weight_bias_number)));
fpga_conv1_data = transpose(reshape(data, 28, 28));
% 比较两个数组是否相等
if isequal(conv1_data, fpga_conv1_data)
    disp('卷积层结果相同');
else
    disp('卷积层结果不同');
end
% 使用 eval 函数调用变量
varName2 = 'test_poolingResult';
data = importdata('E:\spyder\FPGA\src\TXT\pool_data_check.txt');
pool_data = eval(varName2);
pool_data = floor((pool_data(:,:,weight_bias_number)));
fpga_pool_data = transpose(reshape(data, 14, 14));
% 比较两个数组是否相等
if isequal(pool_data, fpga_pool_data)
    disp('池化层结果相同');
else
    disp('池化层结果不同');
end

