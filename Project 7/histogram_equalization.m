clc;
clear all;
close all;

%% Reading and displaying the first image

img = imread('elaine.512.tiff');

figure;
subplot(1,2,1);
imshow(uint8(img));
title('Original Image');
subplot(1,2,2);

%% Applying histogram equalization and displaying original image and it's histogram

imhist(img);
title('Oiginal Image Histogram');
saveas(gca,'origin_hist.jpg');

%% Performing Global Histogram Equalization

g_hist_img = histeq(img);
figure;
subplot(1,2,1)
imshow(uint8(g_hist_img));
title('Globally Equalized Histogram Image')
subplot(1,2,2)
imhist(g_hist_img);
title('Globally Equalized Histogram');
saveas(gca,'g_hist.jpg');

%% Performing Local Histogram Equalization

l_hist_img = adapthisteq(img,'clipLimit',0.01,'Distribution','rayleigh');
figure;
subplot(1,2,1)
imshow(uint8(l_hist_img));
title('Locally Equalized Histogram Image');
subplot(1,2,2)
imhist(l_hist_img);
title('Locally Equalized Histogram');
saveas(gca,'l_hist.jpg');

%% Direct Histogram (Straight Line)

st_l = linspace(0,1,512);
d_hist_img = histeq(img,st_l);
figure;
subplot(1,2,1)
imshow(d_hist_img);
title('Direct Histogram Image');
subplot(1,2,2)
imhist(d_hist_img);
title('Direct Histogram (Straight Line)');
saveas(gca,'d_hist.jpg');

%% Performing the same operations for the Second Image

img2 = imread('pout.tif');
figure;
subplot(1,2,1)
imshow(uint8(img2));
title('Orignal Image');
subplot(1,2,2)
imhist(img2);
title('Orignal Image Histogram');
saveas(gca,'origin_hist_2.jpg');

%% Global Hisogram Equalization

g_hist_img2 = histeq(img2);
figure;
subplot(1,2,1)
imshow(uint8(g_hist_img2));
title('Globally Equalized Histogram Image');
subplot(1,2,2)
imhist(g_hist_img2);
title('Globally Equalized Histogram');
saveas(gca,'g_hist_2.jpg');

%% Local Histogram Equalization

l_hist_img2 = adapthisteq(img2,'clipLimit',0.01,'Distribution','rayleigh');
figure;
subplot(1,2,1)
imshow(uint8(l_hist_img2));
title('Locally Equalized Histogram Image');
subplot(1,2,2)
imhist(l_hist_img2);
title('Locally Equalized Histogram');
saveas(gca,'l_hist_2.jpg');

%% Direct Histogram (Straight Line)

st_l = linspace(0,1,512);
d_hist_img2 = histeq(img2,st_l);
figure;
subplot(1,2,1)
imshow(d_hist_img2);
title('Direct Histogram Image');
subplot(1,2,2)
imhist(d_hist_img2);
title('Direct Histogram (Straight Line)');
saveas(gca,'d_hist_2.jpg');
