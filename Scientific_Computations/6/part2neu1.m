clear;
clc;

% Delcare bins for each dimension
nx = 200;
ny = 200;

% Mesh size per dimension
hx = 1/nx;
hy = 1/ny;

% Identity Matrices
Ix = speye(nx);
Iy = speye(ny);


% T Matrices
Tx = -gallery('tridiag', nx) / hx^2;
Tx(nx,nx-1) = 2/hx^2;
Ty = -gallery('tridiag', ny) / hy^2;
Ty(ny,ny-1) = 2/hy^2;

% Coefficent Matrix
A2D = kron(Iy, Tx) + kron(Ty, Ix);

% Form rhs
F = ones((nx)*(ny),1);

% Solve
x = A2D\F;
xr = reshape(x, nx,ny);

mesh(xr);