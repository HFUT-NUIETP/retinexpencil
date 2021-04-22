% clc;
clear;
inputPre = 'D:\公事\研究生有关\韩徐\new_researchFrom201909\fast processing\our_own_data_set20190605\';
image_name = 'paper';

im = im2double(imread([inputPre,image_name,'.jpg']));
tic;
y =  padarray(im,[2*3,2*3,0],'symmetric');

yhsv = rgb2hsv(y);
y_v = yhsv(:,:,3);

[h, w, c] = size(y);

Max_RGB = max(max(y(:,:,1),y(:,:,2)),y(:,:,3));
s = log(y_v + 0.0001);

max_rgb = ordfilt2(Max_RGB,9,ones(3,3));
figure; imshow([Max_RGB,max_rgb]);
max_rgb = guidedfilter(Max_RGB, max_rgb, floor(0.1*max(h,w)), 0.0001);    % use guided filer to refine bright channel

i0 = log(max_rgb + 0.0001);

[i,r] = L2L0(s,i0,0.0001,0.025,0.5,0);   % L2L0(s,i0,lamda,a,b,flag); flag = 1 normal processing; flag = 0 fast processing

R = exp(r);
I = exp(i);

r2 = s-i;
R2 = exp(r2);

enhanced_V = R.*I.^(1/2.2);
enhanced_V2 = R2.*I.^(1/2.2);

result_V = enhanced_V.*(1-I)+enhanced_V2.*I;

yhsv(:,:,3) = result_V;

%fused result
enhanced_result = hsv2rgb(yhsv);
isize = size(enhanced_result);
enhanced_result = enhanced_result(7:isize(1)-6,7:isize(2)-6,:);

yhsv_R = yhsv;
yhsv_R(:,:,3) = R;
R_rgb1 = hsv2rgb(yhsv_R);
R_rgb1 = R_rgb1(7:isize(1)-6,7:isize(2)-6,:);
I = I(7:isize(1)-6,7:isize(2)-6,:);
toc;
figure;imshow([im,enhanced_result]);
figure;imshow([repmat(I,[1,1,3]),R_rgb1]);
% figure;imshow(R);
% figure;imshow(I);

%test how enhanced_V and enhanced_V2 look like?

%fused source 1
yhsv1 = yhsv;
yhsv1(:,:,3) = enhanced_V;
enhanced_inter1 = hsv2rgb(yhsv1);
isize1 = size(enhanced_inter1);
enhanced_inter1 = enhanced_inter1(7:isize1(1)-6,7:isize1(2)-6,:);
figure;imshow([im,enhanced_inter1]);title('direct decomposition of I and R');
%fused source2
yhsv2 = yhsv;
yhsv2(:,:,3) = enhanced_V2;
enhanced_inter2 = hsv2rgb(yhsv2);
isize2 = size(enhanced_inter2);
enhanced_inter2 = enhanced_inter2(7:isize2(1)-6,7:isize2(2)-6,:);
figure;imshow([im,enhanced_inter2]);title('directly obtained I and its residual R');

