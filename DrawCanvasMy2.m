function pencil_canvas = DrawCanvasMy2(Illumination_layer)

J=Illumination_layer;
texture_resize_ratio = 1;
texture_file_name = 'textures/texture.jpg';

texture = imread(texture_file_name);
texture = texture(100:size(texture,1)-100,100:size(texture,2)-100);
texture = im2double(imresize(texture, texture_resize_ratio*min([size(J,1),size(J,2)])/1024));
Jtexture = vertical_stitch(horizontal_stitch(texture,size(J,2)), size(J,1));

%%
%my try
% Jtexture = Jtexture.^(1/15);
% % figure;imshow(Jtexture);
% pencil_canvas=Illumination_layer.*Jtexture;
% % pencil_canvas=pencil_canvas./(mean(Jtexture(:)));
% pencil_canvas = (pencil_canvas - min(pencil_canvas(:))) / (max(pencil_canvas(:)) - min(pencil_canvas(:)));
% dumb=0;

%%
%hanxu try

Jtexture1 = Jtexture.^(1/12);
T1=Illumination_layer.*Jtexture1;
T1 = (T1 - min(T1(:))) / (max(T1(:)) - min(T1(:)));

Jtexture2 = Jtexture.^(1/6);
% Jtexture2 = Jtexture.^(1/20);
T2=Illumination_layer.*Jtexture2;
T2 = (T2 - min(T2(:))) / (max(T2(:)) - min(T2(:)));

Illumination_layer = Illumination_layer.^5;
T = T2.*(Illumination_layer)+T1.*(1-Illumination_layer);
pencil_canvas = T;
% pencil_canvas = (pencil_canvas - min(pencil_canvas(:))) / (max(pencil_canvas(:)) - min(pencil_canvas(:)));
figure;imshow([Jtexture,Jtexture1,Jtexture2]);
% figure;imshow([T1,T2,T]);
% figure;imshow([pencil_canvas]);
dumb=0;
end