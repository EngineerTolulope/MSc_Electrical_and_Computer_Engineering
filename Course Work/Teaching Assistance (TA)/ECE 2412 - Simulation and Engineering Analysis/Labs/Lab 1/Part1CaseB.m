%Ece2412 lab 1

clear
clc
clf
close all
%values for our low pass filter%
r = 50; %ohms%
c = 1*(10^-9); %farads%
% freq = (0:0.1:10); %100 increments for accuracy

freq = linspace(0, 10, 101);
w = freq*2*(pi)*(10^6);
res = 1./(1+(1j*(w*r*c)));
res2 = repelem(0.5,101);

%freq = log(freq);
semilogx(freq,real(res),'r',freq,res2,'--')
xlabel('Frequency MHz');
ylabel('Gain [v0/vi] (V)');
title('The Gain of a Low Pass Filter');
%grid minor; % Optional
grid;