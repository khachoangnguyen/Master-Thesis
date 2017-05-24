function xdata = generateData(x1,x2,x3)
    xdata = [ones(length(x1),1) x1 x2 x3 x1.*x2 x1.*x3 x2.*x3 x1.^2 x2.^2 x3.^2];
    %xdata = [x1 x2 x3 x1.*x2 x1.*x3 x2.*x3 x1.^2 x2.^2 x3.^2];
end