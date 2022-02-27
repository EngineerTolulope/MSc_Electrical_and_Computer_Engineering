%% Problem 14.4
clear;clc;close all
x=[2 4 6 7 10 11 14 17 20];
y=[4 5 6 5 8 8 6 9 12];

% To drive the formula for the model ym = a1 xi 
%------------------------------------------
% (1) Formulate the equation for the least-squares Regression
%
%  Sr = sum ( yi - ym) ^ 2
%     = sum ( yi - a1*xi) ^ 2
%
%
% (2) Take the partial derivative of Sr with respect to a1
%
% dSr/da1 =  2 sum ( yi - a1*xi) (- xi)
%         = -2 sum ( yi*xi - a1*xi^2) 
%
%  (3) Solve for dSr/da1 = 0 
%               
%           -2 sum ( yi*xi - a1*xi^2) = 0
%           a1 = sum (yi*xi) / sum (xi^2)

xy=x.*y;
a1=sum(xy)/(sum(x.^2));
fprintf('The slope for a straight line least-squares fit is: %0.4f \n',a1)

x_h=[0:0.1:20];
y_h = a1.*x_h;

plot(x,y,'o')
hold on
plot(x_h,y_h)
legend('Raw Data','Fitted Line')


%% Problem 14.11

% Solution A
clear;clc;close all
m=[400 70 45 2 0.3 0.16];
mett=[270 82 50 4.8 1.45 0.79];
plot(m,mett,'*')

% From the Raw data, It can be seen that a quadratic fit is appropriate
%    y m = a0 + a1 x + a2 x^2
% We can solve for a0, a1 and a2 to fit a quadratic function 
% OR
% we can use the Basic Fitting under Tools. 
%
%         a0 = 0.99
%
%         a1 = 1.2
%
%         a2 = -0.0014
% 
% To find the metabolism rate of a 200-kg tiger

x = 200;
a0 = 0.99;
a1 = 1.2;
a2 = -0.0014;
y = a0 + a1 *x + a2* x^2;
fprintf('The metabolism rate of a 200-kg tiger is: %0.4f \n',y)


% Solution B (another way) Note that the algorthim for polyfit might be
% different from the Basic Fitting therefore the result might be slightly
% different. 
clear;clc;close all
m=[400 70 45 2 0.3 0.16];
mett=[270 82 50 4.8 1.45 0.79];
plot(m,mett,'*')
a=polyfit(m,mett,2);  % Second order fitting
x=200;
y = a(3) + a(2) *x + a(1)* x^2;
fprintf('The metabolism rate of a 200-kg tiger is: %0.4f \n',y)

%% 14.14

clear;clc;close all;
c = [ 0.5 0.8 1.5 2.5 4];
k =[ 1.1 2.5 5.3 7.6 8.9];


% To linearize the follwoing equation
%
%                  k_max c^2             
%           k = -------------------
%                   c_s + c^2
%
%           1        c_s + c^2        c_s    1        1
%          --- = ---------------- = ------- ---- + -------
%           k        k_max c^2       k_max  c^2     k_max
%
%
% Then, we can plot y = (1/k) v.s x=(1/c^2) to get linear relationship
%
%
%
%
x=1./(c.^2);
y=1./k;
plot(x,y,'*')


%      Then we can fit ym = a0 + a1 x
%  
%       where a0 = 1/k_max and a1 = c_s / k_max 
%
xy=x.*y;
n=size(y,2);
a1 = (n * sum (xy) - sum(x)*sum(y))/ (n*sum(x.^2) - (sum(x))^2);
a0 =  (sum(y) - a1* sum(x))/n;

x = 0:0.01:4;
ym=a0+a1.*x;
hold on 
plot(x,ym,'--')
legend('Data','Fitted Line')

k_max = 1/a0;
c_s = a1*k_max;
fprintf('The estimate of C_s = %0.4f and k_max = %0.4f \n',c_s, k_max)

% To double check, we will draw the original data and the nonlinear model

c_model = 0:0.01:4;
k_model = (k_max*c_model.^2)./(c_s + c_model.^2);
figure
plot(c,k,'*')
hold on
plot(c_model,k_model,'--r')
legend('Data','Nonlinear Model')

% To predice the growth rate at c = 2 mg/L 
c_model=2;
k = (k_max*c_model.^2)./(c_s + c_model.^2);
fprintf('\nThe growth rate at c = 2 mg/L is = %0.4f \n',k)

%% 15.13
clear;clc;close all;
x = [0.1 0.2 0.4 0.6 0.9 1.3 1.5 1.7 1.8];
y = [0.75 1.25 1.45 1.25 0.85 0.55 0.35 0.28 0.18];
plot(x,y,'*')

% To fit nonlinear model, a function that must be created to compute 
% the sum of the squares
%
% function f = fSSR(a,xm,ym)
% yp = a(1).*xm.*exp((a(2).*xm));
% f = sum((ym-yp).^2);
% end
%
% Then this function cvan be used to find the minimum as follow

% M = fminsearch(@fSSR, [1, 1], [], x, y);
% f = @(a,xm,ym) sum((ym-(a(1).*xm.*exp((a(2).*xm)))).^2);
 f = @(a) sum((y-(a(1).*x.*exp((a(2).*x)))).^2);
a_initial_guess = [1 1];
M = fminsearch(f,a_initial_guess);
a4=M(1);
b4=M(2);

% To double check, we will draw the original data and the nonlinear model
x_model = 0:0.01:2;
y_model = a4*x_model.*exp((b4*x_model));
hold on
plot(x_model,y_model,'--r')
legend('Data','Nonlinear Model')

%% 16.1
clear;clc;close all
t=[0 2 4 5 7 9 12 15 20 22 24];
ph=[7.6 7.2 7 6.5 7.5 7.2 8.9 9.1 8.9 7.9 7];
plot(t,ph,'*')
Period = 24;
w0 = (2*pi)/Period;

n=size(ph,2);

% Since the interval between the points are not equially spaced, we have 
% to solve the 3x3 system as following
A = [ n sum(cos(w0.*t)) sum(sin(w0.*t)); sum(cos(w0.*t)) sum(cos(w0.*t).^2) sum(cos(w0.*t).*sin(w0.*t)); sum(sin(w0.*t)) sum(cos(w0.*t).*sin(w0.*t)) sum(sin(w0.*t).^2)];
b = [sum(ph); sum( ph.*cos(w0.*t)); sum( ph.*sin(w0.*t))];
x = A\b;
A0=x(1);
A1=x(2);
A2=x(3);

t_model=0:1:30;
ph_model=A0+A1.*cos(w0.*t_model)+ A2.*sin(w0.*t_model);
hold on
plot(t_model,ph_model,'--r')
legend('Data','Nonlinear Model')

%% 17.1

clear;clc;close all
x=[0 1.8 5 6 8.2 9.2 12];
y=[26 16.514 5.375 3.5 2.015 2.54 8];
plot(x,y,'*')
% Since the measured has high precision, we should use interpolation
% N = 7 observations, therefore, we should fit a 6th order polynimial
% Using the  Tools > Basic Fitting. we can get:
a1=26;
a2=-5.8;
a3=0.22;
a4=0.042;
a5=-0.0054;
a6=0.00034;
a7=-8.5e-6;

% To determine y at x = 3.5
x=3.5;
y=a1 + a2*x + a3*x^2 + a4*x^3 + a5*x^4 + a6*x^5 + a7*x^6;
fprintf('\nThe value of y at x = 3.5 is = %0.4f \n',y)


