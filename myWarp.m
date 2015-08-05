function warped = myWarp(img2, u, v)
[h w] = size(img2);
[x,y] = meshgrid(1:h,1:w); 
warped = interp2(img2,x-u,y-v); % Warp using interp2 for each difference
warped(isnan(warped)) = 0; % if there's any NaN, then put zero instead
