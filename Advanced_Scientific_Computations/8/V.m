function x = V(A,D,x,b,P,R,nu1,nu2,w,l)

    if (l==1)
        x{1} = b{1}/A{1};
    else
        x{l} = dampjac(A{l},D{l},x{l},b{l},w,nu1);
        b{l-1} = R{l-1}*(b{l}-A{l}*x{l});
        x{l-1}(:) = 0;
        x = V(A,D,x,b,P,R,nu1,nu2,w,l-1);
        x{l} = x{l} + P{l-1} * x{l-1};
        x{l} = dampjac(A{l},D{l},x{l},b{l},w,nu2);
    end
end