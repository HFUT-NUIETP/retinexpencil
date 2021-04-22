function S = sketch_gen_dirnum(I, length_para, thick_para, dir_num)

% line_len_divisor = 40; % larger for a shorter line fragment
line_len_divisor = length_para; % larger for a shorter line fragment
% line_thickness_divisor = 8; % larger for thiner outline sketches
line_thickness_divisor = thick_para; % larger for thiner outline sketches

if length(size(I)) == 3
    J = rgb2gray(I);
    type = 'black';
else
    J = I;
    type = 'colour';
end

line_len_double = min([size(J,1), size(J,2)]) / line_len_divisor;
if mod(floor(line_len_double), 2)
    line_len = floor(line_len_double);
else
    line_len = floor(line_len_double) + 1;
end
half_line_len = (line_len + 1) / 2;

% compute the image gradient 'Imag'
Ix = conv2(im2double(J), [1,-1;1,-1], 'same');
Iy = conv2(im2double(J), [1,1;-1,-1], 'same');
Imag = sqrt(Ix.*Ix + Iy.*Iy);

% create the dir_num directional line segments L
L = zeros(line_len, line_len, dir_num);
for n=0:(dir_num - 1) / 2
    for x=1:line_len
        y = half_line_len - round((x-half_line_len)*tan(pi/dir_num*n));
        if y > 0 && y <= line_len
            L(y, x, n+1) = 1;
        end
    end
    L(:,:,n+1+(dir_num / 2)) = rot90(L(:,:,n+1));
end

% add some thickness to L
valid_width = size(conv2(L(:,:,1),ones(round(line_len/line_thickness_divisor)),'valid'), 1);
Lthick = zeros(valid_width, valid_width, dir_num);
for n=1:dir_num
    Ln = conv2(L(:,:,n),ones(round(line_len/line_thickness_divisor)), 'valid');
    Lthick(:,:,n) = Ln / max(max(Ln));
end

% create the sketch
G = zeros(size(J,1), size(J,2), dir_num);
for n=1:dir_num
    G(:,:,n) = conv2(Imag, L(:,:,n), 'same');
end

[Gmax, Gindex] = max(G, [], 3);
C = zeros(size(J,1), size(J,2), dir_num);
for n=1:dir_num
    C(:,:,n) = Imag .* (Gindex == n);
end

Spn = zeros(size(J,1), size(J,2), dir_num);
for n=1:dir_num
    Spn(:,:,n) = conv2(C(:,:,n), Lthick(:,:,n), 'same');
end
Sp = sum(Spn, 3);
Sp = (Sp - min(Sp(:))) / (max(Sp(:)) - min(Sp(:)));
S = 1 - Sp;