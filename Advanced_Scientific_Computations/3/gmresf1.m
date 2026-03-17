function x = gmresf1(A,b,m,tol,Nmax)

    % Get size of matrix
    n = length(A);

    % Initial Guess
    x = zeros(n,1);

    % Initial Norm
    normb = norm(b);

    % Iterate
    for i = 1:Nmax

        % Compute residual
        r = b - A*x;

        normr = norm(r);

        if normr < tol*normb
            disp(['Iterations: ' num2str(i)]);
            disp(['Residual: ' num2str(norm(r)/normb)]);
            break;
        end


        % Build space with Arnoldi
        [V,H] = arnoldi(A,r,m);

        % Compute projected residual
        rp = V'*r;

        % Compute projected error
        y = H\rp;

        % Add correction
        x = x + V(:,1:end-1)*y;
    end
end