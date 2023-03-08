clc;
clear all;
close all;
warning('off','all');

tic;
disp(['Initial'])
image = double(imread('dust1.jpg'))/255;
% subplot(2,3,1)
% imshow(image)
% title("Original Image")

omega = 0.8;
win_size = 15;
r = 15;
res = 0.01;

% disp(['DCP'])
[m, n, ~] = size(image);
dark_channel = get_dark_channel(image, win_size);
atmosphere = get_atmosphere(image, dark_channel);
trans_est = get_transmission_estimate(image, atmosphere, omega, win_size);
output1=Recovering_Scene_Radiance(image,atmosphere,trans_est);
toc;

imshow(output1)
title("DCP")
