test = [ -3.5296,  16.6692, -11.8010, -12.7708,  -5.9760, ...
 -21.3840, -10.7454 , 1.5397,  -0.1692,  -3.4449];
test_exp = exp(test);
test_log = test_exp ./ sum(test_exp);
% Relu函数
test_relu = max(test, 0);

A = [1 2 3; 4 5 6; 7 8 9];
B = [10 11 12; 13 14 15; 16 17 18];

C = A + B;
% disp(C);
minResults = rand(2, 2);
minResults1 = minResults + [2 1;3 1];
% minResults = zeros(size(minResults));


B = randn(3, 2, 2);
B_1 = max(B, 0);

% 读取 .mat 文件
x_conv1_relu_data = load('E:\spyder\python\project\x_conv1_relu.mat');
% 从结构体中提取数据
x_conv1_relu = x_conv1_relu_data.x_conv1_relu;
% 使用 transpose 函数进行维度转换
x_conv1_relu = permute(x_conv1_relu, [3, 4, 2, 1]);

% 比较两种卷积方式结果是否一致
if isequal(x_conv1_relu, convResults)
    disp("Matrices conv1_output and convResults are equal.");
else
    disp("Matrices conv1_output and convResults are not equal.");
end

test_convResults = convResults(:,:,6);
test_x_conv1_relu = x_conv1_relu(:,:,1);





