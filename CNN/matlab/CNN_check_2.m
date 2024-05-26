clc,clear;

% 读取 .mat 文件
% data = load('E:\spyder\python\project\image_check.mat');
data_in = load('E:\spyder\python\project\data_in.mat');
% 从结构体中提取数据
pt_data = data_in.data_in;
pt_data = squeeze(pt_data);
pt_data = double(pt_data);
% image = data.img;
% image = double(image);
% image = image./255;

% % 读取图片
% image = imread('E:\spyder\python\project\test\3\30.png'); 
% % 调整图片大小为 32x32
% image = imresize(image, [32 32]);
% image = double(image);
% image = image./255;

load('E:\spyder\python\project\weights.mat');
conv1_weight = permute(getfield(weights, 'conv1.weight'), [3, 4, 2, 1]);
conv1_bias   =    reshape(getfield(weights, 'conv1.bias'), [1, 1, 6]);
conv2_weight = permute(getfield(weights, 'conv2.weight'), [3, 4, 2, 1]);
conv2_bias   =    reshape(getfield(weights, 'conv2.bias'), [1, 1, 16]);
fc1_weight   = (getfield(weights, 'fc1.weight'));
fc1_bias     =    transpose(getfield(weights, 'fc1.bias'));
fc2_weight   = (getfield(weights, 'fc2.weight'));
fc2_bias     = transpose(getfield(weights, 'fc2.bias'));
fc3_weight   = (getfield(weights, 'fc3.weight'));
fc3_bias     = transpose(getfield(weights, 'fc3.bias'));


% 创建一个包含 6 个卷积结果的高维数组
convResults = zeros(28, 28, 6);
%6通道的卷积
for i = 1:6
    % 获取当前卷积核
    convKernel_in = conv1_weight(:, :, :, i);
    % 卷积并加上偏置
    convResult = conv2(pt_data, convKernel_in, 'valid') + conv1_bias(i);
    % 将结果保存在高维数组中
    convResults(:, :, i) = convResult;
end

% Relu函数
% convResults = max(convResults, 0);


% 读取 .mat 文件
data = load('E:\spyder\python\project\x_conv1.mat');
% data = load('E:\spyder\python\project\x_conv1_relu.mat');
% data = load('E:\spyder\python\project\x_conv1_relu_max.mat');
% data = load('E:\spyder\python\project\x_conv2.mat');
% data = load('E:\spyder\python\project\x_conv2_relu.mat');
% data = load('E:\spyder\python\project\x_conv2_relu_max.mat');
% data = load('E:\spyder\python\project\x_fc1_relu.mat');
% data = load('E:\spyder\python\project\x_fc2_relu.mat');
% data = load('E:\spyder\python\project\x_fc3.mat');
% 从结构体中提取数据
data = data.x_conv1;
cnn_data = convResults;

% 使用 transpose 函数进行维度转换
check_data = permute(data, [3, 4, 2, 1]);
% 比较两种卷积方式结果是否一致
if isequal(check_data, cnn_data)
    disp("Matrices check_data and cnn_data are equal.");
else
    disp("Matrices check_data and cnn_data are not equal.");
end

test_cnn_data = cnn_data(:,:,1);
test_check_data = check_data(:,:,1);
show_conv1_weight = conv1_weight(:,:,1,1);
show_pt_data = pt_data(8:12,17:21);
show_conv = sum(sum(show_conv1_weight .* show_pt_data)) + conv1_bias(1);


% 创建一个大小为 (14, 14, 6) 的数组，用于保存池化结果
poolingResult = zeros(14, 14, 6);

% 分别对每个维度进行最大池化操作
for i = 1:6
    % 获取当前输入数据
    inputDataSingle = convResults(:, :, i);
    
    % 使用最大池化操作对当前输入数据进行处理
    for row = 1:14
        for col = 1:14
            % 计算池化窗口的起始位置
            startRow = (row - 1) * 2 + 1;
            startCol = (col - 1) * 2 + 1;
            
            % 提取池化窗口内的数据
            windowData = inputDataSingle(startRow:startRow+1, startCol:startCol+1);
            
            % 对池化窗口内的数据取最大值
            poolingResult(row, col, i) = max(windowData(:));
        end
    end
end

% 创建一个大小为 10*10*16 的高维数组
minResults = zeros(10, 10);
finalResults = zeros(10, 10, 16);
% 对每个 14x14 数组进行 16 次卷积，并将结果相加后加上偏置，保存在高维数组中
for i = 1:16
    minResults = zeros(size(minResults));
    for j = 1:6 
        % 获取当前输入数据
        inputDataSingle = poolingResult(:, :, j);

        % 获取当前卷积核
        convKernel = conv2_weight(:, :, j, i);

        % 对当前输入数据进行卷积操作
        convResult = conv2(inputDataSingle, convKernel, 'valid');

        % 将卷积结果保存在高维数组中
        minResults = minResults + convResult;
    end
    % 加上偏置
    finalResults(:, :, i) = minResults + conv2_bias(:, :, i);

end

% Relu函数
finalResults = max(finalResults, 0);

% 创建一个大小为 (5, 5, 16) 的数组，用于保存池化结果
poolingResult_out = zeros(5, 5, 16);

% 分别对每个维度进行最大池化操作
for i = 1:16
    % 获取当前输入数据
    inputDataSingle = finalResults(:, :, i);
    
    % 使用最大池化操作对当前输入数据进行处理
    for row = 1:5
        for col = 1:5
            % 计算池化窗口的起始位置
            startRow = (row - 1) * 2 + 1;
            startCol = (col - 1) * 2 + 1;
            
            % 提取池化窗口内的数据
            windowData = inputDataSingle(startRow:startRow+1, startCol:startCol+1);
            
            % 对池化窗口内的数据取最大值
            poolingResult_out(row, col, i) = max(windowData(:));
        end
    end
end

% 将数组展平为一维数组
data_flattened = reshape(poolingResult_out, 1, []);
data_flattened = transpose(data_flattened);

% 全连接
fc1_out_data = (fc1_weight * data_flattened) + fc1_bias;
% Relu函数
fc1_out_data = max(fc1_out_data, 0);
% 全连接
fc2_out_data = (fc2_weight * fc1_out_data) + fc2_bias;
% Relu函数
fc2_out_data = max(fc2_out_data, 0);
% 全连接
fc3_out_data = (fc3_weight * fc2_out_data) + fc3_bias;

% softmax
fc3_out_data_exp = exp(fc3_out_data);
fc3_out_data_pp = fc3_out_data_exp ./ sum(fc3_out_data_exp);
% fc3_out_data_log = log(fc3_out_data_pp);
% fc3_out_data_log_exp = exp(fc3_out_data_log);
% fc3_out_data_log_log = fc3_out_data_log_exp ./ sum(fc3_out_data_log_exp);







