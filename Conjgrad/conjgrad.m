function [X,LastF,Iters] = conjgrad(N,X,Eps_Fx,MaxIter,myFx)
% Function performs multivariate optimization using the
% Hooke-Jeeves search method.
%
% Input
%
% N - number of variables
% X - array of initial guesses
% Eps_Fx - tolerance for diffence in successive function values
% MaxIter - maximum number of iterations
% myFx - name of the optimized function
%
% Output
%
% X - array of optimized variables
% LastF - function value at optimum
% Iters - number of iterations
%

initStep = 0.1;
minStep = 0.000001;
LastF = feval(myFx, X);
[dfnorm,Deriv] = getgradients(X, N, myFx); %Step 2

lambda = 0;
lambda = linsearch(X, N, lambda, initStep, minStep, Deriv, myFx);
X = X + lambda * Deriv;

bGoOn = true;
Iters = 0;

while bGoOn

  Iters = Iters + 1;
  if Iters > MaxIter
    break;
  end

  dfnormOld = dfnorm;
  DerivOld = Deriv;
  [dfnorm,Deriv] = getgradients(X, N, myFx);
  Deriv = (dfnorm / dfnormOld)^2 * DerivOld - Deriv;  %Step4
  if dfnorm < Eps_Fx
    break;
  end
  lambda = 0;
  lambda = linsearch(X, N, lambda, initStep, minStep, Deriv, myFx); %Step 5
  X = X + lambda * Deriv; % Step 6
  F = feval(myFx, X);
  if abs(F - LastF) < Eps_Fx
    bGoOn = false;
  else
    LastF = F;
  end

end

LastF = feval(myFx, X);
end