clc;
close all;
clear all;
 
Im=imread('flowers.bmp','bmp');
Im_double=double(Im);
[A,B,C]=size(Im_double);
RD=Im_double(:,:,1);
GR=Im_double(:,:,2);
BL=Im_double(:,:,3);
 
Y_Decima_Fiter = [-29 0 88 138 88 0 -29]/256;
CbCr_Decima_Filter = [1 3 3 1]/8;
Y_IntrFiltr = [-12 0 140 256 140 0 -12]/256; 
Cb_Cr_intrfiltr = [ 1 0 3 8 3 0 1]/8;
 
 
subplot(2,2,1);
imshow(Im);
title('actual image');
 
 
subplot(2,2,2);
imshow(uint8(RD));
title('red component of the image');
 
 
subplot(2,2,3);
imshow(uint8(BL));
title('blue component of the image');
 
 
subplot(2,2,4);
imshow(uint8(GR));
title('green component of the image');
 
Y=0.257*RD+0.504*GR+0.098*BL+16;
Cb=-0.148*RD-0.291*GR+0.439*BL+128;
Cr=0.439*RD-0.368*GR-0.071*BL+128;
 
figure(2)
subplot(2,2,1);
imshow(uint8(Y));
title('luminance component of the image');
 
subplot(2,2,2);
imshow(uint8(Cb));
title('differential blue component of the image');
 
subplot(2,2,3);
imshow(uint8(Cr));
title('differential red component of the image');
 
 
Cr_horizontal = downsample(Cr',2)' 
Cb_horizontal = downsample(Cb',2)'; 
 
Y_filr = imfilter(double(Y),Y_Decima_Fiter,'circular','conv'); 
Y_horizontal_vertical = downsample(downsample(Y_filr,2)',2)'; 
 
Cr_horiz_filter = imfilter(double(Cr_horizontal),CbCr_Decima_Filter,'circular','conv'); 
Cr_horiz_vert = downsample(downsample(Cr_horiz_filter,2)',2)';
Cb_horiz_filter = imfilter(double(Cb_horizontal),CbCr_Decima_Filter,'circular','conv'); 
Cb_horiz_vert = downsample(downsample(Cb_horiz_filter,2)',2)'; 
 
figure(3);
subplot(2,2,1);
imshow(uint8(Y_horizontal_vertical));
title('Decimation -Y of the image'); 
subplot(2,2,2);
imshow(uint8(Cr_horiz_vert));
title('Decimation -Cr of the image');
subplot(2,2,3);
imshow(uint8(Cb_horiz_vert));
title('Decimation -Cb of the image'); 
 
 
 
Y_horizontal_vertical_Up = upsample(upsample(Y_horizontal_vertical,2)',2)';
Y_horizontal_vertical_Up_filter = imfilter(double(Y_horizontal_vertical_Up),Y_IntrFiltr,'circular','conv'); 
Y_filr = imfilter(double(Y_horizontal_vertical_Up_filter),Y_IntrFiltr','circular','conv'); 
Cr_horizontal_vertical_Up = upsample(upsample(Cr_horiz_vert,2)',2)'; 
Cr_horizontal_vertical_Up_filter = imfilter(Cr_horizontal_vertical_Up,Cb_Cr_intrfiltr','circular','conv');
Cr_filter = imfilter(Cr_horizontal_vertical_Up_filter,Cb_Cr_intrfiltr,'circular','conv'); 
Cr_horizontal_vertical_Up1 = upsample(Cr_filter',2)'; 
[r c] = size(Cr_horizontal_vertical_Up1); 
Cr_horizontal_vertical_Up1(:,c) = Cr_horizontal_vertical_Up1(:,c-1);
 
 
 
for cnt = 2:2:c-1
    Cr_horizontal_vertical_Up1(:,cnt) = (Cr_horizontal_vertical_Up1(:,cnt-1) + Cr_horizontal_vertical_Up1(:,cnt+1))/2;
end
 
 
Cb_hor_vert_Up = upsample(upsample(Cb_horiz_vert,2)',2)'; 
Cb_hor_vert_Up_filter = imfilter(double(Cb_hor_vert_Up),Cb_Cr_intrfiltr,'circular','conv');  
Cb_filtr = imfilter(double(Cb_hor_vert_Up_filter),Cb_Cr_intrfiltr','circular','conv'); 
Cb_hor_vert_Up1 = upsample(Cb_filtr',2)';
[r c] = size(Cb_hor_vert_Up1);
Cb_hor_vert_Up1(:,c) = Cb_hor_vert_Up1(:,c-1);
for cnt = 2:2:c-1
    Cb_hor_vert_Up1(:,cnt) = (Cb_hor_vert_Up1(:,cnt-1) + Cb_hor_vert_Up1(:,cnt+1))/2;
end
 
 
 

figure(4);
subplot(2,2,1);
imshow(uint8(Y_filr));
title('Interpolation -Y of the image'); 
subplot(2,2,2);
imshow(uint8(Cr_horizontal_vertical_Up1));
title('Interpolation -Cr of the image'); 
subplot(2,2,3);
imshow(uint8(Cb_hor_vert_Up1));
title('Interpolation -Cb of the image'); 
 
 
Red1 = 1.164*(Y_filr-16) + 1.596*(Cr_horizontal_vertical_Up1-128);
Green1 = 1.164*(Y_filr-16) - 0.813*(Cr_horizontal_vertical_Up1-128) - 0.392*(Cb_hor_vert_Up1-128);
Blue1 = 1.164*(Y_filr-16) + 2.017*(Cb_hor_vert_Up1-128);
 
 
rec_image1 = zeros(362,500,3);
rec_image2 = zeros(362,500,3);
rec_image3 = zeros(362,500,3);
rec_image = zeros(362,500,3);
rec_image1(:,:,1) = Red1;
 
figure(5);
subplot(2,2,1);
image(uint8(rec_image1)); 
title('R Components of the image');
rec_image2(:,:,2) = Green1;
subplot(2,2,2);
image(uint8(rec_image2));
title('G Components of the image');
rec_image3 (:,:,3) = Blue1;
subplot(2,2,3);
image(uint8(rec_image3));
title('B Components of the image');
rec_image(:,:,1)=rec_image1(:,:,1); 
rec_image(:,:,2)=rec_image2(:,:,2);
rec_image(:,:,3)=rec_image3(:,:,3);

figure(6); 
image(uint8(rec_image));
title('The Reconstructed Image - flowers(500*362)');
