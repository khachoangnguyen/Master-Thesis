function [y_real] = realModel(x1,x2,x3,noise)
    %y_real = 3*[sin(x1)]^2 + 7*exp(x2) - x2^2 + noise;  
    y_real = sqrt(x1^2 + x2^2) + 0.3658*x1 - 0.5624*x2^2 + x1*x2 + x3^2;
end