function [x1,x2,y] = simulation(matrix,noise)
global x_1
global x_2
y = zeros(length(matrix),1);
x1 = zeros(length(matrix),1);
x2 = zeros(length(matrix),1);
for i = 1:length(matrix)
   x_1 = matrix(i,1);
   x_2 = matrix(i,2);
   
      
   y(i,:) = realModel(x_1,x_2,noise);
   x1(i,:) = x_1;
   x2(i,:) = x_2;
   
end
end