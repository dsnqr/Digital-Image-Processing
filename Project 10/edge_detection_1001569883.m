clc;
clear all;
close all;
elain_img=imread('lena512.dib.bmp','bmp');
elain_img=double(elain_img);
so_bel_H_1 = [1,0,-1;2,0,-2;1,0,-1];
so_bel_H_2 = [1,2,1;0,0,0;-1,-2,-1];
pre_witt_H_1 = [-1,0,1;-1,0,1;-1,0,1];
pre_witt_H_2= [-1,-1,-1;0,0,0;1,1,1];
ro_bel_H_1 = [1,0;0,-1];
ro_el_H_2 = [0,1;-1,0];
Lap_Gaus_sian_H_1 = [1,1,1;1,-8,1;1,1,1];
 
 
 
cy_H=[2,4,5,4,2;4,9,12,9,4;5,12,15,12,5;4,9,12,9,4;2,4,5,4,2]/159;
cy_H_1=[-1,0,1;-2,0,2;-1,0,1];
cy_H_2=[1,2,1;0,0,0;-1,-2,-1];
 
 
[mt_1,mt_2,mt_3]=sobel_o_per_ator(elain_img,so_bel_H_1,so_bel_H_2);
[mt_4,mt_5,mt_6]=pre_witt_o_perator(elain_img,pre_witt_H_1,pre_witt_H_2);
[mt_7,mt_8,mt_9]=ro_bel_o_perator(elain_img,ro_bel_H_1,ro_el_H_2);
[mt_10,mt_11,mt_12]=gauss_ian_o_perator(elain_img,Lap_Gaus_sian_H_1);
[mt_13,mt_14,mt_15]=cy_o_perator(cy_H,cy_H_1,cy_H_2,elain_img);
 
 
figure(1);
imshow(uint8(elain_img));
title('Original image of elain imported');
 
figure(2);
subplot(2,2,1);
imshow(uint8(mt_1));
title('elain-sobel image before threshold');
subplot(2,2,2);
imshow(mt_2);
title('elain-sobel image after threshold');
subplot(2,2,3);
imshow(mt_3);
title('elain-Default sobel function');
 
 
figure(3);
subplot(2,2,1);
imshow(uint8(mt_4));
title('elain-prewitt image before threshold');
subplot(2,2,2);
imshow(mt_5);
title('elain-prewitt image after threshold');
subplot(2,2,3);
imshow(mt_6);
title('elain-Default prewitt function');
 
 
figure(4);
subplot(2,2,1);
imshow(uint8(mt_7));
title('elain-robel image before threshold');
subplot(2,2,2);
imshow(mt_8);
title('elain-robel image after threshold');
subplot(2,2,3);
imshow((mt_9));
title('elain-Default robel function');
 
 
figure(5);
subplot(2,2,1);
imshow(uint8(mt_10),[]);
title('gaussian image before threshold');
subplot(2,2,2);
imshow(mt_11);
title('gaussian image after threshold');
subplot(2,2,3);
imshow((mt_12));
title('Default gaussian function');
 
 
figure(6);
subplot(2,2,1);
imshow(uint8(mt_13));
title('canny image before threshold');
subplot(2,2,2);
imshow((mt_14));
title('canny image after threshold');
subplot(2,2,3);
imshow((mt_15));
title('Default canny function');
 
 
%  FUNCTIONS USED IN THE ABOVE PROGRAM
 
function [ mt_1,mt_2,mt_3 ] = sobel_o_per_ator(elain,sobel_H_1,sobel_H_2)
ii_c1 = conv2(elain,sobel_H_1);
ii_c2 = conv2(elain,sobel_H_2);
mt_1 = sqrt((ii_c1).^2 + (ii_c2).^2);
mt_2 = (mt_1 > 200);
mt_3 = edge(elain,'sobel',[]);
 
 
end
 
function [mt_4,mt_5,mt_6]=pre_witt_o_perator(elain,prewitt_H_1,prewitt_H_2)
ii_c1 = conv2(elain,prewitt_H_1);
ii_c2 = conv2(elain,prewitt_H_2);
mt_4 = sqrt(ii_c1.^2 + ii_c2.^2);
mt_5 = (mt_4 > 200);
mt_6 = edge(elain,'prewitt',[]);
 
 
 
end
 
 
function [mt_7,mt_8,mt_9]=ro_bel_o_perator(elain,robel_H_1,robel_H_2)
ro_bel_1 = conv2(elain,robel_H_1);
ro_bel_2 = conv2(elain,robel_H_2);
mt_7 = sqrt(ro_bel_1.^2 + ro_bel_2.^2);
mt_8 = (mt_7 > 60);
mt_9 = edge(elain,'roberts',[]);
 
 
 
end
 
 
function[mt_10,mt_11,mt_12]=gauss_ian_o_perator(elain,Lap_Gaussian_H_1)
i_filt = fspecial('gaussian');
i_filt = imfilter(elain,i_filt);
mt_10 = conv2(i_filt,Lap_Gaussian_H_1);
mt_11 = (mt_10 > 50);
mt_12 = edge(elain,'log',[]);  
 
 
end
 
 
function [mt_13,mt_14,mt_15]=cy_o_perator(cy_H,cy_H_1,cy_H_2,elain)
ii_c1 = conv2(elain,cy_H);
ii_cx = conv2(ii_c1,cy_H_1);
ii_cy = conv2(ii_c1,cy_H_2);
mt_13 = abs(ii_cx)+abs(ii_cy);
phas_1_12 = abs(atan2(ii_cy,ii_cx)*(180/pi));
dimen_sion = size(elain);
for ii = 1:dimen_sion(1)
    for jj = 1:dimen_sion(2)
        if (phas_1_12(ii,jj) <= 22.5 && phas_1_12(ii,jj) > 157.5)
            phas_1_12(ii,jj) = 0;
        elseif (phas_1_12(ii,jj) > 22.5 && phas_1_12(ii,jj) <= 67.5)
            phas_1_12(ii,jj) = 45;
        elseif (phas_1_12(ii,jj) > 67.5 && phas_1_12(ii,jj) <= 112.5)
            phas_1_12(ii,jj) = 90;
        elseif (phas_1_12(ii,jj) > 112.5 && phas_1_12(ii,jj) <= 157.5)
            phas_1_12(ii,jj) = 135;
        end
    end
end
tp1_12 = refr_1(mt_13,phas_1_12);
tp2 = (tp1_12 > 50);                  
[t1, t2] = find(tp1_12 > 60);  
mt_14 = bwselect(tp2, t2, t1, 8);
mt_15=edge(elain,'canny');
 
 
end
 
 
function tmp = refr_1(cy,cy_agle)
dimen_sion = size(cy);
tmp = zeros(dimen_sion(1),dimen_sion(2));  
agle = [0:180].*pi/180;    
xx_off = 1.5*cos(agle);   
yy_off = 1.5*sin(agle);  
hh_fract = xx_off - floor(xx_off);
vv_fract = yy_off - floor(yy_off); 
cy_agle = fix(cy_agle)+1;     
for ii =3:(dimen_sion(1) - 3)
    for jj =3:(dimen_sion(2) - 3) 
        o_r = cy_agle(ii,jj); 
        x_1 = jj + xx_off(o_r);
        y_1 = ii - yy_off(o_r);
        x_2 = floor(x_1);       
        x_x = ceil(x_1);
        y_2 = floor(y_1);
        y_y = ceil(y_1);
        a_1 = cy(y_2,x_2);    
        a_2 = cy(y_2,x_x);    
        a_3 = cy(y_y,x_2);
        a_4 = cy(y_y,x_x);
        uper_avg = a_1 + hh_fract(o_r) * (a_2 - a_1);  
        lwer_avg = a_3 + hh_fract(o_r) * (a_4 - a_3);
        v_1 = uper_avg + vv_fract(o_r) * (lwer_avg - uper_avg);
        if (cy(ii, jj) > v_1)
            x_1 = jj - xx_off(o_r); 
            y_1 = ii + yy_off(o_r);
            x_2 = floor(x_1);
            x_x = ceil(x_1);
            y_2 = floor(y_1);
            y_y = ceil(y_1);
            a_1 = cy(y_2,x_2);
            a_2 = cy(y_2,x_x);
            a_3 = cy(y_y,x_2);
            a_4 = cy(y_y,x_x);
            uper_avg = a_1 + hh_fract(o_r) * (a_2 - a_1);
            lwer_avg = a_3 + hh_fract(o_r) * (a_4 - a_3);
            v2 = uper_avg + vv_fract(o_r) * (lwer_avg - uper_avg);
            if (cy(ii,jj) > v2)        
                tmp(ii, jj) = cy(ii, jj); 
            end
        end
    end
end
end

