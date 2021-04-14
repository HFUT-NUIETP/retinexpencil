%% Params
mode = "color"; % # is test mode, "color" or "gray" or "decom"
resize_factor = 0.5;
filename = 'input4.jpg';
filepath = 'input\';
outputfoldpath = 'output\';

%% Preprocessing
full = [filepath,filename];
Iuint8 = imread(full);
Iuint8 = imresize(Iuint8,resize_factor);
Iori = im2double(Iuint8);

file_name_cell = split(filename, '.');
file_name = file_name_cell{1};
file_type = file_name_cell{2};

%% Method
[out1, out2] = method(Iuint8, mode);

%% Plot and Save
imwrite(Iori, strcat(outputfoldpath, file_name, '_ori', '.', file_type));
if mode == "decom"
    figure;imshow([Iori, out1, out2]);title('ori & illu & ref');
    imwrite(out1, strcat(outputfoldpath, file_name, '_illu', '.', file_type));
    imwrite(out2, strcat(outputfoldpath, file_name, '_ref', '.', file_type));
elseif mode == "gray"
    figure;imshow([Iori, out1]);title('ori & gray');
    imwrite(out1, strcat(outputfoldpath, file_name, '_gray', '.', file_type));
elseif mode == "color"
    figure;imshow([Iori, out1]);title('ori & color');
    imwrite(out1, strcat(outputfoldpath, file_name, '_color', '.', file_type));
end
