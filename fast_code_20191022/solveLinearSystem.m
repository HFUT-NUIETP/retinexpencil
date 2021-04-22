function dst = solveLinearSystem(s1, i0, uvx, uvy, alp, bet)

    [h, w] = size(s1);
    hw = h * w;
    %% calculate the five-point positive definite Laplacian matrix
    uvx = uvx(:);
    uvy = uvy(:);
    ux = padarray(uvx, h, 'pre'); ux = ux(1:end-h);
    uy = padarray(uvy, 1, 'pre'); uy = uy(1:end-1);
    D = uvx+ux+uvy+uy;
    T = spdiags([-uvx, -uvy],[-h,-1],hw,hw);

    M = T + T' + spdiags(D, 0, hw, hw);    
    
    DEN = (1+bet) .* speye(hw,hw) + alp .* M;  
    NUM = s1 + bet .* i0;                           
    %% solve
    if exist('ichol','builtin')
        L = ichol(DEN,struct('michol','on'));  
        [dst,~] = pcg(DEN, NUM(:), 0.01, 100, L, L'); 
        dst = reshape(dst, h, w);
    else
        dst = s1;
        dst = (DEN\NUM(:));
        dst = reshape(dst, h, w);
end