image = imread('goldhill256.bmp');

[r,c,x] = size(image);

N = zeros(2*r,2*c);
h = [1 1;1 1];
for i = 1:1:r
    for j = 1:1:c
        for k = j*2:1:(j*2+2)
            N(2*i,k) = image(i,j);
        end
    end
end

for i = 1:2:r*2
    for j = 1:1:c*2
        N(i,j) = N(i+1,j);
    end
end

r = conv2(N,h/4,'valid');

figure(1)
imshow(image);
title('Original');

figure(3)
imshow(r,[]);
title('Zoomed')
