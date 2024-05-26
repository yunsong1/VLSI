clc;
% data_x = load('E:\quartus\VLSI\DWT\FPGA\src\TXT\x_in.txt');
% data_y = load('E:\quartus\VLSI\DWT\FPGA\src\TXT\y_k.txt');
% data = load('E:\quartus\VLSI\DWT\FPGA\sim\data.txt');
data = load('E:\quartus\VLSI\DWT\FPGA\src\TXT\down_data.txt');
array = zeros(201+3, 1);%300行，1列

% 读取特定变量的值
varName1 = 'x';
data_x = eval(varName1);
data_x = data;
% data_x = wextend('1D','zpd',data_x,3);

% C0=1;C1=1;C2=2;C3=3;
% C0=-124;C1=214;C2=-58;C3=-34;%Hi_D
% C0=-34;C1=57;C2=214;C3=123;%Lo_D
C0=123;C1=214;C2=57;C3=-34;%Lo_R

% 显示数组内容
for i = 4:numel(data_x)
    array(i)=C0*data_x(i)+C1*data_x(i-1)+C2*data_x(i-2)+C3*data_x(i-3);
end

% array = floor(array./256);

% Lo_D = [-1,-1,-2,3];
% array = floor(wconv1(data_x,Lo_D,'valid'));