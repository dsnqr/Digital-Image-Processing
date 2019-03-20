%% Implementing Contr-Harmonic Mean filter
function mean = c_hm_filter(img)
[m,n] = size(img);
s0 = 0;s1 = 0;Q = 1;
for i=1:m
for j=1:n
s0 = s0 + img(i,j)^(Q+1);
s1 = s1 + img(i,j)^Q;
end
end
mean = s0/s1;