function x = cgf1(A,b,tol,Nmax)

    % Get size of matrix
    n = length(A);

    % Initial Guess
    x = zeros(n,1);

    % Compute Initial Residual
    r = b - A*x;
    p = r;

    % Initial Norm
    norm0 = norm(r);

    % Iterate
    for i = 1:Nmax

        %% Prepare products once
        % 2-norm squared
        r2 = r'*r;

        % Compute matrix - vector product
        Ap = A*p;

        % Compute aplha
        a = r2/(p'*Ap);

        % Update solution and Residual
        x = x + a*p;
        r = r - a*Ap; % new r computed through A*p to avoid computing Ax(i+1)

        normr = norm(r);

        if normr < tol*norm0
            disp(['Iterations: ' num2str(i)]);
            break;
        end
        
        %% Not entirely sure why b simplifies to that, but I'll take it as is, for now :/
        % Projection coefficient
        b = (r'*r / r2);

        % New direction
        p = r + b*p;

    end
    disp(['end'])
end
