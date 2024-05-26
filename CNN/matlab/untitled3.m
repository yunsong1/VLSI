% 假设你有一个名为 logits 的大小为 10x1 的数组需要进行处理
logits = randn(10, 1);  % 生成一个大小为 10x1 的随机数组
% 进行指数运算和计算概率
exp_logits = exp(logits);
probabilities = exp_logits / sum(exp_logits);

% 输出结果
disp(probabilities);