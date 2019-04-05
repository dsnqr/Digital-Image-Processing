clc;
clear all;
close all;

%% Reading and displaying the 512*512 grayscale image

img = imread('lena512.bmp');
figure;
imshow(img);
title('Orignal Image');
saveas(gca,'original.jpg');

%% DFT and display in frequency domain of the image read
size = 512;
DFT = fft2(img);
DFT = fftshift(DFT);
figure;
imshow(DFT);
title('DFT of Orignal Image')
saveas(gca,'DFT.jpg');

%% Algorithm for the Low Pass Filter

LPF = zeros(size,size);
D = zeros(size,size);
D_0 = sqrt(40^2+60^2);
for k=1:1:size
for l=1:1:size
D(k,l)=sqrt((k-(size/2))^2+(l-(size/2))^2);
if (D(k,l)<=D_0)
LPF(k,l)=1;
end
end
end

%% Display the 3D plot of the HPF
figure
mesh(LPF);
xlabel('Spatial freq l');
ylabel('Spatial freq k');
zlabel('Amplitude ');
colormap(hsv);
shading interp;
alpha(0.7);
grid on;
axis tight;
saveas(gca,'LPF_3D.jpg');
hold on;

%% Plotting the results of LPF on the image

figure
imshow(LPF);
title('LP Filter');
saveas(gca,'LPF_img.jpg');

%% Algorithm for High Pass Filter

size=512;
HPF = zeros(size,size);
d = zeros(size,size);
d0 = sqrt(40^2+60^2);
for k=1:1:size
for l=1:1:size
d(k,l) = sqrt((k-(size/2))^2+(l-(size/2))^2);
if (d(k,l)>=d0)
HPF(k,l) = 1;
end
end
end

%% Plotting the results of HPF on the image

figure
imshow(HPF);
title('HP Filter');
saveas(gca,'HPF_img.jpg');

%% Display the 3D plot of the HPF
figure
mesh(HPF);
xlabel('Spatial freq l');
ylabel('Spatial freq k');
zlabel('Amplitude g');
colormap(hsv);
shading interp;alpha(0.7);
grid on;
axis tight;
hold on;
saveas(gca,'HPF_3D.jpg');

%% Algorithm for Gaussian Low Pass Filter

sigma = 16;
gaussian_LPF = zeros(512,512);
for k=1:1:size
for l=1:1:size
gaussian_LPF(k,l)=exp(-((k-(size/2))^2+(l-(size/2))^2)/(2*sigma^2));
end
end

%% Display the 3D plot of the Gaussian LPF

figure
surf(gaussian_LPF, 'EdgeColor', 'none');
xlabel('Spatial freq l');
ylabel('Spatial freq k');
zlabel('Amplitude g');
colormap(hsv);
shading interp;
alpha(0.7);
grid on;
axis tight;
hold on;
saveas(gca,'Gaussian_LPF_3D.jpg');

%% Display Gaussian LPF

figure
imshow(gaussian_LPF);
title('Gaussian LPF')
saveas(gca,'G_LPF.jpg');
gaussianLP_transform = fft2(gaussian_LPF);
gaussianLP_transform = fftshift(gaussianLP_transform);

%% Plotting the results of Gaussian LPF on the image

figure
imshow(gaussianLP_transform);
title('Gaussian LPF transform');
saveas(gca,'G_LPF_img.jpg');

%% Algorithm for Gaussian High Pass Filter
sigma = 16;
gaussian_HPF = zeros(512,512);
for k=1:1:size
for l=1:1:size
gaussian_HPF(k,l) = 1-exp(-((k-(size/2))^2+(l-(size/2))^2)/(2*sigma^2));
end
end

%% Display 3D plot of Gaussian HPF

figure
surf(gaussian_HPF, 'EdgeColor', 'none');
xlabel('Spatial freq l');
ylabel('Spatial freq k');
zlabel('Amplitude g');
colormap(hsv);
shading interp;
alpha(0.7);
grid on;
axis tight;
hold on;
saveas(gca,'Gaussian_HPF_3D.jpg');

%% Dispaly Gaussian HPF

figure
imshow(gaussian_HPF);
title('Gaussian HP');
saveas(gca,'G_HPF.jpg');
gaussianHP_transform = fft2(gaussian_HPF);
gaussianHP_transform = fftshift(gaussianHP_transform);

%% Plotting the results of Gaussian HPF on the image

figure
imshow(gaussianHP_transform);
title('Gaussian HP transform');
saveas(gca,'G_HPF_img.jpg');


% %% Algorithm for Butterworth Low Pass Filter
% Butterworth_LP = zeros(512,512);
% n = 3;d0 = 40;
% for k=1:1:size
% for l=1:1:size
% d(k,l) = sqrt((k-(size/2))^2+(l-(size/2))^2);
% Butterworth_LP(k,l) = 1/(1+(d(k,l)/d0)^(2*n));
% end
% end
% 
% 
% figure
% imshow(Butterworth_LP);
% title('Butterworth LP');
% figure
% surf(Butterworth_LP, 'EdgeColor', 'none');
% xlabel('Spatial freq l');
% ylabel('Spatial freq k');
% zlabel('Amplitude g');
% colormap(hsv);
% shading interp;
% alpha(0.7);
% grid on;
% axis tight;
% hold on;
% % %% Butterworth High Pass Filter
% % Butterworth_HP=zeros(512,512);
% % n=3;
% % d0=50;
% % for k=1:1:size
% % for l=1:1:size
% % d(k,l)=sqrt((k-(size/2))^2+(l-(size/2))^2);
% % Butterworth_HP(k,l)=1/(1+(d0/d(k,l))^(2*n));
% % end
% % end
% % figure
% % imshow(Butterworth_HP);
% % title('Butterworth HP');
% % figure
% % surf(Butterworth_HP, 'EdgeColor', 'none');
% % xlabel('Spatial freq l');
% % ylabel('Spatial freq k');
% % zlabel('Amplitude g');
% % colormap(hsv);
% % shading interp;
% % alpha(0.7);
% % grid on;
% % axis tight;
% % hold on;