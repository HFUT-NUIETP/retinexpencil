function pencil_canvas = DrawCanvasMy4(Illumination_layer);
J=Illumination_layer;
lambda = 0.5; % larger for smoother tonal mappings
texture_resize_ratio = 0.2;
texture_file_name = 'textures/texture.jpg';
% stich pencil texture image
texture = imread(texture_file_name);
texture = texture(100:size(texture,1)-100,100:size(texture,2)-100);
texture = im2double(imresize(texture, texture_resize_ratio*min([size(J,1),size(J,2)])/1024));
Jtexture = vertical_stitch(horizontal_stitch(texture,size(J,2)), size(J,1));
% Jtexture = Jtexture.^(1/1);
% figure;imshow(Jtexture);

%% fast processing
% % by Han Xu 2019/12/19
[hei,wid,ch] = size(J);
% % Dx;Dy;DxDy
fx = [1, -1];
fy = [1; -1];
otfFx = psf2otf(fx,[hei,wid]);   
otfFy = psf2otf(fy,[hei,wid]);
DxDy = abs(otfFy).^2 + abs(otfFx).^2;

LnH = log(Jtexture+0.00001);
LnJ = log(Illumination_layer+0.00001);

Nom = fft2(LnJ./LnH);
Denom = 1 + lambda.* DxDy;
beta1d = real(ifft2(Nom./Denom));
beta = beta1d;
figure;imshow(beta,[]);min_beta=min(beta(:));max_range=max(beta(:));
%%
% figure;
% imshow(beta,[]);
% figure;
% imshow(Jtexture,[]);
% %
% compute the texture tone image 'T' and combine it with the outline sketch
% to come out with the final result 'Ipencil'
thresh = 0.03;
beta(find(beta(:)<thresh))=thresh;
T = Jtexture .^ beta;
% figure;imshow(beta,[]);
figure;imshow(T);
T = (T - min(T(:))) / (max(T(:)) - min(T(:)));


pencil_canvas =T;









end