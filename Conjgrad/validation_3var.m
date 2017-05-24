function [SS_e,s_e,SS_total,r_sq,r_sq_adj] = validation_3var(x1v,x2v,x3v,noise,b)

global x_1
global x_2
global x_3

y_real = zeros(length(x1v)*length(x2v)*length(x3v),1);
yv = zeros(length(x1v)*length(x2v)*length(x3v),1);
for i = 1:length(x1v)
    for j = 1:length(x2v)
        for k = 1:length(x3v)
   x_1 = x1v(i);
   x_2 = x2v(j);
   x_3 = x3v(k);
   xv = generateData(x_1,x_2,x_3);
   yv(i*j*k) = xv*b';
   y_real(i*j*k) = realModel(x_1,x_2,x_3,noise);
        end
    end
end
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