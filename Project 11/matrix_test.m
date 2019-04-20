% Z1_mtrx_512_one = zeros(512);
% Z2_mtrx_512_two = zeros(512);
% Z3_mtrx_512_three = zeros(512);
DFT1_mtrx_512_one = fft2(zeros(512));
% DFT2_mtrx_512_two = fft2(Z2_mtrx_512_two);
% DFT3_mtrx_512_three = fft2(Z3_mtrx_512_three);
Z1_mtrx_512_one = wiener_fil(0.0025);
Z2_mtrx_512_two = wiener_fil(0.001);
Z3_mtrx_512_three = wiener_fil(0.00025);
function Hh_1234 = wiener_fil(k_321)
N_s_321 = 512;
for uu_11 = 1:N_s_321
for vv_11 = 1:N_s_321
Hh_1234(uu_11,vv_11) = exp(-k_321*((uu_11-N_s_321/2)^2+(vv_11-N_s_321/2)^2)^(5/6));
end
end
end