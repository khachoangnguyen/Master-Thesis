%% Importing data 
clear all
clc
% fitresult(x,y) = b0 + b1*x + b2*y + b12*x*y  + b11*x^2 + b22*y^2
%data = importdata('20170518-1300rpm-load100.xlsx');
%% Design of Experiments (DoE)

range_x1 = [0.1,0.9];
range_x2 = [1100,1400];
range_x3 = [-4,13];
% noise = rand;
%[matrix,c1,c2,c3] = matrixDesign_3var(range_x1,range_x2,range_x3); %Getting running table
[matrix,c1,c2,c3] =  matrixDesign_BoxBehnken(range_x1,range_x2,range_x3);
%% Data extracting & processing
%[x1,x2,x3,y] = simulation_3var(matrix,noise);  %Model simulation
rpm = 1600; load = 200; n = size(matrix,1);
y = extractData(rpm,load,n);
x1 = zeros(length(matrix),1);
x2 = zeros(length(matrix),1);
x3 = zeros(length(matrix),1);
for i = 1:length(matrix)
   x_1 = matrix(i,1);
   x_2 = matrix(i,2);
   x_3 = matrix(i,3);
      
%    y(i,:) = 215 + cos(i*pi)*5*rand;
   x1(i,:) = x_1;
   x2(i,:) = x_2;
   x3(i,:) = x_3;
end

%% Fitting model

[b] = fitting(x1,x2,x3,y)

%% Validation

%[SS_e,s_e,SS_total,r_sq,r_sq_adj] = validation_3var(range_x1,range_x2,range_x3,noise,b,y)

[SS_e,s_e,SS_total,r_sq,r_sq_adj] = validation_test(matrix,b,y)

%% Optimization
X0 = [c1 c2 c3];
[X_op,fval,iter] = find_opt(X0,b)

