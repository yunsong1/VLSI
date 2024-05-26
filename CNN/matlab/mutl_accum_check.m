clear,clc;
dataa = importdata('E:\spyder\FPGA\src\TXT\a.txt');
datab = importdata('E:\spyder\FPGA\src\TXT\b.txt');
result = zeros(2998,1);
for i=2:size(dataa)
    mult=dataa(i-1)*datab(i-1);
    result(i) = result(i-1) + mult;
end    