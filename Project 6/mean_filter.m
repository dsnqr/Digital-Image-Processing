%% Using fspecial to implement mean filter

img = imread('lena512.dib.bmp');
img = img(:,:,1);

gauss_img = imnoise(img,'gaussian',0,0.01);
poisson_img = imnoise(img,'poisson');
snp_img = imnoise(img,'salt & pepper',0.05);
speckle_img = imnoise(img,'speckle',0.04);
% h = fspecial('average',[3 3]);
% 
% I = am_filter(img);




f = @(x) geomean(x(:));
f_img = nlfilter(double(gauss_img),[3 3],f);

imshow(uint8(f_img));