clear; clc;

filepath = '.\input\';
addpath('./fast_code_20191022/');
time = 0;
iter = 0;
for i = 1: 40
filename = strcat('input', num2str(i), '.jpg');
full = [filepath,filename];
resize_factor = 1;
Iuint8 = imread(full);
Iuint8 = imresize(Iuint8,resize_factor);%有时候图片比较大，处理耗费时间。所以就缩小。
Iori = im2double(Iuint8);%transfer the matrix to double type，本程序没用到这个变量

Iori = imresize(Iori,[160,160],'nearest');


[Illumination_layer, Reflectance_layer, it, time_tmp] = retinex_time_cost(Iori);
time_temp = time_tmp;
iter = iter +  it;
time = time + time_temp;
end

result = time / iter;