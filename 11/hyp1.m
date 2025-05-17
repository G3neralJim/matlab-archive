clc;
clear;

c = 0.3;

% Number of Intervals
n = 200;
nt = 400;

% Mesh size
h = 1/n;

% Laplacian
A = -gallery('tridiag', n-1);
I = speye(n-1);

% Time step
Tmax = 4;
dt = Tmax/nt;

% Initial condition
x = linspace(0,1,n+1)';
u = zeros(n+1,nt+1);

u(:, 1) = sin(pi*x);

% Compute r
r = c*dt/h;

% First step
u(2:n, 2) = 0.5 * (2*I + ((r^2)*A))*u(2:n, 1);

for j = 3:nt+1
    u(2:n, j) = (2*I + ((r^2)*A))*u(2:n, j-1) - u(2:n, j-2);
end

mesh(u);

