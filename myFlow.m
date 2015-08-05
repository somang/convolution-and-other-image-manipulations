function [u v b] = myFlow(img1, img2, window_length, r)
% Image derivatives
filter = [-1 8 0 -8 1]/12;
Ix = imfilter(img1, filter);
Iy = imfilter(img1, filter');
filter = fspecial('gaussian',3,1);
It = imfilter(img2, filter) - imfilter(img1, filter);

% Summation through filtering.
filter = ones(window_length);
Ixx = imfilter(Ix.^2,filter,'conv');
Iyy = imfilter(Iy.^2,filter,'conv');
Ixy = imfilter(Ix.*Iy,filter,'conv');
Ixt = imfilter(Ix.*It,filter,'conv');
Iyt = imfilter(Iy.*It,filter,'conv');

% Initialization
u = zeros(size(img1));
v = zeros(size(img1));
b = zeros(size(img1));
K = floor(window_length/2);
for i = 1:size(img1,1)
    for j = 1:size(img1,2)
        % For each window, get attributes for matrix A (in fact A'*A)
        AtA = [Ixx(i,j) Ixy(i,j); ...
            Ixy(i,j) Iyy(i,j)];
        Atb = [Ixt(i,j); Iyt(i,j)];

        t = min(eig(AtA)); % The smallest eigenvalue of A'*A
        %Optical flow is valid when threshold < r and invertible
        if t < r
            ofv = [0 0];
            valid = 0;
        else
            ofv = pinv(AtA)*-Atb; % Find least square fitting solution.
            valid = 1;
        end        
        u(i,j) = ofv(1);
        v(i,j) = ofv(2);
        b(i,j) = valid; % Fill in binary mapping        
    end
end
if size(u,3) == 3
    size(u,3)
    u = rgb2gray(u);
    v = rgb2gray(v);
end
