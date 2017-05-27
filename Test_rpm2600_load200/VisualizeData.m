function VisualizeData(b,bounds,X_op)
b1 = b.Estimate;
f = @(X1,X2) b1(1) + b1(2)*X1 + b1(3)*X2 + b1(4)*X_op(3)...
      + b1(5)*X1*X2 + b1(6)*X1*X_op(3) + b1(7)*X2*X_op(3)...
      + b1(8)*X1^2 + b1(9)*X2^2 + b1(10)*X_op(3)^2;

x1_min = bounds(1,1); 
x1_max = bounds(1,2); 
x2_max = bounds(2,1);
x2_min = bounds(2,2);
t = 20;
d_1 = gridResolution(x1_max,x1_min,t);
d_2 = gridResolution(x2_max,x2_min,t);

x1 = meshgrid(x1_min:d_1:x1_max);
x2 = (meshgrid(x2_min:d_2:x2_max))';
for i = 1:length(x1)
    for j = 1:length(x2)
   
   x_1 = x1(i,j);
   x_2 = x2(i,j);
   F(i,j) = feval(f,x_1,x_2);
   
 
    end
end

surf(x1,x2,F)
legend('BSFC')
ylabel('CRP (Pa)')
xlabel('Pi (Pa)')
zlabel('BSFC (g/kW.h)')
title('Brake Specific Fuel Consumption')
colorbar('Ticks',[180,190,200],'TickLabels',{'Low','Medium','High'})

% Showing minimum point
hold on
[~,i] = min(F(:));
h = scatter3(x1(i),x2(i),F(i),'filled');
h.SizeData = 150;
hold off

end