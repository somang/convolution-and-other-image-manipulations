clc;
clear all;
close all;

%% Q1 is in myConv.m
I = imread('Images/drbrown.jpg');

subplot(2,2,1), imshow(I), title('Original Image');
%% Q2
kernel = fspecial('gaussian', 13 , 2);
built_in_conv = imfilter(I, kernel);
my_con = myConv(I, kernel); % Q1
subplot(2,2,2), imshow(built_in_conv), title('imfilter');
subplot(2,2,3), imshow(my_con), title('myCon');
% The absolute difference
dif = abs(im2double(built_in_conv) - my_con); % Yes, there is a difference.
subplot(2,2,4), imshow(dif), title('Difference'), pause;
%% Q3
I = imread('Images/carscene.jpg');
I = im2double(I);
if size(I,3) == 3
    I = rgb2gray(I);
end
% Conv2 on spatial domain
tic;
k3 = fspecial('gaussian', 3, 2);
c3 = conv2(double(I),double(k3), 'same');
t3 = toc;
tic;
k5 = fspecial('gaussian', 5, 2);
c5 = conv2(im2double(I),im2double(k5), 'same');
t5 = toc;
tic;
k7 = fspecial('gaussian', 7, 2);
c7 = conv2(im2double(I),im2double(k7), 'same');
t7 = toc;
tic;
k13 = fspecial('gaussian', 13, 2);
c13 = conv2(im2double(I),im2double(k13), 'same');
t13 = toc;
tic;
k21 = fspecial('gaussian', 21, 2);
c21 = conv2(im2double(I),im2double(k21), 'same');
t21 = toc;
tic;
k31 = fspecial('gaussian', 31, 2);
c31 = conv2(im2double(I),im2double(k31), 'same');
t31 = toc;
tic;
k41 = fspecial('gaussian', 41, 2);
c41 = conv2(im2double(I),im2double(k41), 'same');
t41 = toc;
tic;
k51 = fspecial('gaussian', 51, 2);
c51 = conv2(im2double(I),im2double(k51), 'same');
t51 = toc;
tic;
k71 = fspecial('gaussian', 71, 2);
c71 = conv2(im2double(I),im2double(k71), 'same');
t71 = toc;
kernelsize = [3 5 7 13 21 31 41 51 71];
execution_time = [t3 t5 t7 t13 t21 t31 t41 t51 t71];
figure, plot(kernelsize,execution_time), ...
    title('Plot of execution time over kernel size'), ...
    ylabel('Execution time'), xlabel('Kernel size'), ...
    set(gca,'XTick',[3 5 7 13 21 31 41 51 71]);
%% Q4
[h w] = size(I);
tic;
f = circshift(padarray(k3, [h w]-3, 'post'), -[1 1]);
im_dft = fft2(I, h, w); 
f_dft = fft2(f, h, w); 
im_f_dft = im_dft .* f_dft; 
im_f = ifft2(im_f_dft); 
tf1 = toc;
tic;
f = circshift(padarray(k5, [h w]-5, 'post'), -[2 2]);
im_dft = fft2(I, h, w); 
f_dft = fft2(f, h, w); 
im_f_dft = im_dft .* f_dft; 
im_f = ifft2(im_f_dft); 
tf2 = toc;
tic;
f = circshift(padarray(k7, [h w]-7, 'post'), -[3 3]);
im_dft = fft2(I, h, w); 
f_dft = fft2(f, h, w); 
im_f_dft = im_dft .* f_dft; 
im_f = ifft2(im_f_dft); 
tf3 = toc;
tic;
f = circshift(padarray(k13, [h w]-13, 'post'), -[6 6]);
im_dft = fft2(I, h, w); 
f_dft = fft2(f, h, w); 
im_f_dft = im_dft .* f_dft; 
im_f = ifft2(im_f_dft); 
tf4 = toc;
tic;
f = circshift(padarray(k21, [h w]-21, 'post'), -[10 10]);
im_dft = fft2(I, h, w); 
f_dft = fft2(f, h, w); 
im_f_dft = im_dft .* f_dft; 
im_f = ifft2(im_f_dft); 
tf5 = toc;
tic;
f = circshift(padarray(k31, [h w]-31, 'post'), -[15 15]);
im_dft = fft2(I, h, w); 
f_dft = fft2(f, h, w); 
im_f_dft = im_dft .* f_dft; 
im_f = ifft2(im_f_dft); 
tf6 = toc;
tic;
f = circshift(padarray(k41, [h w]-41, 'post'), -[20 20]);
im_dft = fft2(I, h, w); 
f_dft = fft2(f, h, w); 
im_f_dft = im_dft .* f_dft; 
im_f = ifft2(im_f_dft); 
tf7 = toc;
tic;
f = circshift(padarray(k51, [h w]-51, 'post'), -[25 25]);
im_dft = fft2(I, h, w); 
f_dft = fft2(f, h, w); 
im_f_dft = im_dft .* f_dft; 
im_f = ifft2(im_f_dft); 
tf8 = toc;
tic;
f = circshift(padarray(k71, [h w]-71, 'post'), -[35 35]);
im_dft = fft2(I, h, w); 
f_dft = fft2(f, h, w); 
im_f_dft = im_dft .* f_dft; 
im_f = ifft2(im_f_dft); 
tf9 = toc;
tfs = [tf1,tf2,tf3,tf4,tf5,tf6,tf7,tf8,tf9];
hold on;
plot(kernelsize,tfs,'r'), legend('spatial domain','frequency domain'), pause;
%% Q5
% Spatial based convolution is good when it uses small sized kernels.
% While frequency based convolution is better after bigger sized kernels,
% it finishes filtering under similar runtime speed with spatial based
% convolution for small sized kernels.
%% Q6
% There is no visible difference between two.
% The exact difference has maximum value of 1.443*e-15
% This is very small difference which cannot be taken as significant.
g = fspecial('gaussian', [1 13], 8);
one_d_filtered_image = conv2(g,g',I,'full');
g2 = fspecial('gaussian', 13, 8);
two_d_filtered_image = conv2(g2,I,'full');
d = abs(one_d_filtered_image - two_d_filtered_image);

figure,
subplot(2,2,1), imshow(I), title('Original Image');
subplot(2,2,2), imshow(one_d_filtered_image), title('1D filtered');
subplot(2,2,3), imshow(two_d_filtered_image), title('2D filtered');
subplot(2,2,4), imshow(d), title('Difference');
