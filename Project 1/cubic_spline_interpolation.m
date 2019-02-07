img = imread('goldhill256.bmp');
[m,n,x] = size(img);
k = 1;
l = 1;
f = 2;
k = 1;
l = 1;
%% Converting image to double the orignal size
zoom = zeros(m*f,n*f);
for i = 1:m
for j = 1:n
zoom(k,l) = img(i,j);
l=l+f;
end
k=k+f;
l = 1;
end
%% Interpolation
H = [1 1;1 1];
h1 = 0.25*conv2(H,H);
h2 = 0.25*conv2(h1,H);
h3 = 0.25*conv2(h2,H);
r = conv2(zoom,h3,'valid'); %Cubic Spline Interpolation
%% Displaying Images
figure(1);
imshow(img,[])
title('Orignal Image');
figure(2)
imshow(uint8(r));
title('Zooming using Cubic Spline Interpolator');