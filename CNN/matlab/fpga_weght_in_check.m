clc;
% 创建一个 5x5x1x6 的数组
A = rand(5, 2, 1, 6);

% 使用 reshape 函数将数组展平为一维行向量数组
AB = permute(A,[2, 1, 3, 4]);
BA = reshape(AB, 1, []);%正确的顺序
B = reshape(A, 1, []);

% 查看当前工作区的变量列表
varList = who;
% disp(varList);
% 读取特定变量的值
valueX = transpose(eval(varList{52}));
data = importdata('E:\spyder\FPGA\src\weights_in.txt');

% 比较两个数组是否相等
if isequal(valueX, data)
    disp('两个数组相等');
else
    disp('两个数组不相等');
end