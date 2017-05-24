function [SSE,s_e,SS_total,r_sq,yv,y_real] = validation_LOESS(x1v,x2v,fitresult,noise)
yv = fitresult(x1v,x2v);
global x_1
global x_2
y_real = zeros(length(x1v),length(x1v));
for i = 1:length(x1v)
    for j = 1:length(x2v)
   
   x_1 = x1v(i,j);
   x_2 = x2v(i,j);
   
   y_real(i,j) = realModel(x_1,x_2,noise);
 
    end
end
y_mean = sum(sum(y_real,2))/(length(y_real)*length(y_real));
SSE = sum(sum((yv-y_real).^2,2));
SS_total = sum(sum((yv-y_mean).^2,2));    
s_e = SSE/4;
r_sq = 1 - (SSE/SS_total);
figure
surf(x1v,x2v,yv)
hold on
surf(x1v,x2v,y_real,'FaceColor','interp')
end


