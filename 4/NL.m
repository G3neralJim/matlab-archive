clc;
clear;

tol = 1e-5;

Nmax = 1000;


F = @(x) [x(1)^2+x(1)*x(2)-10;...
    x(2)+3*x(1)*(x(2)^2)-57];

x0 = [0.5, 0.5];


G = @(x) [(10-x(1)*x(2))/x(1);...
    (57-x(2))/(3*x(1)*x(2))];

for i = 1:Nmax
    x=G(x0);

    if norm(x-x0) < tol && norm(F(x)) < tol
        disp(['Converged at: ' num2str(i) 'iterations: '])
        break
    end

    x0 = x;

end