clear;
clc;

% Delcare bins for each dimension
nx = 50;
ny = 20;
nz = 20;

% Mesh size per dimension
hx = 1/nx;
hy = 1/ny;
hz = 1/nz;

% Identity Matrices
Ix = speye(nx-1);
Iy = speye(ny-1);
Iz = speye(nz-1);

% T Matrices
Tx = -gallery('tridiag', nx-1) / hx^2;
Ty = -gallery('tridiag', ny-1) / hy^2;
Ty = -gallery('tridiag', ny-1) / hz^2;

% Coefficent Matrix
A3D = kron(Iz, kron(Iy, Tx)) + kron(Iz, kron(Ty, Ix)) + kron(Tz, kron(Iy, Ix));

% Form rhs
F = ones((nx-1)*(ny-1)*(nz-1),1);

% Solve
x = A3D\F;
xr = reshape(x, nx-1,ny-1,nz-1);

for i = 1:nz-1
    mesh(xr(:,:,i));
    M = getframe;
    pause(0.2);
end