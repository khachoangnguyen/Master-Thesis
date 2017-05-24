function [y_real] = realModel(x1,x2,x3,noise)
    %y_real = 3*(x1)^2 + 7*exp(x2) - x3^2 + x2*x3 + noise;  
    y_real = (x1^2 + x2^2) + 36.58*x1*x3 - 85*x2^2 + 150*x1*x2 + x3^2 + noise;
end