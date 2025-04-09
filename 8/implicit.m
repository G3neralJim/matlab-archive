clc;
clear;

% Parameters
c = 0.069;
L = 1;

nx = 1000;
nt = 100;

Tmax = 5*0.42;

% Derived Parameters
h = L/nx;
dt = Tmax / nt;

A = -gallery('tridiag', nx-1) / h^2;
I = speye(nx-1);

% Initial condition
x = linspace(0, L, nx+1)';

% Initialize Temp matrix_type
T = zeros(nx+1, nt+1);
T(:,1) = sin(pi*x);

% Advance in time
for i = 2:nt
    T(2:nx, i) = (I-dt*c*A)\T(2:nx,i-1);
end

mesh(T);
