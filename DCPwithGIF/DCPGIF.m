clc;
clear all;
close all;
warning('off','all');

tic;
% disp(['Initial'])
image = double(imread('dust1.jpg'))/255;

omega = 0.8;
win_size = 15;
r = 15;
res = 0.01;

[m, n, ~] = size(image);
dark_channel = get_dark_channel(image, win_size);

atmosphere = get_atmosphere(image, dark_channel);
trans_est = get_transmission_estimate(image, atmosphere, omega, win_size);

x = weightedguidedfilter(rgb2gray(image), trans_est, r, res);
transmission = reshape(x, m, n);

J_Refined=Recovering_Scene_Radiance(image,atmosphere,transmission);
output=uint8(J_Refined.*255);
toc;
subplot(1,2,1),imshow(image);title("Original Image")
subplot(1,2,2)
imshow(output);
title("DCP with GIF")
