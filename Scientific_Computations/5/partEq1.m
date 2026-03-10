clc;
clear;

% Intervals per dimension
m = 40;
n = (m-1)^2;

% Domain per dimension
L = [-1 1];

% Mesh Size
h = (L(2)-L(1))/m;

% Rhs functions and Constants
G = 1;
sigma = 0.1;
f = @(x,y) 4*1000*pi*G*(1/((sqrt(pi))*sigma)*exp(-(x.^2+y.^2)/(sigma^2)));

% Coordinates
x = linspace(L(1)+h, L(2)-h,m-1);
y = linspace(L(1)+h, L(2)-h,m-1);

[xx, yy] = ndgrid(x,y);
xx = reshape(xx,n,1);
yy = reshape(yy,n,1);

% Coefficient Matrix

A = zeros(n,n);

for i = 1:n
    A(i,i) = -4;
end
for i = 1:n-1
    A(i,i+1) = 1;
end 
for i = 1:n-1
    A(i+1,i) = 1;
end
for i = 1:m-2;
    A(i*(m-1),i*(m-1)+1) = 0;
    A(i*(m-1)+1,i*(m-1)) = 0;
end

% Further Diagonals
for i = 1:n-(m-1)
    A(i,m+i-1) = 1;
    A(m+i-1,i) = 1;
end

b = h^2 * f(xx, yy);

x = A\b;

% Plot Solution
mesh(reshape(xx,m-1,m-1),reshape(yy,m-1,m-1),reshape(x,m-1,m-1));


