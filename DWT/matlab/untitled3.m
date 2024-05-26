clc;
% 生成原始信号
fs = 1000; % 采样率
t = 0:1/fs:0.20; % 时间向量
f1 = 10; % 低频信号频率
f2 = 300; % 高频信号频率
org = 0.8*sin(2*pi*f1*t)*128+128;
x = 0.7*sin(2*pi*f1*t) + 0.3*sin(2*pi*f2*t); % 原始信号
x = floor(x *128 + 128);

fid = fopen('signal_data.mif', 'w');
pt_data_mif = x;
% 写入MIF文件的头部信息
depth = length(pt_data_mif);
width = 9;
fprintf(fid, 'WIDTH=%d;\n', width);
fprintf(fid, 'DEPTH=%d;\n', depth);
fprintf(fid, 'ADDRESS_RADIX=DEC;\n');
fprintf(fid, 'DATA_RADIX=BIN;\n');
fprintf(fid, 'CONTENT BEGIN\n');

% 将一维数组逐行写入文件
for i = 1:depth
    binaryData = dec2bin(pt_data_mif(i), width);
    fprintf(fid, '%d : %s;\n', i-1, binaryData);
end

fprintf(fid, 'END;\n');
fclose(fid);

% DWT分解
wavelet = 'db2'; % 小波基函数，这里使用Daubechies-2小波
level = 2; % 分解层数

[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wavelet); 
Lo_D = floor(Lo_D * 256);
Hi_D = floor(Hi_D * 256);
Lo_R = floor(Lo_R * 256);
% Hi_R = floor(Hi_R * 256);

[c1, l1] = wavedec(x, level, wavelet);

% Initialization.
n = level;
in = x(:).'; c = [];
l = zeros(1,n+2,'like',real(in([])));l(end) = length(in);
for k = 1:n
    % [x,d] = dwt(x,Lo_D,Hi_D); % decomposition
    % % % % % % %   
        lf = 4;lx = length(in);
        first = 2;lenEXT = lf-1; 
        last = lx+lf-1;
        y = wextend('1D','sym',in,lenEXT);
        % y = wextend('1D','zpd',in,lenEXT);
        z = floor(wconv1(y,Lo_D,'valid')); 
        a = z(first:2:last);
        a = floor(a./(256));
        
        % Compute coefficients of detail.
        z = floor(wconv1(y,Hi_D,'valid')); 
        d = z(first:2:last);
        d = floor(d./(256));

        in = a;
    % % % % % % % 
    c     = [d c];            %#ok<AGROW> % store detail
    l(n+2-k) = length(d);     % store length
end
% Last approximation.
c = [in c];l(1) = length(in);
c(l(3):end)=0;
% c(1:3)=0;
% c(l(2)-3:l(2))=0;
c_max = max(c);

% % 比较数组大小
% if isequal(l, l1)
%     disp('l数组相同');
% else
%     disp('l数组不同');
% end
% 
% % 比较数组大小
% if isequal(c, c1)
%     disp('c数组相同');
% else
%     disp('c数组不同');
% end

% 重构信号
x_reconstructed = waverec(c, l, wavelet);

% % % % % % %   
t1 = wconv1(dyadup(c(1:l(1)),0),Lo_R);
t1 = t1/256;

% % 读取特定变量的值
% varName1 = 'array';
% data_x = eval(varName1);
% data_x = transpose(data_x(5:5-1+length(t1)));
% data_x = data_x/256;

check_t1 = dyadup(c(1:l(1)),0);
t2 = wconv1(dyadup(t1,0),Lo_R);
t2 = t2/256;

% % 读取特定变量的值
% varName1 = 'array';
% data_x = eval(varName1);
% data_x = transpose(data_x(5:5-1+length(t2)));
% data_x = data_x/256;
% t2 = data_x;


% % % % % % %  
% 计算重构信号与原始信号的差别
difference = org - x_reconstructed;
 
% 绘制结果
figure
subplot(4,1,1);
plot(t, org);
title('原始信号');

subplot(4,1,2);
plot(t, x);
% c(l(3):end)=0;
% plot(c, 'r');
title('带噪信号');

subplot(4,1,3);
% plot(t, x_reconstructed);t2
plot(t, t2(1:201));
title('重构信号');

subplot(4,1,4);
plot(t, difference);
title('差别');







