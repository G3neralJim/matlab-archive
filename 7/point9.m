clc;
clear;

% Constants
m = 5;
h = 1/m;

I = speye(m-1);

e = ones(m-1,1);
%
T = spdiags([4*e -10*e 4*e], [-1 0 1], m-1, m-1);
T2 = spdiags([1*e 1*e], [-1 1], m-1, m-1);

A2D = (kron(I,T) + kron(T,I) + kron(T2,T2))/(6*h^2);

f = @(x,y) (-2)*pi*(sin(x.*pi)*sin(y.*pi));
x = h:h:1-h;
y = h:h:1-h;


[xx, yy] = ndgrid(x,y);
f = f(xx(:), yy(:));

D = -gallery('poisson', m-1);

u = A2D\(f + ((1/12)*D*F));

mesh(reshape(u,m-1,m-1));



