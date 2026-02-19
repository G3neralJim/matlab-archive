function [y, l0] = powit(A,Nmax,tol)

##Initial Guess
x0 = randn(length(A), 1);

##Normalize
x0 = x0 / norm(x0, inf);

##Compute Lamda
l0 = (x0'*A*x0)/(x0'*x0);

prel = l0;

##Method

for i = 1:Nmax
  y = A*x0;
  y = y / norm(y, inf);
  l = (y'*A*y)/(y'*y);

  if ((abs(l0-l))/(prel)) < tol
    disp(['Iteration: ' num2str(i)]);
    break;
  endif

  l0 = l;
  x0 = y;
end

y = y / norm(y);

