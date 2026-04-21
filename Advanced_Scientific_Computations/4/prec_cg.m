function x = prec_cg(A,b,tol,Nmax, L, U)

    % Get size of matrix
    n = length(A);

    % Initial Guess
    x = zeros(n,1);

    % Compute Initial Residual
    r = b - A*x;
    z = U\(L\r);
    p = z;


    % Initial Norm
    normb = norm(r);

    % Iterate
    for i = 1:Nmax
        
        % 2-norm squared
        r2 = r'*z;

        % Compute matrix - vector product
        t = A*p;

        % Compute aplha
        a = r2/(p'*t);

        % Update solution and Residual
        x = x + a*p;
        r = r - a*t;

        %
        z = U\(L\r);

        normr = norm(r);

        if normr < tol*normb
            disp(['Iterations: ' num2str(i)]);
            break;
        end

        % Projection coefficient
        b = (r'*z / r2);

        % New direction
        p = z + b*p;

    end
    disp(['end'])
end
