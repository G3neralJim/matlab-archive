clc;
clear;

% Parameters
c = 0.5;
L = 1;

nx = 10;
nt = 2400;

Tmax = 5*0.42;

% Derived Parameters
h = L/nx;
dt = Tmax / nt;

A = -gallery('tridiag', nx) / h^2;
A(1,2) = 2/h^2;
I = speye(nx);



% Initial condition
x = linspace(0, L, nx+1)';

% Initialize Temp matrix_type
T = zeros(nx+1, nt+1);
T(:,1) = cos(pi*x);

% Advance in time
for i = 2:nt
    T(1:nx, i) = (I+dt*c*A)*T(1:nx,i-1);
end

mesh(T);
