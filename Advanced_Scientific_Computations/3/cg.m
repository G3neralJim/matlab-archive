clc;
clear;

% Parameters

nx = 10;
tol = 1e-5;

Nmax = 500;

% Coefficient matrix
A = gallery('poisson', nx);
n = length(A);

% RHS
b = A*ones(n,1);

% Solve with CG
x = cgf1(A,b,tol,Nmax);


