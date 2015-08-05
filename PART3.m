clc;clear all;close all;
%% Q1 myFlow.m
sphere0 = imadjust(rgb2gray(im2double(imread('Images/sphere_0.png'))),[],[]);
sphere1 = imadjust(rgb2gray(im2double(imread('Images/sphere_1.png'))),[],[]);
[sphereu spherev sphereb] = myFlow(sphere0, sphere1, 3, 0.01); % window size 3
%% Q2
flowToColorInput(:,:,1) = sphereu;
flowToColorInput(:,:,2) = spherev;
colorFlow = flowToColor(flowToColorInput);
subplot(2,2,1), imshow(colorFlow), title('window size 3');

% Playing with window sizes
% window size 5
clear all;
sphere0 = imadjust(rgb2gray(im2double(imread('Images/sphere_0.png'))),[],[]);
sphere1 = imadjust(rgb2gray(im2double(imread('Images/sphere_1.png'))),[],[]);
[sphereu spherev sphereb] = myFlow(sphere0, sphere1, 5, 0.01); 
flowToColorInput(:,:,1) = sphereu;
flowToColorInput(:,:,2) = spherev;
colorFlow = flowToColor(flowToColorInput);
subplot(2,2,2), imshow(colorFlow), title('window size 5');

% window size 11
clear all;
sphere0 = imadjust(rgb2gray(im2double(imread('Images/sphere_0.png'))),[],[]);
sphere1 = imadjust(rgb2gray(im2double(imread('Images/sphere_1.png'))),[],[]);
[sphereu spherev sphereb] = myFlow(sphere0, sphere1, 11, 0.01);
flowToColorInput(:,:,1) = sphereu;
flowToColorInput(:,:,2) = spherev;
colorFlow = flowToColor(flowToColorInput);
subplot(2,2,3), imshow(colorFlow), title('window size 11');

% window size 21
clear all;
sphere0 = imadjust(rgb2gray(im2double(imread('Images/sphere_0.png'))),[],[]);
sphere1 = imadjust(rgb2gray(im2double(imread('Images/sphere_1.png'))),[],[]);
[sphereu spherev sphereb] = myFlow(sphere0, sphere1, 21, 0.01);
flowToColorInput(:,:,1) = sphereu;
flowToColorInput(:,:,2) = spherev;
colorFlow = flowToColor(flowToColorInput);
subplot(2,2,4), imshow(colorFlow), title('window size 21'), pause;

% % Windows size is related to the optical flow visiblity.
% % Bigger window size exaggerates the optical flow, while
% % smaller window size provides a very little visible gauge.

%% Q3
close all; 
clear all;
sphere0 = imadjust(rgb2gray(im2double(imread('Images/sphere_0.png'))),[],[]);
sphere1 = imadjust(rgb2gray(im2double(imread('Images/sphere_1.png'))),[],[]);
[sphereu spherev sphereb] = myFlow(sphere0, sphere1, 7, 0.0001);
flowToColorInput(:,:,1) = sphereu;
flowToColorInput(:,:,2) = spherev;
colorFlow = flowToColor(flowToColorInput);
warp = myWarp(sphere1, sphereu, spherev);
imshow(abs(sphere0-warp)); % The difference
figure, subplot(2,2,1), imshow(colorFlow), title('Optical Flow');
subplot(2,2,2), imshow(sphere0), title('img1');
subplot(2,2,3), imshow(sphere1), title('img2');
subplot(2,2,4), imshow(warp), title('Warped Image'), pause;

% With synth
close all; 
clear all;
synth0 = imadjust(im2double(imread('Images/synth_0.png')),[],[]);
synth1 = imadjust(im2double(imread('Images/synth_1.png')),[],[]);
[synthu synthv synthb] = myFlow(synth0, synth1, 7, 0.0001);
flowToColorInput(:,:,1) = synthu;
flowToColorInput(:,:,2) = synthv;
colorFlow = flowToColor(flowToColorInput);
warp = myWarp(synth1, synthu, synthv);
imshow(abs(synth0-warp));
figure, subplot(2,2,1), imshow(colorFlow), title('Optical Flow');
subplot(2,2,2), imshow(synth0), title('img1');
subplot(2,2,3), imshow(synth1), title('img2');
subplot(2,2,4), imshow(warp), title('Warped Image'), pause;

% With Corridor
close all; 
clear all;
bt0 = imadjust(im2double(imread('Images/bt_0.png')),[],[]);
bt1 = imadjust(im2double(imread('Images/bt_1.png')),[],[]);
[btu btv btb] = myFlow(bt0, bt1, 3, 0.01);
flowToColorInput(:,:,1) = btu;
flowToColorInput(:,:,2) = btv;
colorFlow = flowToColor(flowToColorInput);
warp = myWarp(bt1, btu, btv);
imshow(abs(bt0-warp));
figure, subplot(2,2,1), imshow(colorFlow), title('Optical Flow');
subplot(2,2,2), imshow(bt0), title('img1');
subplot(2,2,3), imshow(bt1), title('img2');
subplot(2,2,4), imshow(warp), title('Warped Image'), pause;

close all; 
clear all;