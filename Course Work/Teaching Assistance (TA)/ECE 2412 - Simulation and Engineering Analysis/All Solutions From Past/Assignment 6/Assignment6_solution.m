%Problem 22.1A

clear;clc;close all;
y0=8;
t_end=5;
dy_dt = @(t,y) 2-0.5*y;

% (a) Using the analytical solution.
t=0:0.001:t_end;
y = 4 + (y0-4).*exp(-0.5.*t);
plot(t,y)

% (b) Euler's method with step size equals to h=0.5

h=0.5;
n=1;
Y1(n)=y0;
for t=h:h:t_end
%     slope = Y1(n)*(t.^3) - 1.5.*Y1(n); %estimate the slope using Euler's method
    slope = dy_dt(t,Y1(n)); %estimate the slope using Euler's method

    Y1(n+1) = Y1(n) + slope*h;
    n=n+1;  
end

t=0:h:t_end; %create the time vector
hold on
plot(t,Y1,'*--')

% (b) Euler's method with step size equals to h=0.25

h=0.25;
n=1;
Y2(n)=y0;
for t=h:h:t_end
%     slope = Y2(n)*(t.^3) - 1.5.*Y2(n); %estimate the slope using Euler's method
    slope = dy_dt(t,Y2(n)); 
    Y2(n+1) = Y2(n) + slope*h;
    n=n+1;  
end
t=0:h:t_end; %create the time vector
hold on
plot(t,Y2,'s--')
% (c) midpoint method with step size equals to h=0.5
h=0.5;
n=1;
Y3(n)=y0;
for t=h:h:t_end
    
    % Prediction 
%     slope_initialpoint = Y3(n)*(t.^3) - 1.5.*Y3(n); %estimate the slope using Euler's method
    slope_initialpoint = dy_dt(t,Y3(n)) ;
    Y_midpoint = Y3(n) + slope_initialpoint*(h/2);
    t_midpoint = t + (h/2);
    % Correction
    slope_midpoint = dy_dt( t_midpoint , Y_midpoint) ;
    Y3(n+1) = Y3(n) + slope_midpoint*h;
    n=n+1;  
end

t=0:h:t_end; %create the time vector
hold on
plot(t,Y3,'o--')

% (d) fourth order RK method with step size equals to h=0.5

h=0.5;
n=1;
Y4(n)=y0;
for t=h:h:t_end
    
     
    k1 = dy_dt(t, Y4(n)); 
    y_k2 = Y4(n) + k1 * (h/2);
    
    t_midpoint = t + (h/2);
    k2 = dy_dt(t_midpoint,y_k2); 
    y_k3 = Y4(n) + k2 * (h/2);
    
    k3 = dy_dt(t_midpoint,y_k3); 
    y_k4 = Y4(n) + k3 * (h);
    
    k4 = dy_dt ( t+h , y_k4);
    
 
   Y4(n+1) = Y4(n) + (k1+2*k2+2*k3+k4)/6*h;
   n=n+1;  
end

t=0:h:t_end; %create the time vector
hold on
plot(t,Y4,'^--k')

legend('Analytical', 'Euler?s 0.5', 'Euler?s 0.25', 'Midpoint', 'RK')


%% Problem 23.15A
clear;clc;close all;

% part a

% Initial values
theta = 0;
omega = 0.25;

L=0.5; % length of pendulum
g = 9.81; %m/s^2

dt = 0.01;
time_start = 0;
time_end = 2;

n=1;

for t=time_start:dt:time_end
    
    % Finding the slope using Euler's Method
    dtheta_dt=omega(n);
    domega_dt = g./L .* sin(theta(n));
    
    % Finding the new point
    theta(n+1) = theta(n) + dtheta_dt*dt;
    omega(n+1) = omega(n) + domega_dt*dt;
    

     
    n=n+1;
    
end

t=time_start:dt:time_end;
subplot(211)
plot(t,theta(1:end-1),'--*')
title('Angle vs time')
xlabel('time')
ylabel('\theta (rad)')
grid on
subplot(212)
plot(t,omega(1:end-1),'--*')
title('Anglar Speed vs time')
xlabel('time')
ylabel('\omega (rad/sec)')
grid on



%% part b
clear;clc;close all;
% Initial values
theta = 0;
omega = 0.25;

L=0.5; % length of pendulum
g = 9.81; %m/s^2

dt = 0.01;
time_start = 0;
time_end = 2;

n=1;

for t=time_start:dt:time_end
    
    % Finding the slope using Euler's Method
    dtheta_dt=omega(n);
    domega_dt = g./L .* sin(theta(n));
    
    % Finding the new point
    theta(n+1) = theta(n) + dtheta_dt*dt;
    omega(n+1) = omega(n) + domega_dt*dt;
    
    % The physical constrain
     if(abs(theta(n+1)) >= pi/2)
        theta(n+1)=pi/2;
        omega(n+1)=0;
     end
     
    n=n+1;
    
end

t=time_start:dt:time_end;
subplot(211)
plot(t,theta(1:end-1),'--*')
title('Angle vs time')
xlabel('time')
ylabel('\theta (rad)')
grid on
subplot(212)
plot(t,omega(1:end-1),'--*')
title('Anglar Speed vs time')
xlabel('time')
ylabel('\omega (rad/sec)')
grid on


%% part c

clear;clc;close all

% Initial drawing coordinates
z = 0;
y = 0;

theta = 0;
omega = 0.25;

L=0.5; % length of pendulum
g = 9.81; %m/s^2

dt = 0.01;
time_start = 0;
time_end = 1;

n=1;

for t=time_start:dt:time_end
    
    % Finding the slope using Euler's Method
    dtheta_dt=omega(n);
    domega_dt = g./L .* sin(theta(n));
    
    % Finding the new point
    theta(n+1) = theta(n) + dtheta_dt*dt;
    omega(n+1) = omega(n) + domega_dt*dt;
    
    % The physical constrain
     if(abs(theta(n+1)) >= pi/2)
        theta(n+1)=pi/2;
        omega(n+1)=0;
     end
     
    n=n+1;
    
line1 = [z 10*(z+L*sin(theta(n)))];
line2 = [y y+L*cos(theta(n))];
plot(line1,line2,'black','LineWidth',5)
hold on;
plot([-10 10],[0 0],'black')
plot(z,y,'*r')
xlabel('x position (m)');
ylabel('y position (m)');
title ('Free body movement of the inverted pendulum and cart');
axis([-10 10 -0.5 1])
pause(0.01);
hold off
    
end


