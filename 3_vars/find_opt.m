function [x_op,fval,iter] = find_opt(X0,b)
f = @(X1,X2,X3) b(1) + b(2)*X1 + b(3)*X2 + b(4)*X3...
      + b(5)*X1*X2 + b(6)*X1*X3 + b(7)*X2*X3...
      + b(8)*X1^2 + b(9)*X2^2 + b(10)*X3^2;
f_op = @(X) f(X(1),X(2),X(3));
% options = optimoptions('fminunc','Algorithm','quasi-newton');
% options.Display = 'iter';
% [x, fval, exitflag, output] = fminunc(f_op,X0,options);
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0.07,750,-0.2];
ub = [0.37,1350,12];
nonlcon = [];
options = optimoptions(@fmincon,'Algorithm','sqp','MaxIterations',150);
%sequential quadratic programming
[x,fval,exitflag,output,lambda,grad,hessian] = fmincon(f_op,X0,A,b,Aeq,beq,lb,ub,nonlcon,options);
iter = output.iterations;
x_op = x;
end