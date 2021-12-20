function [wxt, wyt] = computeWeights(i,sigma12,epsilon,flag)

    
    dxo = diff(i,1,2);
    dxo = padarray(dxo, [0 1], 'post');
    dyo = diff(i,1,1);
    dyo = padarray(dyo, [1 0], 'post');
    
    

    gsi = gauss_filter(i,sigma12);
    dxs = diff(gsi,1,2);
    dxs = padarray(dxs, [0 1], 'post');
    dxs = convBox( single(dxs), 3);
    dys = diff(gsi,1,1);
    dys = padarray(dys, [1 0], 'post');
    dys = convBox( single(dys), 3);
    
    if (flag == 1)
        wxt = max(max(abs(dxo).*abs(dxs).^0.8,[],3),epsilon).^(-1);
        wyt = max(max(abs(dyo).*abs(dys).^0.8,[],3),epsilon).^(-1);
    else
        wxt = max(max(abs(dxs).^0.8,[],3),epsilon).^(-1);
        wyt = max(max(abs(dys).^0.8,[],3),epsilon).^(-1);
    end

    wxt(:,end) = 0;
    wyt(end,:) = 0;
    
%     aa = abs(dxo./(dxs))+abs(dyo./(dys));
%     figure;imshow(aa,[]);
%     bb = abs(dxo)+abs(dyo);
%     figure;imshow(bb,[]);
% 
%     dxo = diff(i,1,2);
%     dxo = padarray(dxo, [0 1], 'post');
%     dyo = diff(i,1,1);
%     dyo = padarray(dyo, [1 0], 'post');
%     
%     wxo = max(max(abs(dxo),[],3),epsilon).^(-1);
%     wyo = max(max(abs(dyo),[],3),epsilon).^(-1);
%     si = gauss_filter(i,sigma12);
%     dxs = diff(si,1,2);
%     dxs = padarray(dxs, [0 1], 'post');
%     dys = diff(si,1,1);
%     dys = padarray(dys, [1 0], 'post');
%     
%  
%     wxt = max(max((exp(sqrt(dxs.*dxs)./(2*sigma12))),[],3),epsilon).^(-1);
%     wyt = max(max((exp((dys.*dys)./(2*sigma12))),[],3),epsilon).^(-1);
%     
%     wxt = wxo.*wxt;
%     wyt = wyo.*wyt;
%     
%     wxt(:,end) = 0;
%     wyt(end,:) = 0;
end