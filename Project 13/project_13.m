img_1=imread('lena512.bmp');
img_2=imresize(imread('cameraman.bmp'),[512,512]);


alpha = input('enter alpha value ')
 
 
if(alpha<0||alpha>1)
    warning('values must range from 0-1')
else
    img_3=((1-alpha)*img_1)+(alpha*img_2);
    titl=sprintf('the Blended Image for value of alpha=%0.1f',alpha);
imshow(img_3);
title(titl);
end