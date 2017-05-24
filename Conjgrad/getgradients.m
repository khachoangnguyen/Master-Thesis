function [fnorm,Deriv] = getgradients(X, N, myFx)

  for i=1:N
    xx = X(i);
    h = 0.01 * (1 + abs(xx));
    X(i) = xx + h;
    Fp = feval(myFx, X);
    X(i) = xx - h;
    Fm = feval(myFx, X);
    X(i) = xx;
    Deriv(i) = (Fp - Fm) / 2 / h;
  end
  fnorm = norm(Deriv);
 end