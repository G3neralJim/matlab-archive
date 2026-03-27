function [L, U] = ilu0f(A)
    n = length(A);
    for i = 2:n
        for k = find(A(i,1:i-1)) %k = 1:i-1
            %if A(i,k) ~= 0
                A(i,k) = A(i,k)/A(i,i);
            %end
            for j = find(A(i,k+1:n))+k %j = k+1:n
                %if A(i,j)~= 0
                    A(i,j) = A(i,j) - A(i,k)*A(k,j);
                %end
            end
        end
    end
end
