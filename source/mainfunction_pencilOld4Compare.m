clear
% filepath = 'D:\Epan\beautiful images\';
% filepath = 'D:\Epan\jiangnan\';
filepath = 'D:\my_research\pencil_light\';
% filepath= 'D:\my_research\MTAP_SI_2017_2\my_try_simple\data\';
filename = 'input46.jpg';
outputfoldpath = 'D:\my_research\pencil_light\result\';


full = [filepath,filename];
resize_factor = 1;
Iuint8 = imread(full);
Iuint8 = imresize(Iuint8,resize_factor);%有时候图片比较大，处理耗费时间。所以就缩小。
Iori = im2double(Iuint8);%transfer the matrix to double type，本程序没用到这个变量

% figure
% imshow(Iori);title('original image');

%只处理v通道
yhsv = rgb2hsv(Iori);
y_gray = yhsv(:,:,3);

%%%%%%%%%%%%%%试试把色彩减弱一些？？？%%%%%%%%%%
y_h = yhsv(:,:,1);
y_s = yhsv(:,:,2);
color_scale = 0.8;
y_h = y_h;
y_s = color_scale*y_s;
% figure;imshow([y_h,y_s,y_gray]);
yhsv(:,:,1) = y_h;
yhsv(:,:,2) = y_s;

%%
%绘制铅笔线条画
line_len_divisor = 40; % larger for a shorter line fragment
line_thickness_divisor = 8; % larger for thiner outline sketches
tic
pencil_edge = pencil_edge(y_gray,line_len_divisor,line_thickness_divisor);
toc
% figure;imhist(pencil_edge);

%%
%绘制铅笔纹理画
% tic
% pencil_canvas = DrawCanvasFast(Iuint8);
% toc
tic
pencil_canvas = DrawCanvas(Iuint8);
toc
% figure;imhist(pencil_canvas);

%%
%用线条画和纹理画合成素描画（仅有灰度）
pencil_result_gray = pencil_edge.*pencil_canvas;
figure;imshow([pencil_edge,pencil_canvas,pencil_result_gray]);
%%
%基于原来图像的色彩通道h和s，在结合素描画，形成彩色的铅笔画效果
pencil_result_color = hsv2rgb(cat(3,yhsv(:,:,1:2),pencil_result_gray));
figure;imshow([Iori,pencil_result_color]);
imwrite(pencil_edge,[outputfoldpath,filename,'_sketch2.png']);
imwrite(pencil_result_gray,[outputfoldpath,filename,'_resultGray2.png']);
imwrite(pencil_result_color,[outputfoldpath,filename,'_resultColor2.png']);


