function [SS_e,s_e,SS_total,r_sq,r_sq_adj] = validation_test(matrix,b,y)
% Statistical calculation
for i = 1:length(matrix)
   x1v = matrix(i,1);
   x2v = matrix(i,2);
   x3v = matrix(i,3);
   xv = generateData(x1v,x2v,x3v);   
   yv(i,:) = xv*b';
end
y_real = y;
df_e = 10;
df_total = 19;
y_mean = (sum(y_real))/length(y_real);
e = y_real - yv;
SS_e = sum(e.^2);
SS_total = sum((y_real-y_mean).^2);    
s_e = SS_e/df_e;
r_sq = 1 - (SS_e/SS_total);
r_sq_adj = 1 -(df_total*SS_e)/(df_e*SS_total); 
end