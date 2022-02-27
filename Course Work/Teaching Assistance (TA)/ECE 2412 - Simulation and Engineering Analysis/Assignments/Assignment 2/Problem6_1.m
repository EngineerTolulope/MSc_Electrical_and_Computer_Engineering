
clear;clc;close all;
 
x_old=0.5; % initial guess
E_s = 0.01; % The tolerance
E_a = 1 + E_s; % initial value of the approximated error must be greater than E_s
count=0; %count will be used to count the number of iterations (optional)
 
% Modified the function f(x) ------> x = f(x)+ x ----> x = sin (sqrt(x))
 
 
while(E_a>E_s)
    
    x_new = sin ( sqrt(x_old)); % estimate the new root
    
    E_a = abs((x_new - x_old) / x_new) *100; %calculating the approximated error
    x_old=x_new; % updating x_old
    count=count+1;
end
 
 
fprintf(' The estimated root is %0.8f with relative approximated error of %0.8f%% using the fixed point method (%0.0f iterations)\n',x_new,E_a,count) 


