% Assignment 5 solution
% 19.4

% Part (a) analytically

% The analytical soltion yeild to the following function
clc;close all;clear;
f_a = @(x) x-(x.^2)/2 - (x.^4) + (x.^6)./3; %defined the analytical solution
a=-2; % define the integral limits
b=4; 
I_a = f_a(b)-f_a(a);
fprintf('The results for part (a) = %0.2f \n',I_a );

% f = @(x)(1-x-4.*x.^3 +2.*x.^5);
% quad(f,-2,4)

% Part (b) Single application of trapezoidal rule
f = @(x) 1-x-4*x^3+2*x^5; %defined the function
a=-2; % define the integral limits
b=4; 
I_b = (b-a)*( f(a)+f(b))/2;
e_t = abs(I_a-I_b)/abs(I_a)*100;
fprintf('The results for part (b) = %0.2f with true %% error of %0.2f \n', I_b,e_t);

% Part (c) composite trapezoidal rule with n = 2 and b = 4;
a=-2; % define the integral limits
b=4; 
n=2; 
h = (b-a)/n; % step size
S = f(a)+f(b); % S is a variable to implement the sumation in a loop
x=a;    % starting point
for i=1:n-1     % loop to implement the sumattion of the composite trapezoidal rule
    x=x+h;  %calculate the next point based on the step size
    S=S+(2*f(x));   % add more terms to the sumation
end
I_c = (b-a)*(S/(2*n));
e_t = abs(I_a-I_c)/abs(I_a)*100;
fprintf('The results for part (c) with (n=2) = %0.2f with true %% error of %0.2f \n', I_c,e_t);

% repeat the aboce code with n=4
a=-2; % define the integral limits
b=4; 
n=4; 
h = (b-a)/n; % step size
S = f(a)+f(b); % S is a variable to implement the sumation in a loop
x=a;    % starting point
for i=1:n-1     % loop to implement the sumattion of the composite trapezoidal rule
    x=x+h;  %calculate the next point based on the step size
    S=S+(2*f(x));   % add more terms to the sumation
end
I_c = (b-a)*(S/(2*n));
e_t = abs(I_a-I_c)/abs(I_a)*100;
fprintf('The results for part (c) with (n=4) = %0.2f with true %% error of %0.2f \n', I_c,e_t);

% Part (d) single application of Simpson?s 1/3 rule
x0=-2; % define the integral limits
x2=4;
x1 = (x0+x2)/2; % calculate the midpoint
I_d = (x2-x0)*(f(x0)+4*f(x1)+f(x2))/6;
e_t = abs(I_a-I_d)/abs(I_a)*100;
fprintf('The results for part (d) = %0.2f with true %% error of %0.2f \n', I_d,e_t);

% Part (e) Simpson?s 3/8 rule
x0=-2; % define the integral limits
x4=4;
h=(x4-x0)/3; % calculate the step size
x1=x0+h;    %calculate the first midpoint
x2=x1+h;    %calculate the second midpoint
I_e = (x4-x0)*(f(x0)+3*f(x1)+3*f(x2)+f(x4))/8;
e_t = abs(I_a-I_e)/abs(I_a)*100;
fprintf('The results for part (e) = %0.2f with true %% error of %0.2f \n', I_e,e_t);

%% Problem 19.8
clear;clc;close all;

t=[1 2 3.25 4.5 6 7 8 8.5 9 10];
v=[5 6 5.5 7 8.5 8 6 7 7 5];

% Integrate using the trapezoidal rule, apply the trapezoidal rule to each
% 2 points as follow
I_a=0; % initial value of the integral
for i = 1:1:length(t)-1
I_a = I_a+( t(i+1)-t(i))*(v(i+1)+v(i))/2; %adding the terms to the integral 
end
fprintf('(a) The distance traveled using the trapezoidal rule = %0.2f m \n', I_a);
fprintf('    The the average velocity = %0.2f m/s \n', I_a/10);

% To fit a cubic equation using polynomial regression
P = polyfit(t,v,3); 
% create a cubic function based on the regression fitting
f_analytical = @(x) P(1).*x.^3 +  P(2).*x.^2 + P(3).*x.^1 + P(4);
% Integrating the function 
I_b = quad(f_analytical,1,10);
fprintf('(b) The distance traveled = %0.2f m \n', I_b);

%% Problem 20.4
clear;clc;close all;
t=[ 0 0.2 0.4 0.6 0.8 1 1.2];
i=[0.2 0.3683 0.3819 0.2282 0.0486 0.0082 0.1441];
C=10^-5; %capacitor value
subplot(2,1,1)
plot(t,i,'*')   % plot the given data
P=polyfit(t,i,5);   %fit a 5th order polynomial to the given data
% create a function based on the fitting model
f=@(x) P(1).*x.^5 + P(2).*x.^4 + P(3).*x.^3 +P(4).*x.^2+P(5).*x+P(6);
%create new time vectore to graph the fitting function
t=0:0.01:1.2;
hold on;plot(t,f(t))    %graph the fitting function
legend('Data','5^t^h order Fit')
ylabel('Current (mA)')

% calculation of the capacitor voltage
h=0.01; % step size of the time vectore  
v=0; %initial voltage at t=0;
i=1;  % create index i 
for t=h:h:1.2   % loop to calculate the points of the voltages
v(i+1)= v(i)+(1/C)*quad(f,t,t+h);   % integrate the current 
i=i+1;  % increament the index
end
%graph the voltage waveform
subplot(2,1,2)
t=0:h:1.2;
plot(t,v/1000)
ylabel('Voltage (V)')
xlabel('Time (s)')

%% Problem 21.13
clear;clc;close all;
t=0:2:16;
x=[0 0.7 1.8 3.4 5.1 6.3 7.3 8 8.4];
% Part (a) centered finite-difference with non correction
i=6; % The time t=10 is at index i=6;
h=2; % step size from the time vector
velocity_a = (x(i+1)-x(i-1))/(2*h);
acceleration_a = (x(i+1)-2*x(i)+x(i-1))/(h^2);

fprintf('(a) The velocity = %0.4f m/s and acceleration = %0.4f m/s^2 \n', velocity_a,acceleration_a);


% Part (b) centered finite-difference with second-order correct
i=6; % The time t=10 is at index i=6;
h=2; % step size from the time vector
velocity_a = (-x(i+2)+8*x(i+1)-8*x(i-1)+x(i-2))/(12*h);
acceleration_a = (-x(i+2)+16*x(i+1)-30*x(i)+16*x(i-1)-x(i-2))/(12*h^2);

fprintf('(b) The velocity = %0.4f m/s and acceleration = %0.4f m/s^2 \n', velocity_a,acceleration_a);

%% Problem 21.20
clear;clc;close all
% the given data
t=[ 0 1 5 8];
V=[0 1 8 16.4];
% graph the data
plot(t,V,'*')
% Fit a second order polynomial
P=polyfit(t,V,2);
% create a function f based on the above fitting
f=@(x) P(1).*x.^2 +P(2).*x + P(3);
% create a function of the derivative based on the above polynomial 
f_diff = @(x) 2*P(1).*x +P(2);
% create time vector to plot the fitting model
t1=0:0.1:8;
% graph the fitting 
hold on
plot(t1,f(t1))
legend('Data','2^n^d order Fit')
grid on
ylabel('Volume (cm^3)')
xlabel('Time (s)')

fprintf('The estimated flow rate (at t=7) is %0.4f cm^3/s \n', f_diff(7));

