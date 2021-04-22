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
Iuint8 = imresize(Iuint8,resize_factor);%��ʱ��ͼƬ�Ƚϴ󣬴���ķ�ʱ�䡣���Ծ���С��
Iori = im2double(Iuint8);%transfer the matrix to double type��������û�õ��������

% figure
% imshow(Iori);title('original image');

%ֻ����vͨ��
yhsv = rgb2hsv(Iori);
y_gray = yhsv(:,:,3);

%%%%%%%%%%%%%%���԰�ɫ�ʼ���һЩ������%%%%%%%%%%
y_h = yhsv(:,:,1);
y_s = yhsv(:,:,2);
color_scale = 0.8;
y_h = y_h;
y_s = color_scale*y_s;
% figure;imshow([y_h,y_s,y_gray]);
yhsv(:,:,1) = y_h;
yhsv(:,:,2) = y_s;

%%
%����Ǧ��������
line_len_divisor = 40; % larger for a shorter line fragment
line_thickness_divisor = 8; % larger for thiner outline sketches
tic
pencil_edge = pencil_edge(y_gray,line_len_divisor,line_thickness_divisor);
toc
% figure;imhist(pencil_edge);

%%
%����Ǧ������
% tic
% pencil_canvas = DrawCanvasFast(Iuint8);
% toc
tic
pencil_canvas = DrawCanvas(Iuint8);
toc
% figure;imhist(pencil_canvas);

%%
%���������������ϳ����軭�����лҶȣ�
pencil_result_gray = pencil_edge.*pencil_canvas;
figure;imshow([pencil_edge,pencil_canvas,pencil_result_gray]);
%%
%����ԭ��ͼ���ɫ��ͨ��h��s���ڽ�����軭���γɲ�ɫ��Ǧ�ʻ�Ч��
pencil_result_color = hsv2rgb(cat(3,yhsv(:,:,1:2),pencil_result_gray));
figure;imshow([Iori,pencil_result_color]);
imwrite(pencil_edge,[outputfoldpath,filename,'_sketch2.png']);
imwrite(pencil_result_gray,[outputfoldpath,filename,'_resultGray2.png']);
imwrite(pencil_result_color,[outputfoldpath,filename,'_resultColor2.png']);


