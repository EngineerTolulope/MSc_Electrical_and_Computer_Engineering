% Description: part2b

clear
clc
clf
%close all
f = 198*(10^12);%THz
T=1/f;      %Period
p1=T/10;    %Step Size (1/10th of Period)
pf=2*T;     %End at 2 Periods
w = f*2*pi; %Converting frequency to angular v and accounting for Tera 
s = 2*10^8; %Speed of propergation
b = w/s;    %Phase shift coefficient
Eo = 1.0; %Initial condition (V/m)
z= 0:(0.01*10^-6):(10*10^-6); %position (10^-6m)

for(t=0:p1:pf)

E1 = Eo*exp(j*((w*t)+(b*z)));
E2 = Eo*exp(j*((w*t)-(b*z)));
Et=abs(real(E1)+real(E2));


subplot(3,1,1)
plot(z,real(E1));
% hold on
xlabel('Position along length of fiber (10^-6 m)');
ylabel('E (V/m)');
title('Forward Electrical Field Intensity');
grid;

subplot(3,1,2)
plot(z,real(E2));
% hold on
xlabel('Position along length of fiber (10^-6 m)');
ylabel('E (V/m)');
title('Reverse Electrical Field Intensity');
grid;

subplot(3,1,3)
plot(z,real(Et));
% hold on
xlabel('Position along length of fiber (10^-6 m)');
ylabel('E (V/m)');
title('Total Electrical Field Intensity');
grid;

pause(0.5)
end

