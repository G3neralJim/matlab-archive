clear;
clc;

##Size of Matrix
n = 100;

##Tolerance
tol = 1e-6;

##Max Number of Loops
Nmax = 5000;

##Initialization
A = gallery('tridiag', n);
I = eye(n);

##Initial Guess
x0 = randn(n, 1);
%x0 = ones(n,1);
%it appears that when i am not using a random vector for x0, method does not converge to the closest lamda to sigma.


##Normalize
x0 = x0 / norm(x0, inf);

##Compute Lamda
%l0 = (x0'*A*x0)/(x0'*x0);

l0 = 3.5;
sigma = l0;
prel = l0;

##Method

for i = 1:Nmax
  y = (A-(sigma*I))\x0;
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

l
