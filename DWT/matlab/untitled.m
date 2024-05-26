clc;
% 生成原始信号
fs = 1000; % 采样率
t = 0:1/fs:1; % 时间向量
f1 = 10; % 低频信号频率
f2 = 10; % 高频信号频率
x = sin(2*pi*f1*t) + sin(2*pi*f2*t); % 原始信号

% 添加噪声
SNR = 10; % 信噪比
noise = randn(size(x)); % 高斯白噪声
noise = noise / norm(noise) * norm(x) / 10^(SNR/20); % 根据信噪比调整噪声幅度
x_noisy = x + noise; % 带噪信号

% DWT分解
wavelet = 'db4'; % 小波基函数，这里使用Daubechies-4小波
level = 2; % 分解层数

[c, l] = wavedec(x_noisy, level, wavelet);

% 计算阈值
THR=thselect(x,'rigrsure');

% 使用阈值对小波系数进行阈值处理
cT = wthresh(c, 'h', THR);

% 重构信号
x_reconstructed = waverec(cT, l, wavelet);

% 计算重构信号与原始信号的差别
difference = x - x_reconstructed;

% 绘制结果
subplot(4,1,1);
plot(t, x);
title('原始信号');

subplot(4,1,2);
plot(t, x_noisy);
title('带噪信号');

subplot(4,1,3);
plot(t, x_reconstructed);
title('重构信号');

subplot(4,1,4);
plot(t, difference);
title('差别');