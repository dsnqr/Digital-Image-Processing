clear all; clc; close all;
%% For problem 3 we convert RGB to YCgCo

%% Read the image

img = imread('flowers.bmp');

%% Color space conversion algorithm

Y = double(0.25*img(:,:,1)+0.5*img(:,:,2)+0.25*img(:,:,3)); % Y Component
Cg = double(-0.25*img(:,:,1)+0.5*img(:,:,2)-0.25*img(:,:,3)); % Cg component
Co = double(0.5*img(:,:,1)-0.5*img(:,:,3));                   % Co component

%% Displaying original image

figure,imshow(img)
title('Orignal Image')

%% Displaying the YCgCo components

figure,subplot(1,3,1)
imshow(uint8(Y))
title('Y Component')
subplot(1,3,2)
imshow(uint8(Cg))
title('C_g Component')
subplot(1,3,3)
imshow(uint8(Co))
title('C_o Component')

%% For problem 4 we do the inverse conversion from YCgCo to RGB

%% Reconstructing to RGB using the following

R = Y - Cg + Co;
G = Y + Cg;
B = Y - Cg - Co;

%% Display reconstructed RGB components

figure
subplot(1,3,1)
imshow(uint8(R))
title('Recon_R')
subplot(1,3,2)
imshow(uint8(G))
title('Recon_G')
subplot(1,3,3)
imshow(uint8(B))
title('Recon_B')

%% Reconstructing the image

I = zeros(size(img));
I(:,:,1) = R;
I(:,:,2) = G;
I(:,:,3) = B;

%% Displaying reconstrcuted image

figure
imshow(uint8(I))
title('Reconstructed Image')