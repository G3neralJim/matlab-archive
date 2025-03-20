clc;
clear;

%This is a comment

%Tolerance
tol = 1e-5;

% Max iterations
Nmax = 5000;

%Initialize a Non-Linear System
F = @(x) [x(1)^2 + x(1)*x(2) - 10;...
    x(2) + 3*x(1)*x(2)^2 - 57];

%Initial Guess
x0 = [0.5; 0.5];

%Set G
J = @(x) [2*x(1)+x(2) x(1);...
    3*x(2)^2 1+6*x(1)*x(2)];



%Iterate

for i = 1:Nmax

    dx = J(x0)\(-F(x0)); 
    x = x0 + dx;

    if norm(x-x0) < tol && norm(F(x)) < tol
        disp(['Converged at: ' num2str(i) ' iterations: '])
        break
    end

    x0 = x;
end

