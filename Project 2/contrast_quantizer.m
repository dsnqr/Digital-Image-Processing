clear all;
close all;
clc;
%%MATLAB implementation of Contrast Quantizer
%%Read the image 

img = imread('goldhill256.bmp');

%%Convert the datatype of the image to double for calculation in matlab

id = double(img);

%%Assign the number of levels of Quantization

L = [40,60,80];

%%Looping through the different levels of quantization

for i = 1:3
        
    %%quantization process for Contrast quantization
    %%Assign the values of alpha and beta
    alpha = 1;
    beta = 1/3;
    
    %%converting Luminance to contrast domain
    
    c = alpha * id(:,:).^beta;
    
    %%new max and min according to c
    tk(1) = min(min(c));
    tk(L(i)+1) = max(max(c));
    
    %%setting the quantization size
    
    q_size = (tk(L(i)+1)-tk(1))/L(i);
    
    rk(1) = tk(1) + q_size;
    
    for k = 2:(L(i)+1)
        tk(k) = tk(k-1) + q_size;
        rk(k-1) = tk(k-1) + q_size/2;        
    end
    
    %%creating quantization levels for contrast quantization
    
    for m = 1:256
        for n = 1:256
            for p = 1:L(i)
                if (c(m,n) < tk(p + 1) && c(m,n) >= tk(p))
                    res_img(m,n) = rk(p);
                end
            end
        end
    end

   
%%Converting contrast back to Luminance
out_img = ((res_img).^(1/beta))/alpha; 
%%converting image to double for calculating MSE and PSNR
out_img = double(out_img);

t = 0;

for q = 1:256
    for r = 1:256
        t = t + (id(q,r) - out_img(q,r))^2;
    end
end
%%calculating MSE according to formula

MSE = (1/(256^2))*t;

%%calculating PSNR according to formula

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
%%saving figure
saveas(gca,'Contrast Quantizer','jpg')
