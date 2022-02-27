%Ece2412 lab 1

clear
clc
clf
close all

%values for our low pass filter%
r = 50; %ohms%

c = ((1:6).*(10^-9))';
freq = (0:0.1:10); %100 increments for accuracy
w = freq*2*(pi)*(10^6);
res = 1./(1+(1j*(w.*r.*c)));
res2 = repelem(0.5,101);

plot(freq,real(res),freq,res2,'-.')


xlabel('Frequency((10^6)Hz)');
ylabel('Gain [v0/vi] (V)');
title('The Gain of a Low Pass Filter');
%grid minor; % Optional
grid;