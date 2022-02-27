function [root,iteration,Ea] = bisection( xl,xu,es,maxit,Zo,Zl)
% The bisection method with mimimum bound, maximum bound, estimation value,
% and maximum number of iteration in that order

iteration = 1; 

    while(1)
        if (iteration > maxit),break,end;
        xm = (xl+xu)/2; % initial root
        Z_xl = imag(find_root( Zo,Zl,xl));
        Z_xm = imag(find_root( Zo,Zl,xm));
        if (Z_xl*Z_xm)<0
            xu = xm; %the root in the lower bound
        else
            xl = xm; %the root in the upper bound
        end
        root = (xl+xu)/2; % revised root
        Ea = abs((root - xm)/root);
        if (Ea < es),break,end;
        iteration = iteration + 1;
    end

end

