% lab 1 Part II, Case A
clear
clc
clf
%close all
f = 198*(10^12);%THz
w = f*2*pi; %converting frequency to angular v and accounting for Tera 
s = 2*10^8; %speed of propagation
b = w/s; %phase shift coefficient
Eo = 1.0; %Initial condition (V/m)
z= 0:0.01:10; %position (10^-6m)
t= 0;
E = Eo*exp(j*((w*t)-(b*(z*10^-6))));

plot(z,real(E),'r');

xlabel('Position along length of fiber (10^-6 m)');
ylabel('E (V/m)');
title('Electrical Field Intensity');
grid minor; 
grid;

