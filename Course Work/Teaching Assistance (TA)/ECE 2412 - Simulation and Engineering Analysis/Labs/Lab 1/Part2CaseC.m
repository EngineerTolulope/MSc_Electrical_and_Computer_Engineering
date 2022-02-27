% Description: part2 C

clear
clc
clf
%close all
f = 198*(10^12);%THz
T=1/f;
p1=T/10;
pf=2*T;
w = f*2*pi; %converting frequency to angular v and accounting for Tera 
s = 2*10^8; %speed of propagation
b = w/s; %phase shift coefficient
Eo = 1.0; %Initial condition (V/m)
z= 0:(0.01*10^-6):(10*10^-6); %position (10^-6m)

for(t=0:p1:pf)

E = Eo*exp(j*((w*t)+(b*z)));


plot(z,real(E),'m');
pause(0.5)

end

xlabel('Position along length of fiber (10^-6 m)');
ylabel('E (V/m)');
title('Electrical Field Intensity');
grid;
grid minor; 

