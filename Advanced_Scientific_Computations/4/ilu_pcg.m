clear;
clc;

A = gallery('poisson', 50);
n = length(A);
b = A*ones(n,1);

[L, U] = ilu(A);

pcg(A,b,1e-10,500);
pcg(A,b,1e-10, 500, L, U);
prec_cg(A,b,1e-10, 500, L, U);

