function x = cgf1(A,b,tol,Nmax)

    % Get size of matrix
    n = length(A);

    % Initial Guess
    x = zeros(n,1);

    % Compute Initial Residual
    r = b - A*x;
    p = r;

    % Initial Norm
    normb = norm(r);

    % Iterate
    for i = 1:Nmax
        % 2-norm squared
        r2 = r'*r;

        % Compute matrix - vector product
        t = A*p;

        % Compute aplha
        a = r2/(p'*t);

        % Update solution and Residual
        x = x + a*p;
        r = r - a*t;

        normr = norm(r);

        if normr < tol*normb
            disp(['Iterations: ' num2str(i)]);
            break;
        end

        % Projection coefficient
        b = (r'*r / r2);

        % New direction
        p = r + b*p;

    end
    disp(['end'])
end
