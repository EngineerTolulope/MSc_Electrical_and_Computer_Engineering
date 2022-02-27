%Question 6.1
clear
clc

% fx = sin(sqrt(x))-x
% 0 = sin(sqrt(x))-x
% x = sin(sqrt(x))  <-- what we want
% x = g(x)

%inital conditions 
x0 = 0.5;

%compute fixed point iteration
x = x0;
x_old = x0;
for i = 1:100
    
    x = sin(sqrt(x));
    
    %relative error
    Ea = abs((x - x_old)/x)*100;
    
    x_old = x;
    
    if Ea < 0.01
        break
    end
end

fprintf("The fixed point iteration is: %d\n", x)
fprintf("The relative error is: %d\n", Ea)