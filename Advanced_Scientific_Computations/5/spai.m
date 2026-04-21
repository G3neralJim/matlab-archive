clear;
clc;

% Read matrix and form RHS
A = load('orsirr_2.mat');
A = A.Problem.A; %% Extract matrix from struct
n = length(A);
b = A*ones(n,1);

% Parameters
lfill = 2;
tol = 1e-10;
Nmax = 1000;
m = 20;


% Form sparsity pattern
M = A^lfill;
E = speye(n,n);

% Computaton
for i = 1:n
    J = find(M(:,i));
    Ar = A(:,J);
    I = find(sum(Ar|Ar,2)~=0);
    Ar = Ar(I,:);
    e = E(I,i);
    V = Ar\e;
    M(J,i)=V;
end

% Solve
gmres(A,b,m,tol,Nmax);
gmres(A,b,m,tol,Nmax,@(x) M*x);

bicgstab(A,b,tol,Nmax);
bicgstab(A,b,tol,Nmax,@(x) M*x);