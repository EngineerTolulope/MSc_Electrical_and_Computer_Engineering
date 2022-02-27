clear
clc
close all

% Set up the initial conditions
f=10e9:1e6:11e9; % Investigate frequencies between 10 GHz and 11 GHz
fb=10.5e9; % Set the Brillouin frequency at 10.5 GHz
delf=35e6; % The gain profile has a 35 MHz width
amp=1; % Set the initial amplitude to 1
bg=amp*(1+4*((f-fb)./delf).^2).^-1; % Calculate the Brillouin gain over the frequency range
guide=repelem(2,100);

for i = 1:100
stdev(i)=0.01*i;
for j=1:20
lnoise=randn(size(f));
measured=stdev(i)*lnoise+bg;
brillouin2=@(x) sum((measured-x(1)*(1+4*((f- x(2)*1e10)./(x(3)*1e7)).^2).^-1).^2);
[x,error,exitflag,output]=fminsearch(brillouin2,[1,1.05,3.5]);
y(j)=x(2); % Pass Only Temp Data 
err(j) = (abs(1.05-y(j))).*10000;
end
freq(i) = sum(err)/20;
end

plot(stdev,freq,stdev,guide, 'k--')
xlabel('Standard Deviation')
ylabel('Temperature Error')
ylim([0 5]);
title('Standard Deviation vs. Temperature Error')

