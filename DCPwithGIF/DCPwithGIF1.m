clc;
clear all;
close all;
warning('off','all');

tic;
disp(['Initial'])
image = double(imread('dust1.jpg'))/255;
subplot(2,3,1)
imshow(image)
title("Original Image")

omega = 0.8;
win_size = 15;
r = 15;
res = 0.01;

disp(['DCP'])
[m, n, ~] = size(image);
dark_channel = get_dark_channel(image, win_size);
subplot(2,3,2)
imshow(dark_channel)
title("Dark Channel")

atmosphere = get_atmosphere(image, dark_channel);
trans_est = get_transmission_estimate(image, atmosphere, omega, win_size);
subplot(2,3,3)
imshow(trans_est)
title("Transmission Estimate")

J_Refined=Recovering_Scene_Radiance(image,atmosphere,trans_est);
DCP=uint8(J_Refined.*255);
subplot(2,3,4)
imshow(DCP)
title("DCP")
toc

disp(['DCP with guided filter'])
output1 = func_DCP(image); 
subplot(2,3,6)
imshow(output1)
title("DCP with GIF")

disp(['quality assessment'])
figure
quality_assessment(image,DCP,output1);