clear;
clc;

##Size of Matrix
n = 10;

##Tolerance
tol = 1e-6;

##Max Number of Loops
Nmax = 5000;

##Initialization
A = gallery('tridiag', n);
I = speye(n);

##Initial Guessclear;
clc;

##Size of Matrix
n = 50;

##Tolerance
tol = 1e-6;

##Max Number of Loops
Nmax = 5000;

##Initialization
A = gallery('tridiag', n);

##Initial Guess
x0 = randn(n, 1);

##Normalize
x0 = x0 / norm(x0, inf);

##Compute Lamda
l0 = (x0'*A*x0)/(x0'*x0);
sigma = l0;

prel = l0;

##Method

for i = 1:Nmax
  y = A\x0;
  y = y / norm(y, inf);
  l = (y'*A*y)/(y'*y);
  sigma = l;

  if ((abs(l0-l))/(prel)) < tol
    disp(['Iteration: ' num2str(i)]);
    break;
  endif

  l0 = l;
  x0 = y;
end
