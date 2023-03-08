clc;
clear all;
close all;
warning('off','all');

tic;
disp(['Initial'])
image = double(imread('end13.jpg'))/255;
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
output1=Recovering_Scene_Radiance(image,atmosphere,trans_est);
subplot(2,3,4)
imshow(output1)
title("DCP")

disp(['DCP with guided filter'])
x = weightedguidedfilter(rgb2gray(image), trans_est, r, res);
transmission = reshape(x, m, n);
subplot(2,3,5)
imshow(transmission)
title("Transmission Estimate with GIF")

J_Refined=Recovering_Scene_Radiance(image,atmosphere,transmission);
% J_Refined=Recovering_Scene_Radiance(image,atmosphere,FG);
DCPGIF=uint8(J_Refined.*255);
subplot(2,3,6)
imshow(DCPGIF)
title("DCP with GIF")
toc;

disp(['quality assessment'])
figure
quality_assessment(image,output1, DCPGIF);
MSE1=immse(image,image)
MSE2=immse(image,output1)
MSE3=immse(image,J_Refined)
