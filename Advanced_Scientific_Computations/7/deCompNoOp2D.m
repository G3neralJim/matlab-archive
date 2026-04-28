clc;
clear;

% Points per dimension
nx = 101;

% Coefficient Matrix
K = -gallery('poisson',nx);
n = length(K);

% Rhs
b = K*ones(n,1);

% Map
num = reshape(1:n,nx,nx);

% Split
mid = (nx+1)/2;
boundaries = union(num(:,mid), num(mid,:));
sd1 = num(1:mid-1,1:mid-1); sd1 = sd1(:);
sd2 = num(mid+1:end,1:mid-1); sd2 = sd2(:);
sd3 = num(1:mid-1,mid+1:end); sd3 = sd3(:);
sd4 = num(mid+1:end,mid+1:end); sd4 = sd4(:);
inner = [sd1;sd2;sd3;sd4];

% Split Matrix A
A = K(inner,inner);
B = K(inner,boundaries);
Bt = K(boundaries,inner);
D = K(boundaries,boundaries);

% Split rhs
fi = b(inner);
fb = b(boundaries);

% Schur complement
[L U] = lu(A);
S = D-Bt*(U\(L\B));
% Form rhs of Schur complement
fs = fb - Bt*(U\(L\fi));

% Solve Schur complement
% xB = S\fs;
xB = gmres(@(x) D*x-Bt*(U\(L\(B*x))), fs, 20, 1e-10, 1e+3);
xI = U\(L\(fi-B*xB));