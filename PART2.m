clc;clear all;close all;

%% Q1
Image1 = im2double(imread('Images/logo.jpg'));
Image2 = im2double(imread('Images/car.jpg'));
highpass = fspecial('gaussian', 25, 10);
lowpass = fspecial('gaussian', 25, 5);
lowfreq_I = imfilter(Image1, highpass, 'symmetric');
highfreq_I = Image2 - imfilter(Image2, lowpass, 'symmetric');
hybrid_I = lowfreq_I + highfreq_I;

imshow(rgb2gray(hybrid_I)),figure,imshow(hybrid_I);

figure,
subplot(2,2,1), imshow(lowfreq_I), title('low frequency');
subplot(2,2,2), imshow(highfreq_I), title('high frequency');
subplot(2,2,3), imshow(hybrid_I), title('hybrid optical illusion colour');
subplot(2,2,4), imshow(rgb2gray(hybrid_I)), title('hybrid optical illusion grayscale');