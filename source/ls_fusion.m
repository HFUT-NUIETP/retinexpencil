clear
filepath = '.\input\';
% filepath = 'D:\Epan\beautiful images\';
% filepath= 'D:\my_research\MTAP_SI_2017_2\my_try_simple\data\';
% filepath= 'D:\my_research\MTAP_SI_2017_2\my_try_simple\data\HQimage\';
% filepath= 'D:\my_research\MTAP_SI_2017_2\my_try_simple\data\HXdata\';
% filepath = 'D:\Epan\jiangnan\';

filename = 'input39.jpg';
full = [filepath,filename];
resize_factor = 1;
Iuint8 = imread(full);
Iuint8 = imresize(Iuint8,resize_factor);%有时候图片比较大，处理耗费时间。所以就缩小。
Iori = im2double(Iuint8);%transfer the matrix to double type，本程序没用到这个变量

% figure
% imshow(Iori);title('original image');

% %只处理v通道
yhsv = rgb2hsv(Iori);
y_gray = yhsv(:,:,3);
y_h = yhsv(:,:,1);
y_s = yhsv(:,:,2);
[width, height] = size(y_gray);
% figure;imshow([y_h,y_s,y_gray]);

% y_YUV = rgb2ycbcr(Iori);
% y_graycbcr = y_YUV(:,:,1);
% 
% figure;imshow([y_grayhsv;y_graycbcr;5*abs(y_grayhsv-y_graycbcr)]);

%%
%对y_gray进行Retinex分解，得到的illumination layer和relectance layer
addpath('C:\Users\leetu\Desktop\fast_code_20191022');
[Illumination_layer, Reflectance_layer] = obtainRetinexDecomposition(Iori);

Illumination_layer = double(Illumination_layer);
Reflectance_layer = double(Reflectance_layer);
isize2 = size(Illumination_layer);
Illumination_layer = Illumination_layer(7:isize2(1)-6,7:isize2(2)-6);
Reflectance_layer = Reflectance_layer(7:isize2(1)-6,7:isize2(2)-6);
Illumination_layerEnhance = Illumination_layer.^(1/2.2);%伽马增强光照层
% figure;imshow([Illumination_layerEnhance,Illumination_layer, Reflectance_layer]);

% Illumination_color = hsv2rgb(cat(3,yhsv(:,:,1:2),Illumination_layer));
% Reflectance_color = hsv2rgb(cat(3,yhsv(:,:,1:2),Reflectance_layer));
% figure;
% imshow([Iori,Illumination_color, Reflectance_color]);

%%
%绘制铅笔线条层
%%%pencil_edge(Reflectance_layer,line_len_divisor,line_thickness_divisor);
%%%line_len_divisor = 60; % larger for a shorter line fragment
%%%line_thickness_divisor = 4; % larger for thiner outline sketches
tic
pencil_edgeOriginalImage = pencil_edge(y_gray,60,4);
pencil_edgeIllumination = pencil_edge(Illumination_layer,60,4);
pencil_edgeIlluminationEnhance = pencil_edge(Illumination_layerEnhance,40,4);
pencil_edgeReflectance = pencil_edge(Reflectance_layer,80,8);
toc
% figure;imshow([pencil_edgeIlluminationEnhance,pencil_edgeIllumination;pencil_edgeReflectance,pencil_edgeOriginalImage]);

%test the combination of the sketch effect
Sketch_Ori = pencil_edgeOriginalImage;
Sketch_Illumination_Reflectance = pencil_edgeIllumination.*pencil_edgeReflectance;
Sketch_IlluminationEnhance_Reflectance = i .* pencil_edgeIlluminationEnhance + (1-i) .* pencil_edgeReflectance;
% figure;imshow([Sketch_IlluminationEnhance_Reflectance,Sketch_Illumination_Reflectance,Sketch_Ori]);

%%
%绘制铅笔纹理层
tic
% [Jtexture,beta,pencil_canvasEnhance] = DrawCanvasMy2(Illumination_layerEnhance);
pencil_canvasEnhance = DrawCanvasMy2(Illumination_layerEnhance);
% [Jtexture,beta,pencil_canvas] = DrawCanvasMy(Illumination_layer);
toc
% figure;imshow([Jtexture,beta,pencil_canvas]);
% figure;imshow([pencil_canvasEnhance,pencil_canvas]);



%%
%用线条画和纹理画合成素描画（仅有灰度）
% pencil_canvasEnhance = Illumination_layerEnhance;
pencil_resultEhance = Sketch_IlluminationEnhance_Reflectance.*pencil_canvasEnhance;
% figure;imshow([Sketch_IlluminationEnhance_Reflectance,pencil_canvasEnhance,pencil_resultEhance]);

%基于原来图像的色彩通道h和s，在结合素描画，形成彩色的铅笔画效果
pencil_result_color = hsv2rgb(cat(3,yhsv(:,:,1:2),pencil_resultEhance));
% pencil_result_color = ycbcr2rgb(cat(3,pencil_resultEhance,y_YUV(:,:,2:3)));
% figure;imshow([Iori,pencil_result_color]);

