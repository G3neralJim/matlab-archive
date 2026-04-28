clear;
clc;

% Number of Points
n = 101;

% Mesh Size
h = 1/(n-1);

% Parameters
Nmax = 500;
tol = (h^2)*0.1;

overlap = 21; % must be odd
op_old = (overlap+1)/2; % initial development wasd done with this variable named as overlap
                        % but it doesn't accuretly express the overlap value leading to issues
                        % in generalization. The variable above correctly reflects real overlap
                        % and I am too lazy to adjust the code, for the time being  

% Number of Points per domain
nd = (n-1)/2 + op_old;

% Coefficient Matrix
A = -gallery("tridiag",nd-1);

% RHS Function
f = @(x) - (pi^2)*sin(pi*x);

% Grid positions
x1 = (h:h:(((n-1)/2+op_old-1)*h))';
x2 = ((((n-1)/2-op_old+1)*h):h:1-h)';

% Initial RHS
b1 = h^2*f(x1);
b2 = h^2*f(x2);

% Initial Solutions
u1 = A\b1;
u2 = A\b2;
uc = u2(op_old);

b1t = b1;
b2t = b2;

for iter = 1:Nmax
    plot(x1,u1);
    hold;
    plot(x2,u2);
    hold off;

    % [u1 u2]
    % aa = input('');

    b1t = b1;
    b2t = b2;

    ucp = u2(op_old);

    b1t(end) = b1t(end)-u2(overlap+1);
    u1 = A\b1t;
    b2t(1) = b2t(1)-u1(end-overlap);
    u2 = A\b2t;
    uc = u2(op_old);

    if norm(ucp-uc)<tol
        break;
    end

end

u = [u1(1:end-overlap); u2];
xx = h:h:((n-2)*h)';
u_ = @(x) sin(pi*x);
uu = u_(xx)'
error = abs(uu-u);
max(error)';




