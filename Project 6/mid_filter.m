%% Implementing mid-point filter
function mean = mid_filter(img)
mean = (1/2)*(max(max(img))+min(min(img)));