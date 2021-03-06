clear all;
close all;
clc;
%%MATLAB implementation of Pseudorandom Quantizer
%%Read the image 

img = imread('goldhill256.bmp');

%%Convert the datatype of the image to double for calculation in matlab

id = double(img);

%%Assign the different noise values for A

A = [22,89,113];

%%Number of bits

L = 2^3;

%%Looping through the different levels of noise

for i = 1:3
    %%quantization process for Pseudorandom quantization 
    
    %%generating pseudorandom noise
    
    ps_ran = randi([-A(i),A(i)],256,256);
    
    %%adding image and noise
    
    c = id(:,:,1) + ps_ran; 
    
    %%new min and max values according to c
    
    tk(1) = min(min(c));
    tk(L+1) = max(max(c));
    
    %%setting the quantization size
    
    q_size = (tk(L+1)-tk(1))/L;
    
    rk(1) = tk(1) + q_size;
    
    for k = 2:(L+1)
        tk(k) = tk(k-1) + q_size;
        rk(k-1) = tk(k-1) + q_size/2;        
    end
    
    %%creating quantization levels for pseudorandom quantization
    
    for m = 1:256
        for n = 1:256
            for p = 1:L
                if (c(m,n) < tk(p + 1) && c(m,n) >= tk(p))
                    res_img(m,n) = rk(p);
                end
            end
        end
    end

   
%%subtracting noise from image
res_img = res_img - ps_ran;

%%converting image to double datatype for calculating MSE and PSNR

out_img = double(res_img);

t = 0;

for q = 1:256
    for r = 1:256
        t = t + (id(q,r) - out_img(q,r))^2;
    end
end

%%calculating MSE and PSNR using formula
MSE = (1/(256^2))*t;
PSNR = 10*log10((255^2)/MSE);

%%results
figure(1)
subplot(2,2,i+1)
imshow(uint8(out_img))
title(['Quantized Image for L = 8 and A = ',num2str(A(i))])
xlabel(['MSE = ', num2str(MSE),' & PSNR =', num2str(PSNR)])
hold on
end
hold off
figure(1)
subplot(2,2,1)
imshow(img)
title('Orignal Image')

%%saving figure
saveas(gca,'Pseudorandom Quantizer','jpg')
