%% Name : Tri Phan

%% Lab 2
clear;
clc;
close all;

%% Part A)
% Initial variables
Zo = 50;
Zl = 10;

% Loop variables
step_change = 0.0001;
step_end = 4*pi;

% Initilize real & imag vectors
Bl = 0:step_change:step_end;
[row,column] = size(Bl);
Zin_real = zeros(1,column);
Zin_imag = Zin_real;
count = 1;

% Loop
for x = 0:step_change:step_end
    % Real part
    Zin_real(count) = real(find_root( Zo,Zl,x));
    % Imag part
    Zin_imag(count) = imag(find_root( Zo,Zl,x));
    % Counter
    count = count + 1;
end

figure(1);
plot(Bl,Zin_real,'b',Bl,Zin_imag,'r');
grid on;
title('The graphical solution');
xlabel('Electrical Length (m)');
ylabel('Input Impedance (Ohm)');
legend('Real Impedance','Imaginary Impedance', 'Location', 'North');

%% Part b)
xl = 4;
xu = 5;
es = 0.0001;
maxit = 100;
[root,iteration,Ea] = bisection( xl,xu,es,maxit,Zo,Zl);

%% Part c)
imag_root = @(Zo,Zl,Bl1) imag(Zo *(Zl + 1j*Zo*tan(Bl1))/(Zo + 1j*Zl*tan(Bl1)));
result = fzero(@(Bl1) imag_root(Zo,Zl,Bl1),4.4);

%% Part 2 Finding maxima

% Case A
i = 1;
j = 1;
X = 0:0.0001:0.1;
Y = 0:0.0001:0.05;
a = 0.1; b = 0.05;

% Single case use
m = 2;n = 2;
for x = 0:0.0001:0.1  
    for y = 0:0.0001:0.05
        P (i,j) =((sin(m*pi*x/a)).^2.*(cos(n*pi*y/b)).^2)+((cos(m*pi*x/a)).^2.*(sin(n*pi*y/b)).^2);
        j = j+1;
    end
        j = 1; % reset j
        i = i + 1;
end
i = 1; % reset i
contour(Y,X,P);

% Loop with contour
for n = 0:1:5
    for m = 1:1:5
        for x = 0:0.0001:0.1  
           for y = 0:0.0001:0.05
               P (i,j) =((sin(m*pi*x/a)).^2.*(cos(n*pi*y/b)).^2)+((cos(m*pi*x/a)).^2.*(sin(n*pi*y/b)).^2);
               j = j+1;
           end
           j = 1; % reset j
           i = i + 1;
        end
        i = 1; % reset i
        contour(Y,X,P);
%          pause;
    end
end


% with m = 0, n = 1: vertical lines
% with m = 1, n = 0: horizontal lines
% with n increases, the band width becomes smaller in the horizontal scale
% with m increases, the band width becomes smaller in the vertical scale
% the rate of change


%% Case B 

% Use of temporary function
m = 2; n = 2;
a = 0.1; b = 0.05;
z = [0.02 0.02];
temp_func = @(x,a,b,m,n)  -(((sin(m*pi*x(1)/a)).^2.*(cos(n*pi*x(2)/b)).^2)+((cos(m*pi*x(1)/a)).^2.*(sin(n*pi*x(2)/b)).^2));

[xy, fmin]=fminsearch(@(x) temp_func(x,a,b,m,n),z);
fmax = - fmin;

% Use of existing function;
[xy, fmin]=fminsearch(@(x,y) WGpower(x,a,b,m,n),z);
fmax = - fmin;
disp(xy);
disp(fmax);
