%% Lab 1 Part 2
clear;
clc;
close all;

%% Case A
% Independent Coefficient
f = 198*10^12;
s = 2*10^8;

% Dependent Coeffecient
w = 2*pi*f;
B = w/s;
Eo = 1;
t = 0;

z = 0:1*10^-9:10*10^-6;
E = real(Eo*exp(1i*(w*t-B*z)));

figure;
plot (z,E);
title('The plot of electric field intensity in the fiber at t=0s');
xlabel('The position (m)');
ylabel('The Electric Field (v/m)');

%% Case B
% Independent Coefficient
f = 198*10^12;
s = 2*10^8;

% Dependent Coeffecient
w = 2*pi*f;
B = w/s;
Eo = 1;
z = 0:1*10^-9:10*10^-6;

figure;
for t = 0:5*10^-15:10*10^-14
    E = real(Eo*exp(1i*(w*t-B*z)));
    pause (0.1);
    plot (z,E);
    title('The plot of electric field intensity in the fiber with varying time from 0s upto 100 ns');
    xlabel('The position (m)');
    ylabel('The Electric Field (v/m)');
end

%% Case C
% Independent Coefficient
f = 198*10^12;
s = 2*10^8;

% Dependent Coeffecient
w = 2*pi*f;
B = w/s;
Eo = 1;
z = 0:1*10^-9:10*10^-6;

figure;
for t = 0:5*10^-15:10*10^-14
    E_f = Eo*exp(1i*(w*t-B*z));
    E_b = Eo*exp(1i*(w*t+B*z));
    pause (0.1);
    subplot(3,1,1);
    plot (z,real(E_f));
    title('The forward wave');
    xlabel('The position (m)');
    ylabel('The Electric Field (v/m)');
    
    subplot(3,1,2);
    plot(z,real(E_b));
    title('The backward wave');
    xlabel('The position (m)');
    ylabel('The Electric Field (v/m)');
    
    subplot(3,1,3);
    plot(z,abs(real(E_f+E_b)));
    title('The interference pattern of two waves');
    xlabel('The position (m)');
    ylabel('The Electric Field (v/m)'); 
end














