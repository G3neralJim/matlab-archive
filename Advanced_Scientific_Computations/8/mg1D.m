clc;
clear;

% Parameters
d = 1; % dimension
nu1 = 2;
nu2 = 2;
w = (2*d)/(2*d+1);

Nmax = 50;
tol = 1e-10;

% Levels
levels = 10;

% Unkown
n = 2.^(1:levels)-1;

% Mesh sizes
h = 1./(n+1);

% Coefficient matricse
for i = 1:levels
    A{i} = -gallery('tridiag',n(i))/h(i)^2;
    D{i} = diag(A{i});
    x{i} = zeros(n(i),1);
    b{i} = zeros(n(i),1);
end

% Create RHS for finest level
b{levels}(:) = 1;

% Create prolongation and restriction operators
for i = 1:levels-1
    R{i} = spalloc(n(i),n(i+1),3*n(i));
    for j = 1:n(i)    
        temp = 2*j-1: 2*j+1;
        R{i}(j,temp) = [1/4 1/2 1/4];
    end
    P{i} = 2*R{i}';
end

%% Solution
normb = norm(b{levels});
for i = 1:Nmax
    x = V(A,D,x,b,P,R,nu1,nu2,w,levels);

    normr = norm(b{levels}-A{levels}*x{levels});
    if normr < normb*tol
        disp(['Converged at iteration: ' num2str(i)]);
        break;
    end
end
% plot(x{levels});
% grid on;

