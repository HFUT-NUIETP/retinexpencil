function pencil_canvas = DrawCanvasMy3(Illumination_layer);

J=Illumination_layer;
texture_resize_ratio = 0.5;
texture_file_name = 'textures/texture.jpg';
% ==============================================
% Compute the texture tone drawing 'T'
% ==============================================
% new tone adjusted image
% Jadjusted = natural_histogram_matching(J,type);
% Jadjusted = im2double(J);
% stich pencil texture image
texture = imread(texture_file_name);
texture = texture(100:size(texture,1)-100,100:size(texture,2)-100);
texture = im2double(imresize(texture, texture_resize_ratio*min([size(J,1),size(J,2)])/1024));
Jtexture = vertical_stitch(horizontal_stitch(texture,size(J,2)), size(J,1));

Jtexture1 = Jtexture.^(1/3); %dark pencil texture
T1=Illumination_layer.*Jtexture;
Jtexture2 = Jtexture.^(1/12); %light pencil texture
T2=Illumination_layer.*Jtexture2;
pencil_canvas = T2.*(Illumination_layer)+T1.*(1-Illumination_layer);

pencil_canvas = (pencil_canvas - min(pencil_canvas(:))) / (max(pencil_canvas(:)) - min(pencil_canvas(:)));
% figure;imshow([Jtexture1,Jtexture2]);
figure;imshow(pencil_canvas);
dumb=0;










end