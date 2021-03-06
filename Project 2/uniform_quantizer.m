clear all;
close all;
clc;
%%MATLAB implementation of Uniform Quantizer
%%Read the image 

img = imread('goldhill256.bmp');

%%Convert the datatype of the image to double for calculation in matlab

id = double(img);

%%Assign the number of levels of Quantization

L = [32,64,128];

%%Looping through the different levels of quantization

for i = 1:3
    %%setting the quantization size
    q_size = 256/L(i);
    
    tk(1) = 0;
    
    %%quantization process for Uniform quantization
    
    for k = 2:(L(i)+1)
        tk(k) = tk(k-1) + q_size;
        rk(k-1) = tk(k-1) + q_size/2;        
    end
    
    %%creating quantization levels for uniform quantization
    
    for m = 1:256
        for n = 1:256
            for p = 1:L(i)
                if (id(m,n) < tk(p + 1) && id(m,n) >= tk(p))
                    res_img(m,n) = rk(p);
                end
            end
        end
    end

%%converting res_image to double datatype for calculating MSE & PSNR
out_img = double(res_img);

t = 0;

for q = 1:256
    for r = 1:256
        t = t + (id(q,r) - out_img(q,r))^2;
    end
end
%%calulating MSE using formula

MSE = (1/(256^2))*t;

%%calculating PSNR using formula

PSNR = 10*log10((255^2)/MSE);

%%results

figure(1)
subplot(2,2,i+1)
imshow(uint8(out_img))
title(['Quantized Image for L = ',num2str(L(i))])
xlabel(['MSE = ', num2str(MSE),' & PSNR =', num2str(PSNR)])
hold on
end
hold off
figure(1)
subplot(2,2,1)
imshow(img)
title('Orignal Image')

%%saving figure file

saveas(gca,'Uniform Quantizer','jpg')
