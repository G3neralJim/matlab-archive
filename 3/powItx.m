##=================================================================
##
##                      WORK IN PROGRESS.
##
## right now it's just a bad attempt :P, don't expect it to work.
##
##=================================================================







function [y, l0] = powItx(Ax, x, LoA, Nmax, tol)

##Traspose of x
xt = x';

##Initial Guess
x0 = randn(LoA, 1);

##Normalize
x0 = x0 / norm(x, inf);

##Compute Lamda
l0 = (x0'*Ax*xt*x0)/(x0'*x0);


prel = l0;

##Method

for i = 1:Nmax
  y = Ax*xt*x0;
  y = y / norm(y, inf);
  l = (y'*Ax*xt*y)/(y'*y);

  if ((abs(l0-l))/(prel)) < tol
    disp(['Iteration: ' num2str(i)]);
    break;
  endif

  l0 = l;
  x0 = y;
end

y = y / norm(y);
