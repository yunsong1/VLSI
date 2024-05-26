clc,clear;

% 读取图片
image = imread('test_1.png'); 
% 调整图片大小为 32x32
image = imresize(image, [32 32]);
% image = double(image);
% image = image./255;
% imshow(image);

load('weights.mat');
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

image(30,30)=200;%测试窗口
image(3,30)=200;
image(30,3)=200;
image(3,3)=200;
windowSize = 5;  % 窗口大小为 5x5

matrix = randi([0, 255], 32, 32);  % 生成一个随机的 32x32 矩阵作为示例
outputMatrix = zeros(28, 28);  % 创建 28x28 的输出矩阵
convKernel = [1 0 0 0 0;1 0 0 0 0;1 0 0 0 0;1 0 0 0 0;1 0 0 0 0];  % 5x5 卷积核示例

% for循环实现卷积
for i = 1 : size(matrix, 1) - windowSize + 1
    for j = 1 : size(matrix, 2) - windowSize + 1
        window = matrix(i : i + windowSize - 1, j : j + windowSize - 1);
        convResult = conv2(window, convKernel, 'valid');  % 进行卷积操作
        outputMatrix(i, j) = convResult;  % 将卷积结果的中心值放入输出矩阵
    end
end

% 函数实现卷积
convImage = conv2(matrix, convKernel, 'valid') + 1;

% % 比较两种卷积方式结果是否一致
% if isequal(outputMatrix, convImage)
%     disp("Matrices outputMatrix and convImage are equal.");
% else
%     disp("Matrices outputMatrix and convImage are not equal.");
% end

% 创建一个包含 6 个卷积结果的高维数组
convResults = zeros(28, 28, 6);
%6通道的卷积
for i = 1:6
    % 获取当前卷积核
    convKernel_in = conv1_weight(:, :, :, i);
    % 卷积并加上偏置
    convResult = conv2(image, convKernel_in, 'valid') + conv1_bias(i);
    % 将结果保存在高维数组中
    convResults(:, :, i) = convResult;
end

test_convResults = convResults(:,:,6);

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

test_poolingResult = poolingResult(:,:,6);

% 创建一个大小为 10*10*16 的高维数组
finalResults = zeros(10, 10, 16);

% 对每个 14x14 数组进行 16 次卷积，并将结果相加后加上偏置，保存在高维数组中
for i = 1:16
    for j = 1:6
        % 获取当前输入数据
        inputDataSingle = poolingResult(:, :, j);

        % 获取当前卷积核
        convKernel = conv2_weight(:, :, j, i);

        % 对当前输入数据进行卷积操作
        convResult = conv2(inputDataSingle, convKernel, 'valid');

        % 将卷积结果保存在高维数组中
        finalResults(:, :, i) = finalResults(:, :, i) + convResult;
    end

    % 加上偏置
    finalResults(:, :, i) = finalResults(:, :, i) + conv2_bias(:, :, i);
end

% test_conv2_weight = conv2_weight(:, :, 6, 16);
% test_convResult = conv2(test_poolingResult, test_conv2_weight, 'valid');
% % 比较卷积结果是否一致
% if isequal(convResult, test_convResult)
%     disp("Matrices convResult and test_convResult are equal.");
% else
%     disp("Matrices convResult and test_convResult are not equal.");
% end

% test_convKernel_1 = conv2_weight(:, :, 1, 1);
% test_convKernel_2 = conv2_weight(:, :, 2, 1);
% test_convKernel_3 = conv2_weight(:, :, 3, 1);
% test_convKernel_4 = conv2_weight(:, :, 4, 1);
% test_convKernel_5 = conv2_weight(:, :, 5, 1);
% test_convKernel_6 = conv2_weight(:, :, 6, 1);
% 
% test_inputDataSingle_1 = poolingResult(:,:,1);
% test_inputDataSingle_2 = poolingResult(:,:,2);
% test_inputDataSingle_3 = poolingResult(:,:,3);
% test_inputDataSingle_4 = poolingResult(:,:,4);
% test_inputDataSingle_5 = poolingResult(:,:,5);
% test_inputDataSingle_6 = poolingResult(:,:,6);
% 
% test_conv2_1 = conv2(test_inputDataSingle_1, test_convKernel_1, 'valid');
% test_conv2_2 = conv2(test_inputDataSingle_2, test_convKernel_2, 'valid');
% test_conv2_3 = conv2(test_inputDataSingle_3, test_convKernel_3, 'valid');
% test_conv2_4 = conv2(test_inputDataSingle_4, test_convKernel_4, 'valid');
% test_conv2_5 = conv2(test_inputDataSingle_5, test_convKernel_5, 'valid');
% test_conv2_6 = conv2(test_inputDataSingle_6, test_convKernel_6, 'valid');
% 
% test_conv2 = test_conv2_1 + test_conv2_2 +test_conv2_3 + ...
%              test_conv2_4 + test_conv2_5 +test_conv2_6 + conv2_bias(:, :, 1);
% 
% % 比较卷积结果是否一致
% if isequal(test_conv2, finalResults(:, :, 1))
%     disp("Matrices test_conv2 and finalResults are equal.");
% else
%     disp("Matrices test_conv2 and finalResults are not equal.");
% end




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

% test_poolingResult = poolingResult_out(:,:,16);
% test_finalResultsout = finalResults(:, :, 16);


% 将数组展平为一维数组
data_flattened = reshape(poolingResult_out, 1, []);
data_flattened = transpose(data_flattened);

fc1_out_data = (fc1_weight * data_flattened) + fc1_bias;
fc2_out_data = (fc2_weight * fc1_out_data) + fc2_bias;
fc3_out_data = (fc3_weight * fc2_out_data) + fc3_bias;










