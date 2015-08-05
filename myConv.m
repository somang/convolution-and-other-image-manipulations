function blurred_image = myConv(original, kernel)
    I = im2double(original);

    %% flip the kernel
    flipped = [];
    dim = size(kernel,1);
    N = 0; %normalization coefficient for future
    for i=1:dim
        for j=1:dim
            flipped(i,j) = kernel(dim+1-i,dim+1-j);
            N = N + kernel(i,j);
        end
    end

    [h w z] = size(I);
    K = floor(dim/2); %(dim-1)/2;
    I = padarray(I,[K K],0); % so that I can handle boundary
    blurred_image = zeros(h+K,w+K); %(y,x)
     if z ~= 3 % If I is grayscale
        %% convolution
        for r = K+1:h+K
            for c = K+1:w+K
                sum = 0;
                for i=-K:K
                    for j=-K:K
                        sum = sum + (kernel(i+dim-K,j+dim-K)*I(r+i,c+j));
                    end
                end
                blurred_image(r,c) = sum/N;
            end
        end
        blurred_image = blurred_image(K+1:h+K,K+1:w+K);
        
    else % If I is Color,
        Rchannel = I(:,:,1);
        blurred_r = [];
        for r = K+1:h+K
            for c = K+1:w+K
                sum = 0;
                for i=-K:K
                    for j=-K:K
                        sum = sum + (kernel(i+dim-K,j+dim-K)*Rchannel(r+i,c+j));
                    end
                end
                blurred_r(r,c) = sum/N;
            end
        end
        blurred_r = blurred_r(K+1:h+K,K+1:w+K);
        
        Gchannel = I(:,:,2);
        blurred_g = [];
        for r = K+1:h+K
            for c = K+1:w+K
                sum = 0;
                for i=-K:K
                    for j=-K:K
                        sum = sum + (kernel(i+dim-K,j+dim-K)*Gchannel(r+i,c+j));
                    end
                end
                blurred_g(r,c) = sum/N;
            end
        end
        blurred_g = blurred_g(K+1:h+K,K+1:w+K);
        
        Bchannel = I(:,:,3);
        blurred_b = [];
        for r = K+1:h+K
            for c = K+1:w+K
                sum = 0;
                for i=-K:K
                    for j=-K:K
                        sum = sum + (kernel(i+dim-K,j+dim-K)*Bchannel(r+i,c+j));
                    end
                end
                blurred_b(r,c) = sum/N;
            end
        end    
        blurred_b = blurred_b(K+1:h+K,K+1:w+K);
        
        blurred_image = cat(3,blurred_r,blurred_g,blurred_b);
    end
