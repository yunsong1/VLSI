clc,clear;
% 生成原始信号
fs = 1000; % 采样率
t = 0:1/fs:0.20; % 时间向量
f1 = 10; % 低频信号频率
f2 = 400; % 高频信号频率
org = 0.8*sin(2*pi*f1*t)*128+128;
x = 0.8*sin(2*pi*f1*t) + 0.2*sin(2*pi*f2*t); % 原始信号
x = floor(x *128 + 128);
max_x = max(x);

% DWT分解
wavelet = 'db2'; % 小波基函数，这里使用Daubechies-2小波
level = 2; % 分解层数

[c, l] = wavedec(x, level, wavelet);
c(l(2):end)=0;

% [Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wavelet); 
% cd1=conv2(x,Hi_D,'valid');
% ca1=conv2(x,Lo_D,'valid');
% cd2=conv2(ca1,Hi_D,'valid');
% ca2=conv2(ca1,Lo_D,'valid');

% d1 = wrcoef('d',c,l,'db2',1);

% 重构信号
x_reconstructed = waverec(c, l, wavelet);

% 计算重构信号与原始信号的差别
% difference = org - x_reconstructed;

% % 绘制结果
% figure
% subplot(4,1,1);
% plot(t, org);
% title('原始信号');
% 
% subplot(4,1,2);
% plot(t, x);
% % c(l(3):end)=0;
% % plot(c, 'r');
% title('带噪信号');
% 
% subplot(4,1,3);
% plot(t, x_reconstructed);
% title('重构信号');
% 
% subplot(4,1,4);
% plot(t, difference);
% title('差别');