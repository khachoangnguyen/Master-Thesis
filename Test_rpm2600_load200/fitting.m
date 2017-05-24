function [b] = fitting(x1,x2,x3,y)
xdata = generateData(x1,x2,x3);
f = @(b,xdata)(b(1) + b(2)*xdata(:,2) + b(3)*xdata(:,3) + b(4)*xdata(:,4)...    %Linear terms
        + b(5)*xdata(:,5) + b(6)*xdata(:,6) + b(7)*xdata(:,7)...                  %Interaction terms
        + b(8)*xdata(:,8) + b(9)*xdata(:,9) + b(10)*xdata(:,10));                  %Quadratic terms
x0 = zeros(1,10);
OPTIONS = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt');
b = lsqcurvefit(f,x0,xdata,y,[],[],OPTIONS);
end