clear;
clc;

% Number of Points
n = 11;

% Mesh Size
h = 1/(n-1);

% Parameters
Nmax = 500;
tol = (h^2)*0.1;
overlap = 1;

% Number of Points per domain
nd = (n-1)/2 + overlap;

% Coefficient Matrix
A = -gallery("tridiag",nd);

% RHS Function
f = @(x) - (pi^2)*sin(pi*x);

% Grid positions
x1 = (h:h:(((n-1)/2+overlap-1)*h))';
x2 = ((((n-1)/2-overlap+1)*h):h:1-h)';

% % Initial RHS
% b1 = h^2*f(x1);
% b2 = h^2*f(x2);

% % Initial Solutions
% u1 = A\b1;
% u2 = A\b2;


% for iter = 1:Nmax
%     plot(x1,u1);
%     hold;
%     plot(x2,u2);
%     hold off;

%     b1t = b1;
%     b2t = b2;

%     b1t(end) = b1t(end)-u2(2);
%     b2t(1) = b2t(1) - u1(end-1);

%     u1 = A\b1t;
%     u2 = A\b2t;
% end





