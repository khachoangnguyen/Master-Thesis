clear all
clc
% Real model: y(x1,x2) = 3*[sin(x1)]^2 + 7*e^(x2) - x2^2
% fitresult(x,y) = b0 + b1*x + b2*y + b12*x*y  + b11*x^2 + b22*y^2
global x_1
global x_2
n = 4;
range_x1 = [-5:5];
range_x2 = [-5:5];
x1_min = min(range_x1); 
x1_max = max(range_x2); 
x2_max = max(range_x1);
x2_min = min(range_x2);
a = n^(1/4);
noise = 0.1*rand;
matrix = matrixDesign(x1_max,x1_min,x2_max,x2_min,a);   %Getting running table
[x1,x2,y] = simulation(matrix,noise);                   %Model simulation
[fitresult, gof] = createFit_RSM(x1,x2,y)               %Fitting model

%% Validation
B = [fitresult.b0; fitresult.b1; fitresult.b2; fitresult.b12; fitresult.b11; fitresult.b22];

t = 20;
d_1 = gridResolution(x1_max,x1_min,t);
d_2 = gridResolution(x2_max,x2_min,t);

x1v = meshgrid(x1_min:d_1:x1_max);
x2v = (meshgrid(x2_min:d_2:x2_max))';

[SSE,s_e,SS_total,r_sq] = validation(x1v,x2v,B,noise)

