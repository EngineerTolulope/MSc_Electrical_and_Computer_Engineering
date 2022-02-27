
clear;clc;close all
 
% values of the constants
e0=8.9e-12;
Q=2e-5;
q=2e-5;
F=1.25;
a=0.85;
 
% f_x = (1/(4*pi*e0)*((q*Q*x)/((x^2+a^2)^3/2))-F
 
% Graphical method
x=0:0.01:4

% calculate f_x as a vector of values to be plotted
f_x = (1/(4*pi*e0)).*((q.*Q.*x)./((x.^2+a.^2).^(3/2)))-F;
plot(x,f_x)
grid on
 
% You can use any method to solve for the root, I will use the MATLAB
% function fzero()

% defined the function to be used in the fzero function
fx = @(x) (1/(4*pi*e0))*((q*Q*x)./((x^2+a^2)^3/2))-F;
 
% solve for the root xr and its value fval using initial guess of xi
% NOTE that the initial values of xi were determined from the graph
xi=0;
[xr1,fval1]=fzero(fx,xi);
 
xi=1;
[xr2,fval2]=fzero(fx,xi);
 
fprintf('The distance where the force is 1.25N = %0.8f m and %0.8f m \n',xr1,xr2) 
