close all; clear all; clc;
%%
img= double(imread('flowers.bmp'));
r_img = img(:,:,1); % Red Component
g_img = img(:,:,2); % Green Component
b_img = img(:,:,3); % Blue Component
I(:,:,1) = r_img; % Make Complete Image
I(:,:,2) = g_img;
I(:,:,3) = b_img;
%% Display Components & Orignal Image
figure(1)
imshow(uint8(I));
title('Orignal Image');
figure(2)
subplot(3,3,1)
image(uint8(r_img));
title('Red Channel');
subplot(3,3,2)
image(uint8(g_img));
title('Green Channel');
subplot(3,3,3)
image(uint8(b_img));
title('Blue Channel');
%% Color Transform
Y=r_img*0.257 + g_img*0.504 + b_img*0.098 +16;
Cb= r_img*-0.148 + g_img*-0.291 + b_img*0.439+128;
Cr= r_img*0.439 + g_img*-0.368 + b_img*-0.071+128;
subplot(3,3,4)
image(Y)
title('Y');
subplot(3,3,5)
image(uint8(Cb))
title('C_b');
subplot(3,3,6)
image(uint8(Cr))
title('C_r');
%%
hy_decim = [-29 0 88 138 88 0 -29]/256;
for i=1:362
Y_deci = conv2(Y(i,:),hy_decim);
end
decim=1/8*[1 3 3 1];
for i=1:362
Cb_deci(i,:)=conv(Cb(i,:),decim);
Cr_deci(i,:)=conv(Cr(i,:),decim);
end
%% Image downsampling.
d_Cb=Cb(:,1:2:500);
d_Cr=Cr(:,1:2:500);
%% Image upsampling.
u_Cb=zeros(362,500);
u_Cr=zeros(362,500);
u_Cb(:,1:2:500)=d_Cb;
u_Cr(:,1:2:500)=d_Cr;
%% Image Interpolation,horizontal filtering.
for i=1:362
Cb_up(i,:)=conv(u_Cb(i,:),decim);
Cr_up(i,:)=conv(u_Cr(i,:),decim);
end
Cb_up=Cb_up(:,1:500);
Cr_up=Cr_up(:,1:500);
%% Image Reconstruction
red_recon=1.164*(Y-16)+1.596*(Cr_up-128);
green_recon=1.164*(Y-16)-0.813*(Cr_up-128)-0.392*(Cb_up-128);
blue_recon=1.164*(Y-16)+2.017*(Cb_up-128);
subplot(3,3,7);
image(uint8(red_recon));
title('Recon Red Image');
subplot(3,3,8);
image(uint8(green_recon));
title('Recon Green Image');
subplot(3,3,9);
image(uint8(blue_recon));
title('Recon Blue Image');