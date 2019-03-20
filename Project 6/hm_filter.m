%% Implementing Harmonic Mean filter
function mean = hm_filter(img)
[m,n] = size(img);
sum = 0;Q = 1;
for i=1:m
for j=1:n
sum = sum + 1/img(i,j);
end
end
mean = (m*n)/sum;
