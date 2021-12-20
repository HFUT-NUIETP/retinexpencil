function [Jtexture,beta,pencil_canvas] = DrawCanvasMy(Illumination_layer);

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
% figure;
% imshow(beta,[]);
% figure;
% imshow(Jtexture,[]);
% %
% compute the texture tone image 'T' and combine it with the outline sketch
% to come out with the final result 'Ipencil'
T = Jtexture .^ beta;
% figure;imshow(beta,[]);min_beta=min(beta(:));max_range=max(beta(:));
% figure;imshow(T);
T = (T - min(T(:))) / (max(T(:)) - min(T(:)));


pencil_canvas =T;

%% slow version
% ==============================================
% Compute the texture tone drawing 'T'
% ==============================================

% % % stich pencil texture image
% % texture = imread(texture_file_name);
% % texture = texture(100:size(texture,1)-100,100:size(texture,2)-100);
% % texture = im2double(imresize(texture, texture_resize_ratio*min([size(J,1),size(J,2)])/1024));
% % Jtexture = vertical_stitch(horizontal_stitch(texture,size(J,2)), size(J,1));
% % Jtexture = Jtexture.^(1/2.2);
% % figure;imshow(Jtexture);
% % solve for beta
% sizz = size(J,1)*size(J,2); % width of big matrix
% 
% nzmax = 2*(sizz-1);
% i = zeros( nzmax, 1 );
% j = zeros( nzmax, 1 );
% s = zeros( nzmax, 1 );
% for m=1:nzmax
%     i(m) = ceil((m+0.1) / 2);
%     j(m) = ceil((m-0.1) / 2);
%     s(m) = -2*mod(m,2) + 1;
% end
% dx = sparse(i,j,s,sizz,sizz,nzmax);
% 
% nzmax = 2*(sizz - size(J,2));
% i = zeros( nzmax, 1 );
% j = zeros( nzmax, 1 );
% s = zeros( nzmax, 1 );
% for m=1:nzmax
%     if mod(m,2)
%         i(m) = ceil((m+0.1) / 2);
%     else
%         i(m) = ceil((m-1+0.1) / 2) + size(J,2);
%     end
%     j(m) = ceil((m-0.1) / 2);
%     s(m) = -2*mod(m,2) + 1;
% end
% dy = sparse(i,j,s,sizz,sizz,nzmax);
% 
% Jtexture1d = log(reshape(Jtexture',1,[]));
% Jtsparse = spdiags(Jtexture1d',0,sizz,sizz);
% Illumination_layer1d = log(reshape(Illumination_layer',1,[])');
% beta1d = (Jtsparse'*Jtsparse + lambda*(dx'*dx + dy'*dy))\(Jtsparse'*Illumination_layer1d);
% beta = reshape(beta1d, size(J,2), size(J,1))';
% % 
% figure;imshow(beta,[]);
% 
% 
% % compute the texture tone image 'T' and combine it with the outline sketch
% % to come out with the final result 'Ipencil'
% T = Jtexture .^ beta;
% figure;imshow(T);
% % T = (T - min(T(:))) / (max(T(:)) - min(T(:)));
% % figure;imshow(T);
% 
% pencil_canvas =T;








end