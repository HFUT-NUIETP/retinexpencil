function PencilEdge = pencil_edge(J,line_len_divisor,line_thickness_divisor)

% line_len_divisor = 40; % larger for a shorter line fragment
% line_thickness_divisor = 2; % larger for thiner outline sketches
% ================================================
% Compute the outline sketch 'S'
% ================================================
% calculate 'line_len', the length of the line segments
line_len_double = min([size(J,1), size(J,2)]) / line_len_divisor;
if mod(floor(line_len_double), 2)
    line_len = floor(line_len_double);
else
    line_len = floor(line_len_double) + 1;
end
half_line_len = (line_len + 1) / 2;

% compute the image gradient 'Imag'
Ix = conv2(J, [1,-1;1,-1], 'same');
Iy = conv2(J, [1,1;-1,-1], 'same');
Imag = sqrt(Ix.*Ix + Iy.*Iy);

% create the 8 directional line segments L
L = zeros(line_len, line_len, 8);
for n=0:7
    if n == 0 || n == 1 || n == 2 || n == 7
        for x=1:line_len
            y = half_line_len - round((x-half_line_len)*tan(pi/8*n));
            if y > 0 && y <= line_len
                L(y, x, n+1) = 1;
            end
        end
        if n == 0 || n == 1 || n == 2
            L(:,:,n+5) = rot90(L(:,:,n+1));
        end
    end
end
L(:,:,4) = rot90(L(:,:,8), 3);

% add some thickness to L
valid_width = size(conv2(L(:,:,1),ones(round(line_len/line_thickness_divisor)),'valid'), 1);
Lthick = zeros(valid_width, valid_width, 8);
for n=1:8
    Ln = conv2(L(:,:,n),ones(round(line_len/line_thickness_divisor)), 'valid');
    Lthick(:,:,n) = Ln / max(max(Ln));
end

% create the sketch
G = zeros(size(J,1), size(J,2), 8);
for n=1:8
    G(:,:,n) = conv2(Imag, L(:,:,n), 'same');
end

[Gmax, Gindex] = max(G, [], 3);
C = zeros(size(J,1), size(J,2), 8);
for n=1:8
    C(:,:,n) = Imag .* (Gindex == n);
end

Spn = zeros(size(J,1), size(J,2), 8);
for n=1:8
    Spn(:,:,n) = conv2(C(:,:,n), Lthick(:,:,n), 'same');
end
Sp = sum(Spn, 3);
Sp = (Sp - min(Sp(:))) / (max(Sp(:)) - min(Sp(:)));
S = 1 - Sp;

PencilEdge = S;


end