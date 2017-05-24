clear all
clc
% Real model: y(x1,x2) = 3*[sin(x1)]^2 + 7*e^(x2) - x2^2
% fitresult(x,y) = b0 + b1*x + b2*y + b12*x*y
global x_1
global x_2
n = 4;
lim_x1 = 1;
lim_x2 = 1;
x1_min = -lim_x1; 
x1_max = lim_x1;
x2_min = -lim_x2; 
x2_max = lim_x2;
a = 0;
noise = 0.1*rand;
matrix = matrixDesign(x1_max,x1_min,x2_max,x2_min,a);
[x1,x2,y] = simulation(matrix,noise);
[fitresult, gof] = createFit(x1,x2,y)
%% Validation
B = [fitresult.b0; fitresult.b1; fitresult.b2; fitresult.b12];
x1v = meshgrid(-lim_x1:.1:lim_x1);
x2v = (meshgrid(-lim_x2:.1:lim_x2))';
[SSE,s_e,SS_total,r_sq] = validation_2x2(x1v,x2v,B)

