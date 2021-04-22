clear
% filepath = 'D:\my_research\pencil_light\';
% filepath = 'D:\Epan\beautiful images\';
% filepath= 'D:\my_research\MTAP_SI_2017_2\my_try_simple\data\';
% filepath= 'D:\my_research\MTAP_SI_2017_2\my_try_simple\data\HQimage\';
% filepath= 'D:\my_research\MTAP_SI_2017_2\my_try_simple\data\HXdata\';
filepath = '.\input\';
outputfoldpath = 'D:\my_research\toLiTeng\output\';

filename = 'input4.jpg';
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
[width, height] = size(y_gray);
y_h = yhsv(:,:,1);
y_s = yhsv(:,:,2);
% figure;imshow([y_h,y_s,y_gray]);

%%%%%%%%%%%%%%%%%%%%%%
%如果用maxRGB通道来当做y_gray呢？
Max_RGB = max(max(Iori(:,:,1),Iori(:,:,2)),Iori(:,:,3));
y_gray = Max_RGB;
%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%废%%%%%%%%%%%%%%%%%%%%%%%%%%
% %稍微处理平滑一下H和S空间，试试看(改变H通道会带来结果的区域过渡不自然，这样做是不合适的)
% r_smooth=floor(0.005*max(height,width));
% eps_smooth=0.1;
% y_h = guidedfilter(y_h, y_h, r_smooth, eps_smooth); 
% y_s = guidedfilter(y_s, y_s, r_smooth, eps_smooth); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%试试把色彩减弱一些？？？好像管用%%%%%%%%%%
color_scale = 0.8;
y_h = y_h;
y_s = color_scale*y_s;
% figure;imshow([y_h,y_s,y_gray]);
yhsv(:,:,1) = y_h;
yhsv(:,:,2) = y_s;

% y_YUV = rgb2ycbcr(Iori);
% y_graycbcr = y_YUV(:,:,1);
% 
% figure;imshow([y_grayhsv;y_graycbcr;5*abs(y_grayhsv-y_graycbcr)]);

%%
%对y_gray进行Retinex分解，得到的illumination layer和relectance layer
% addpath('D:\my_research\toLiTeng\fast_code_20191022\');
tic
[Illumination_layer, Reflectance_layer] = obtainRetinexDecomposition(Iori);
toc

Illumination_layer = double(Illumination_layer);
Reflectance_layer = double(Reflectance_layer);
isize2 = size(Illumination_layer);
Illumination_layer = Illumination_layer(7:isize2(1)-6,7:isize2(2)-6);
Reflectance_layer = Reflectance_layer(7:isize2(1)-6,7:isize2(2)-6);
Illumination_layerEnhance = Illumination_layer.^(1/5);%伽马增强光照层
% figure;imshow([Illumination_layerEnhance,Illumination_layer, Reflectance_layer]);

v_recover = Illumination_layer.^(1/4).*Reflectance_layer;
image_recover = hsv2rgb(cat(3,yhsv(:,:,1:2),v_recover));
v_degrade = Illumination_layer.^(1/0.5).*Reflectance_layer;
image_degrade = hsv2rgb(cat(3,yhsv(:,:,1:2),v_degrade));
figure;
imshow([image_degrade,image_recover]);
% Illumination_color = hsv2rgb(cat(3,yhsv(:,:,1:2),Illumination_layer));
% Reflectance_color = hsv2rgb(cat(3,yhsv(:,:,1:2),Reflectance_layer));
% figure;
% imshow([Iori,Reflectance_color,Illumination_color ]);


%%
%绘制铅笔线条层
%%%pencil_edge(Reflectance_layer,line_len_divisor,line_thickness_divisor);
%%%line_len_divisor = 60; % larger for a shorter line fragment
%%%line_thickness_divisor = 4; % larger for thiner outline sketches
tic
% pencil_edgeOriginalImage = pencil_edge(y_gray,80,6);%for compare
% pencil_edgeIllumination = pencil_edge(Illumination_layer,80,4);
pencil_edgeIlluminationEnhance = pencil_edge(Illumination_layerEnhance,80,4);
pencil_edgeReflectance = pencil_edge(Reflectance_layer,80,8);

%%%%另一种line实现，会发粗
%%%%pencil_edge1(im, ks, width, dirNum)
% pencil_edgeIllumination = gen_stroke(Illumination_layer,4,1,8);
% pencil_edgeIlluminationEnhance = gen_stroke(Illumination_layerEnhance,4,1,8);
% pencil_edgeReflectance = gen_stroke(Reflectance_layer,4,1,8);


toc
% figure;imshow([pencil_edgeIlluminationEnhance,pencil_edgeIllumination;pencil_edgeReflectance,pencil_edgeOriginalImage]);

%test the combination of the sketch effect
% Sketch_Ori = pencil_edgeOriginalImage;
% Sketch_Illumination_Reflectance = pencil_edgeIllumination.*pencil_edgeReflectance;
Sketch_IlluminationEnhance_Reflectance = pencil_edgeIlluminationEnhance.*pencil_edgeReflectance;
Sketch_IlluminationEnhance_Reflectance = (Sketch_IlluminationEnhance_Reflectance - min(Sketch_IlluminationEnhance_Reflectance(:))) / (max(Sketch_IlluminationEnhance_Reflectance(:)) - min(Sketch_IlluminationEnhance_Reflectance(:)));
Sketch_IlluminationEnhance_Reflectance = Sketch_IlluminationEnhance_Reflectance.^1;
% Sketch_IlluminationEnhance_Reflectance = pencil_edgeIllumination.*pencil_edgeReflectance;
% figure;imshow([Sketch_IlluminationEnhance_Reflectance,Sketch_Illumination_Reflectance]);
% figure;imshow([pencil_edgeIlluminationEnhance,pencil_edgeReflectance,Sketch_IlluminationEnhance_Reflectance]);
% figure;imshow(pencil_edgeIllumination);
figure;imshow(pencil_edgeIlluminationEnhance);
figure;imshow(pencil_edgeReflectance);
figure;imshow(Sketch_IlluminationEnhance_Reflectance);
% figure;imshow([Illumination_layerEnhance]);
% figure;imshow([Illumination_layer]);
% figure;imshow([Reflectance_layer]);

%%
%绘制铅笔纹理层
tic
% [Jtexture,beta,pencil_canvasEnhance] = DrawCanvasMy2(Illumination_layerEnhance);
pencil_canvasEnhance = DrawCanvasMy2(Illumination_layerEnhance);
% pencil_canvasEnhance = DrawCanvasMy4(Illumination_layerEnhance);
% [Jtexture,beta,pencil_canvasEnhance] = DrawCanvasMy(Illumination_layerEnhance);
% pencil_canvasEnhance = DrawCanvasMy3(Illumination_layerEnhance);
toc
% figure;imshow([Jtexture,beta,pencil_canvas]);
% figure;imshow([pencil_canvasEnhance,pencil_canvas]);



%%
%用线条画和纹理画合成素描画（仅有灰度）
% pencil_canvasEnhance = Illumination_layerEnhance;
pencil_resultEhance = Sketch_IlluminationEnhance_Reflectance.*pencil_canvasEnhance;
figure;imshow([Sketch_IlluminationEnhance_Reflectance,pencil_canvasEnhance,pencil_resultEhance]);

%基于原来图像的色彩通道h和s，在结合素描画，形成彩色的铅笔画效果
pencil_result_color = hsv2rgb(cat(3,yhsv(:,:,1:2),pencil_resultEhance));
% pencil_result_color = ycbcr2rgb(cat(3,pencil_resultEhance,y_YUV(:,:,2:3)));
figure;imshow([Iori,pencil_result_color]);
% imwrite(Illumination_layer,[outputfoldpath,filename,'_Illumination_layer3.jpg']);
% imwrite(Reflectance_layer,[outputfoldpath,filename,'_Reflectance_layer3.jpg']);
% imwrite(Sketch_IlluminationEnhance_Reflectance,[outputfoldpath,filename,'_sketch3.png']);
% imwrite(pencil_canvasEnhance,[outputfoldpath,filename,'_canvas.png']);
% imwrite(pencil_resultEhance,[outputfoldpath,filename,'_resultGray3.png']);
% imwrite(pencil_result_color,[outputfoldpath,filename,'_resultColor3.png']);
