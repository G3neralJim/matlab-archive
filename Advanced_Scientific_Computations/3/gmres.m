clc;
clear;

% Parameters

nx = 100;
tol = 1e-5;
m = 20;
Nmax = 1000;

% Coefficient matrix
A = gallery('poisson', nx);
n = length(A);

% RHS
b = A*ones(n,1);

% Solve with GMRES
x = gmresf1(A,b,m,tol,Nmax);


