clc;
close all;
clear all;

%% Open the RAW image

img_raw = fopen('girl256color.raw','r');

%% Read the RAW image

img_raw = fread(img_raw);

%% Extract the RGB components of the image

R_img_raw = reshape(img_raw(1:3:length(img_raw)),256,256)';
G_img_raw = reshape(img_raw(2:3:length(img_raw)),256,256)';
B_img_raw = reshape(img_raw(3:3:length(img_raw)),256,256)';

%% Make the complete image

I(:,:,1) = R_img_raw;
I(:,:,2) = G_img_raw;
I(:,:,3) = B_img_raw;

%% Display the RAW image

figure
imshow(uint8(I))
title('RAW Image')
saveas(gca,'RAW_image','jpg');

%% For the first problem, we deploy the following algorithm

%% Initialize a matrix of zeros of the same size as that of the image

YIQ_img = uint8(zeros(size(I)));

%% Color space conversions

for i = 1:size(I,1)
for j = 1:size(I,2)
    
YIQ_img(i,j,1) = 0.299*I(i,j,1)+0.587*I(i,j,2)+0.144*I(i,j,3); % Y component

YIQ_img(i,j,2) = 0.596*I(i,j,1)-0.274*I(i,j,2)-0.322*I(i,j,3); % I component

YIQ_img(i,j,3) = 0.211*I(i,j,1)-0.523*I(i,j,2)+0.312*I(i,j,3); % Q component

end
end

%% Displaying the YIQ color components

figure
subplot(1,3,1)
imshow(YIQ_img(:,:,1))
title('Y Component')
subplot(1,3,2)
imshow(YIQ_img(:,:,2))
title('I Component')
subplot(1,3,3)
imshow(YIQ_img(:,:,3))
title('Q Component')
saveas(gca,'YIQ_components','jpg');
figure 
imshow(YIQ_img)
title('YIQ color space image')
saveas(gca,'YIQ image','jpg');

%% Reconstructing RGB from the YIQ components

recon_img = uint8(zeros(size(YIQ_img)));

%% Inverse color space conversion

for i = 1:size(YIQ_img,1)
for j = 1:size(YIQ_img,2)
    
recon_img(i,j,1) = 1.0*YIQ_img(i,j,1)+0.956*YIQ_img(i,j,2)+0.621*YIQ_img(i,j,3); % R Component

recon_img(i,j,2) = 1.0*YIQ_img(i,j,1)-0.272*YIQ_img(i,j,2)-0.647*YIQ_img(i,j,3); % G Component

recon_img(i,j,3) = 1.0*YIQ_img(i,j,1)-1.106*YIQ_img(i,j,2)+1.703*YIQ_img(i,j,3); % B component
end
end
%% Displaying Reconstructed RGB color components

figure
subplot(1,3,1)
imshow(uint8(recon_img(:,:,1)))
title('R Component(Recon)')
subplot(1,3,2)
imshow(uint8(recon_img(:,:,2)))
title('G Component(Recon)')
subplot(1,3,3)
imshow(uint8(recon_img(:,:,3)))
title('B Component(Recon)')
saveas(gca,'Recon_RGB_YIQ','jpg');
%% Displaying Reconstructed Image

figure
imshow(uint8(recon_img))
title('Reconstructed Image')
saveas(gca,'Recon_1','jpg');

