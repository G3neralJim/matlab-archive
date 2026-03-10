clc;
clear;

##%Size of Matrix
n = 100;

##Matrix Init
A = gallery('tridiag', n);
A0 = A;
##Number of Eigenvalues
Neig = 5;

##Inputs
tol = 1e-6;
Nmax = 5000;

##Matrices init
lamdas = zeros(Neig, 1);
V = zeros(n,Neig);

[v,lamda] = powit(A,Nmax,tol);

##Method

for i = 1:Neig
##  Power Iteration (should be inverse)
  [V(i:end,i),lamdas(i)] = powit(A,Nmax,tol);
##  Weilandt Deflation
  x = A(1,:)/V(i,i);
  A=A-V(i:end,i)*x;

  A = A(2:end, 2:end);
end

