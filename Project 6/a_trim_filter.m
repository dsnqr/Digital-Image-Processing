%% Implementing alpha-trimmed filter
function mean = a_trim_filter(img)
[m,n] = size(img);
sum = 0;d = 0;
for i=1:m
for j=1:n
sum = sum + img(i,j);
end
end
mean = sum*(1/m*n - d);