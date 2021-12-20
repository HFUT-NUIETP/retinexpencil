function [i,r, it_tmp] = L2L0(s,i0,lambda,a,b,flag)
    %% maximum iterations  
    iter = 20;
    %% input image size
    [hei,wid,ch] = size(s);

    %% Dx;Dy;DxDy
    fx = [1, -1];
    fy = [1; -1];
    otfFx = psf2otf(fx,[hei,wid]);   
    otfFy = psf2otf(fy,[hei,wid]);
    DxDy = abs(otfFy).^2 + abs(otfFx).^2;
    %% initialization 
    E = zeros(hei,wid*2);
    L = zeros(hei,wid*2);
    C = zeros(hei,wid);
    D = zeros(hei,wid);
    T1 = zeros(hei,wid);
    T2 = zeros(hei,wid);
    i = s;
    r = zeros(size(s)); 
    ro1 = 1;
    ro2 = 1;
    
    for it = 1:iter
        prei = i;
        prer = r;

        %% for i
        i1 = s-r;
        %% normal processing
        if (flag == 1)
            [ux,uy] = computeWeights(i,1,0.0001,flag);
            i = solveLinearSystem(i1,i0,ux,uy,a,b);
        else
        %% fast processing
             [ux,uy] = computeWeights(i,1,0.0001,flag);
             Nomi_i = fft2(2.*(i1)+2.*b.*i0) + ro1 * conj(otfFx) .* fft2(C - T1./ro1) + ro1 * conj(otfFy) .* fft2(D - T2./ro1);
             Denomi_i = 2 + 2 .* b + ro1 .* DxDy;
             i = real(ifft2(Nomi_i./Denomi_i));
         %% Dxi,Dyi
             GradxB = -imfilter(i,fx,'circular');
             GradyB = -imfilter(i,fy,'circular'); 
         %% for C,D
             BB1 = GradxB + T1./ro1;
             BB2 = GradyB + T2./ro1;
             C_new = sign(BB1) .* max(abs(BB1) - a.*ux.*1./ro1 ,0);
             D_new = sign(BB2) .* max(abs(BB2) - a.*uy.*1./ro1 ,0);
         %% for T1,T2
             T1_new = T1 + ro1 * (GradxB - C_new);    
             T2_new = T2 + ro1 * (GradyB - D_new);
         
         %% update T1,T2,C,D,ro1
             T1 = T1_new;
             T2 = T2_new;
             C = C_new;
             D = D_new;
             ro1 = 2 * ro1;
        end
         



%         i = max(i,s);
        %% for r
        %%
        r1 = s - i;


        EL = E + L./ro2;

        E1L3 = EL(:,1:wid);
        E2L4 = EL(:,1+wid:end);

        Nomi_r = fft2(r1) + ro2/2.*conj(otfFx).*fft2(E1L3) + ro2/2.*conj(otfFy).*fft2(E2L4);
        Denomi_r = 1 + (ro2/2) .* DxDy;
        r = real(ifft2(Nomi_r./Denomi_r));
%         r = min(r,0);
        %% Dr = [Dxr,Dyr]
        Diffr = [-imfilter(r,fx,'circular'),-imfilter(r,fy,'circular')];
        %% for E
        BL = Diffr - L./ro2;
        E_new = BL;
        temp = BL.^2;
        t = temp <  2.*lambda./ro2;
        E_new(t) = 0;

        %% for L
        L_new = L + ro2 .* (E_new - Diffr);

        %% update E,L
        E = E_new;
        L = L_new;
        ro2 = ro2 * 2;
        
        %% iterative error
        eplisoni = norm(i-prei, 'fro')/norm(prei, 'fro');
        eplisonr = norm(r-prer, 'fro')/norm(prer, 'fro');
        fprintf('Iterations #%d : eplisonI = %f; eplisonR = %f\n', it, eplisoni, eplisonr);
        if(eplisoni<0.001 || eplisonr<0.001)
            fprintf('Iterations = %d\n', it);
            break;
        end
    end
    it_tmp = it;
end