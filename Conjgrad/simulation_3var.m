function [x1,x2,x3,y] = simulation_3var(matrix,noise)
global x_1
global x_2
global x_3
y = zeros(length(matrix),1);
x1 = zeros(length(matrix),1);
x2 = zeros(length(matrix),1);
x3 = zeros(length(matrix),1);
for i = 1:length(matrix)
   x_1 = matrix(i,1);
   x_2 = matrix(i,2);
   x_3 = matrix(i,3);
      
   y(i,:) = realModel(x_1,x_2,x_3,noise);
   x1(i,:) = x_1;
   x2(i,:) = x_2;
   x3(i,:) = x_3;
end
end