clc;
clear;

% Constants
m = 20;
h = 1/m;

I = speye(m-1);

e = ones(m-1,1);

% Tanistes
T = spdiags([4*e -10*e 4*e], [-1 0 1], m-1, m-1);
T2 = spdiags([1*e 1*e], [-1 1], m-1, m-1);

% AUX A
A2D = (kron(I,T) + kron(T,I) + kron(T2,T2))/(6*h^2);

% f
f = @(x,y) (-2)*pi*(sin(x.*pi).*sin(y.*pi));
x = h:h:1-h;
y = h:h:1-h;

% Grid
[xx yy] = ndgrid(x,y);
F = f(xx(:), yy(:));

D = -gallery('poisson', m-1);

u = A2D\(F + ((1/12)*D*F));

mesh(reshape(u,m-1,m-1));



