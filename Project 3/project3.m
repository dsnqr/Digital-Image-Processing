%%Open the RAW image

raw_img = fopen('girl256color.raw','r');

%%Read the RAW image

img = fread(raw_img);

%%vector for the Red component

R_img = reshape(img(1:3:length(img)),256,256)';

%%vector for the Green component

G_img = reshape(img(2:3:length(img)),256,256)';

%%vector for the Blue component

B_img = reshape(img(3:3:length(img)),256,256)';

%%Reconstruct image from RGB components obtained above

recon_img(:,:,1) = R_img;
recon_img(:,:,2) = G_img;
recon_img(:,:,3) = B_img;

%%Display original image

figure(1)
imshow(uint8(recon_img));
title('RAW Image');

%%Display RGB components

figure(2)
subplot(3,3,1)
image(uint8(R_img));
title('Red Component')
subplot(3,3,2)
image(uint8(G_img));
title('Green Component')
subplot(3,3,3)
image(uint8(B_img));
title('Blue Component');

%%Color Transformation Phase
%%We seperate out the YUV components using the following formulas

%%Y component

Y = 0.299 * R_img + 0.587 * G_img + 0.114 * B_img;

%%U component

U = (B_img - Y) / 2.03;

%%V component

V = (R_img - Y) / 1.14;

%%Display YUV components

subplot(3,3,4)
image(uint8(Y))
title('Y Component');
subplot(3,3,5)
image(uint8(U))
title('U Component');
subplot(3,3,6)
image(uint8(V))
title('V Component');

%%Inverse transformation Phase
%%We seperate out the Yd Cb Cr components using the following formula

%%Yd component

Y_d = 219 * Y + 16;

%%Cb component

C_b = (112 * (B_img - Y) / 0.889) + 128;

%%Cr component

C_r = (112 * (R_img - Y)/0.701) + 128;

%%Display the Yd Cb Cr components

subplot(3,3,7)
image(Y_d)
title('Yd Component');
subplot(3,3,8)
image(C_b)
title('Cb Component');
subplot(3,3,9)
image(C_r)
title('Cr Component');


