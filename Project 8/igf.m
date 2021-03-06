%% Reading the images for the project

img_lena = double(imread('lena512.bmp'));
img_lena = img_lena(:,:,1);
img_goldhill = double(imread('goldhill256.BMP'));
img_girl = double(imread('girl512.bmp'));
img_boat = double(imread('boat512.gif'));
%% Setting the variance for the images

lena_var = 15707;
goldhill_var = 28198;
boat_var = 41694;
girl_var = 34657;

%% Applying 2D FFT for the images

dft_lena = fft2(img_lena);
dft_goldhill = fft2(img_goldhill);
dft_boat = fft2(img_boat);
dft_girl = fft2(img_girl);

%% Initializing the IGF matrix for the images

igf_goldhill = zeros(1,128);
igf_lena = zeros(1,256);
igf_boat = zeros(1,256);
igf_girl = zeros(1,256);

%% IGF for goldhill256

for i = 1:128
for j = 1:128
igf_goldhill(i,j) = exp(((i^2)+(j^2))/(2*goldhill_var));
end
end


for i = 1:256
for j = 1:256
igf_lena(i,j) = exp(((i^2)+(j^2))/(2*lena_var));
igf_girl(i,j) = exp(((i^2)+(j^2))/(2*girl_var));
igf_boat(i,j) = exp(((i^2)+(j^2))/(2*boat_var));

%% conditional for goldhill
if i<=128 && j>128
igf_goldhill(i,j) = igf_goldhill(i,257-j);
elseif i>128 && j<=128
igf_goldhill(i,j) = igf_goldhill(257-i,j);
elseif i>128 && j>128
igf_goldhill(i,j) = igf_goldhill(257-i,257-j);
end

end
end


%% IGF for the remaining images

for i = 1:512
for j = 1:512

%% conditional for remaining images

if i<=256 && j>256
igf_lena(i,j) = igf_lena(i,513-j);
igf_girl(i,j) = igf_girl(i,513-j);
igf_boat(i,j) = igf_boat(i,513-j);
elseif i>256 && j<=256
igf_lena(i,j) = igf_lena(513-i,j);
igf_girl(i,j) = igf_girl(513-i,j);
igf_boat(i,j) = igf_boat(513-i,j);
elseif i>256 && j>256
igf_lena(i,j)=igf_lena(513-i,513-j);
igf_girl(i,j)=igf_girl(513-i,513-j);
igf_boat(i,j)=igf_boat(513-i,513-j);
end
end
end

%% Displaying the 3D IGF for the images

%lena
surf(igf_lena,'EdgeColor','none');
colormap(hsv);
shading interp;
alpha(0.7);
axis tight;
title('IGF Mask Lena');
saveas(gca,'3d_igf_lena.jpg');

%boat
figure; surf(igf_boat,'EdgeColor','none');
colormap(hsv);
shading interp;
alpha(0.7);
axis tight;
title('IGF Mask Boat');
saveas(gca,'3d_igf_boat.jpg');
%girl
figure; surf(igf_girl,'EdgeColor','none');
colormap(hsv);
shading interp;
alpha(0.7);
axis tight;
title('IGF Mask Girl');
saveas(gca,'3d_igf_girl.jpg');

%goldhill
figure;
surf(igf_goldhill,'EdgeColor','none');
colormap(hsv);
shading interp;
alpha(0.7);
axis tight;
title('IGF Mask Goldhill');
saveas(gca,'3d_igf_goldhill.jpg');

%% Filtered images

f_l = dft_lena.*igf_lena;
f_g = dft_goldhill.*igf_goldhill;
f_gr = dft_girl.*igf_girl;
f_b = dft_boat.*igf_boat;

%% Inverse FFT of the filtered images

ifft_l = ifft2(f_l);
ifft_g = ifft2(f_g);
ifft_gr = ifft2(f_gr);
ifft_b = ifft2(f_b);

%% Displaying Original and filtered images

%lena
figure;
subplot(1,2,1);
imshow(uint8(img_lena));
title('Original Image');
subplot(1,2,2);
imshow(uint8(ifft_l));
title('Filtered Image');
saveas(gca,'lena_results.jpg');

%girl
figure;
subplot(1,2,1);
imshow(uint8(img_girl));
title('Original Image');
subplot(1,2,2);
imshow(uint8(ifft_gr));
title('Filtered Image');
saveas(gca,'girl_results.jpg');

%goldhill
figure;
subplot(1,2,1);
imshow(uint8(img_goldhill));
title('Original Image');
subplot(1,2,2);
imshow(uint8(ifft_g));
title('Filtered Image');
figure;
saveas(gca,'goldhill_results.jpg');

%boat
subplot(1,2,1);
imshow(uint8(img_boat));
title('Original Image');
subplot(1,2,2);
imshow(uint8(ifft_b));
title('Filtered Image');
saveas(gca,'boat_results.jpg');