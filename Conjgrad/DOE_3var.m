clear all
clc
% Real model: y(x1,x2) = 3*[sin(x1)]^2 + 7*e^(x2) - x2^2
% fitresult(x,y) = b0 + b1*x + b2*y + b12*x*y  + b11*x^2 + b22*y^2
global x_1
global x_2
global x_3
global b    
n = 8;
range_x1 = [-2:3];
range_x2 = [-1:4];
range_x3 = [-0.55:0.35];
x1_min = min(range_x1); 
x1_max = max(range_x2); 
x2_max = max(range_x1);
x2_min = min(range_x2);
x3_min = min(range_x3); 
x3_max = max(range_x3); 

a = n^(1/4);
noise = 0.1*rand;

matrix = matrixDesign_3var(x1_max,x1_min,x2_max,x2_min,x3_max,x3_min,a);   %Getting running table
[x1,x2,x3,y] = simulation_3var(matrix,noise);                   %Model simulation
xdata = generateData(x1,x2,x3);
f = @(b,xdata)(b(1) + b(2)*xdata(:,2) + b(3)*xdata(:,3) + b(4)*xdata(:,4)...    %Linear terms
        + b(5)*xdata(:,5) + b(6)*xdata(:,6) + b(7)*xdata(:,7)...                  %Interaction terms
        + b(8)*xdata(:,8) + b(9)*xdata(:,9) + b(10)*xdata(:,10));                  %Quadratic terms
x0 = zeros(1,10);
b = lsqcurvefit(f,x0,xdata,y);

%% Validation
t = 20;

x1v = linspace(x1_min,x1_max,t)';
x2v = linspace(x2_min,x2_max,t)';
x3v = linspace(x3_min,x3_max,t)';

[SS_e,s_e,SS_total,r_sq,r_sq_adj] = validation_3var(x1v,x2v,x3v,noise,b)
%% Optimization
f1 = @(X1,X2,X3) b(1) + b(2)*X1 + b(3)*X2 + b(4)*X3...
      + b(5)*X1*X2 + b(6)*X1*X3 + b(7)*X2*X3...
      + b(8)*X1^2 + b(9)*X2^2 + b(10)*X3^2;
f_op = @(X) f1(X(1),X(2),X(3))
X0 = [0 0 0];
[X,LastF,Iters] = conjgrad(3,X0,1e-07,10,f_op)
