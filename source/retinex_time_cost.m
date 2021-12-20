function [Illumination_layer, Relecance_layer, itt, time] = retinex_time_cost(im)

tic;
y =  padarray(im,[2*3,2*3,0],'symmetric');

yhsv = rgb2hsv(y);
y_v = yhsv(:,:,3);
% y_YUV = rgb2ycbcr(y);
% y_v = y_YUV(:,:,1);

[h, w, c] = size(y);

Max_RGB = max(max(y(:,:,1),y(:,:,2)),y(:,:,3));
s = log(y_v + 0.01);

max_rgb = ordfilt2(Max_RGB,9,ones(3,3));
% figure; imshow([Max_RGB,max_rgb]);
max_rgb = guidedfilter(Max_RGB, max_rgb, floor(0.1*max(h,w)), 0.0001);    % use guided filer to refine bright channel

i0 = log(max_rgb + 0.0001);
% a如果很小，则分解出的光照图则跟原图差不多;如果a交大，则分解出的光照层就近乎于卡通化效果
% [i,r] = L2L0(s,i0,0.0005,0.025,0.5,0);   % L2L0(s,i0,lamda,a,b,flag); flag = 1 normal processing; flag = 0 fast processing
tic;
[i,r, it] = L2L0(s,i0,0.001,0.02,0.5,0);   % L2L0(s,i0,lamda,a,b,flag); flag = 1 normal processing; flag = 0 fast processing
time = toc;
Relecance_layer = exp(r);
Illumination_layer = exp(i);

itt = it;



end



