clc;
clear;

##Size of Matrix
n = 100;

##Matrix Init
A = gallery('tridiag', n);
A0 = A;
##Number of Eigenvalues
Neig = n;

##Inputs
tol = 1e-6;
Nmax = 5000;

##Matrices init
lamdas = zeros(Neig, 1);
V = zeros(n,Neig);

##[v,lamda] = powit(A,Nmax,tol);

##Method

for i = 1:Neig
##  Power Iteration
  [V(:,i),lamdas(i)] = powit(A,Nmax,tol);
##  Weilandt Deflation
  A=A-lamdas(i)*V(:,i)*V(:,i)';
end

