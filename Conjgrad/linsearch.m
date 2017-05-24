function lambda = linsearch(X, N, lambda, initStep, minStep, D, myFx)

  f1 = myFxEx(N, X, D, lambda, myFx);
  while initStep > minStep
    f2 = myFxEx(N, X, D, lambda + initStep, myFx)  ;
    if f2 < f1
      f1 = f2;
      lambda = lambda + initStep;
    else
      f2 = myFxEx(N, X, D, lambda - initStep, myFx);
      if f2 < f1
      else
        f1 = f2;
        lambda = lambda - initStep;
        % reduce search step size
        initStep = initStep / 10;
      end
    end
  end
end