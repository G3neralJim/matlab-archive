function x = dampjac(A,D,x,b,w,nu)
    
    for i = 1:nu
        x = x + w*(b-A*x)./D;
    end
end