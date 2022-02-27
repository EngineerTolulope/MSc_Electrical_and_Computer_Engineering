% ECE 2412 - Assignment 1 solution
%% Question 1
clc;close all;clear;

z=-5:0.01:5;
xlabel('z','FontSize',35);
ylabel('Frequency','FontSize',35);
f=1/(sqrt(2*pi))*exp(-(z.^2)/2);
plot(z,f,'LineWidth',3)
ylabel('Frequency')
xlabel('z')
 
%% Question 2
clc;close all;clear;

%Ploting the Data
t=10:10:60;
c_points=[3.4 2.6 1.6 1.3 1.0 0.5];
plot(t,c_points,'dr','LineWidth',3,'MarkerFaceColor', 'r')
xlabel('Time (min)','FontSize',25);
ylabel('concentration (ppm)','FontSize',25);

hold on

%Ploting the function c(t)
t=0:0.1:70;
c_function = 4.48*exp(-0.034.*t);
plot(t,c_function,'--g','LineWidth',3)
legend('Data','Function')


%% Question 3
clc;close all;clear;

x=linspace(0,3*pi/4,500);
f_exact = cos(x);
plot(x,f_exact,'LineWidth',3)
xlabel('x (rad)','FontSize',25);
ylabel('f(x)','FontSize',25);
hold on
grid on

f_approximation = 1 - (x.^2)/factorial(2) + (x.^4)/factorial(4) - (x.^6)/factorial(6) + (x.^8)/factorial(8);
plot(x,f_approximation,'--k','LineWidth',3)
legend('Exact','Approximation')


%% Question 4
clc;close all;clear;


x=0.7;
j = 2; % j will be used to alternate the sign
f=0; % Initial value of f with no terms
True_value = sin(x);
for i=1:2:15  % start i=1 and increament by 2 (1,3,5,...)
    
    f=f+((-1)^j)*x^i / factorial(i);   % adding new term each loop
    error = ((True_value - f) / True_value)*100 ;
    fprintf('Sin (%0.1f) = %0.16f with percent relative error= %0.16f%% \n \n',x,f,error)
    
    j=j+1; % To alternate the sign;
    
end

%% Question 5
% function grade=letter2grade(score)
%  
%     if (score>=90 && score <=100)
%         grade= 'A';
%     elseif (score>=80 && score <90)
%         grade= 'B';
%    elseif (score>=70 && score <80)
%         grade= 'C';
%    elseif (score>=60 && score <70)
%         grade= 'D';
%    elseif (score>=0 && score <60)
%         grade= 'F';
%     else
%         error('Error. Input must be a numeric value between 0 to 100')
%     end
% end


%% Question 6

% function v=rocket_velocity(t)
% 
%         if (t>=0 && t<8)
%             v=(10*(t^2))-(5*t);
%         elseif(t>=8 && t<16)
%             v=624-3*t;
%         elseif(t>=16 && t<26)
%             v=36*t+12*(t-16)^2;
%         elseif(t>=26)
%             v=2136*exp(-0.1*(t-26));
%         else
%             v=0;
%         end
% end

i=1;
for t=-5:0.1:50;
        v(i)=rocket_velocity(t);
        i=i+1;
end
t=-5:0.1:50;
plot(t,v,'LineWidth',3)
xlabel('Time (sec)','FontSize',25);
ylabel('Velocity (m/s)','FontSize',25);
hold on
grid on

%% Question 7
clear;clc;close all;

e = 1;
while (true)
        if(1+e >1)
            e=e/2;
        else
            e=2*e;
            break;
        end
end

fprintf(' The smallest number according to the algorithm = %e \n',e) 
fprintf(' The smallest number according to the built-in function = %e \n',eps)
    

%% Question 8

clear;clc;close all;


n=2; % Two significant figures
e_s = 0.5*10^(2-n);  % Calculating the tolarance based on the value of n
e_a=100;    % setting the approximate percent relative errors to 100%
e_x=1;          % The simplest version
i=1;    %Index that will be used for the power of x in the calculation
x=0.25;
while(e_a > e_s)
    
    e_x_pre = e_x;      % Storing the previous approximation
    e_x = e_x + (x^i)/factorial(i); % Calculating the present approximation
    e_a = ((e_x - e_x_pre) / e_x)*100;
        
    i=i+1;      % Incrementing the Index
end

fprintf(' The estimated value of e^%0.2f is %0.8f \n',x,e_x) 
fprintf(' with approximate percent relative errors of %0.4f %% \n',e_a) 
fprintf(' The true value of e^%0.2f is %0.8f \n',x,exp(0.25)) 



