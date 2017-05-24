function [d] = gridResolution(lim_max,lim_min,t)
diff = lim_max - lim_min;
d = diff/t;
end