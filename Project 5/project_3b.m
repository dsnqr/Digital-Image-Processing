img = fopen('girl256color.raw','r');
img = fread(img);

r_img = reshape(img(1:3:length(img)),256,256)';
g_img = reshape(img(2:3:length(img)),256,256)';
b_img = reshape(img(3:3:length(img)),256,256)';
I(:,:,1) = r_img;
I(:,:,2) = g_img;
I(:,:,3) = b_img;


figure
imshow(uint8(I))
title('Orignal Image')

NTSC_img = uint8(zeros(size(I)));

for i = 1:size(I,1)
for j = 1:size(I,2)
NTSC_img(i,j,1) = 0.299*I(i,j,1)+0.587*I(i,j,2)+0.144*I(i,j,3);
NTSC_img(i,j,2) = 0.596*I(i,j,1)-0.274*I(i,j,2)-0.322*I(i,j,3);
NTSC_img(i,j,3) = 0.211*I(i,j,1)-0.523*I(i,j,2)+0.312*I(i,j,3);
end
end

figure,subplot(1,3,1),imshow(NTSC_img(:,:,1)),title('Y Component');
subplot(1,3,2),imshow(NTSC_img(:,:,2)),title('I Component');
subplot(1,3,3),imshow(NTSC_img(:,:,3)),title('Q Component');
figure 
imshow(NTSC_img)
title('NTSC color space image')

recon_img = uint8(zeros(size(NTSC_img)));
% Reconstructing RGB Image (Inverse Color space conversion)
for i = 1:size(NTSC_img,1)
for j = 1:size(NTSC_img,2)
recon_img(i,j,1) = 1.0*NTSC_img(i,j,1)+0.956*NTSC_img(i,j,2)+0.621*NTSC_img(i,j,3);
recon_img(i,j,2) = 1.0*NTSC_img(i,j,1)-0.272*NTSC_img(i,j,2)-0.647*NTSC_img(i,j,3);
recon_img(i,j,3) = 1.0*NTSC_img(i,j,1)-1.106*NTSC_img(i,j,2)+1.703*NTSC_img(i,j,3);
end
end
% Displaying Reconstructed RGB color components
figure
subplot(1,3,1)
imshow(uint8(recon_img(:,:,1)))
title('R Component(Recon)');
subplot(1,3,2)
imshow(uint8(recon_img(:,:,2)))
title('G Component(Recon)');
subplot(1,3,3)
imshow(uint8(recon_img(:,:,3)))
title('B Component(Recon)');
% Displaying Reconstructed Image
figure
imshow(uint8(recon_img))
title('Reconstructed Image')