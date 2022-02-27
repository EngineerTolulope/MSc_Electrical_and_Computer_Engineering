clear 
clc
close all

% Set up the initial conditions
f=10e9:1e6:11e9; % Investigate frequencies between 10 GHz and 11 GHz
fb=10.5e9; % Set the Brillouin frequency at 10.5 GHz
delf=35e6; % The gain profile has a 35 MHz width
amp=1; % Set the initial amplitude to 1
y=zeros(3,3);

% Add more noise (0.1)
disp('Noise @ 0.1')
for i=1:1:3
    bg=amp*(1+4*((f-fb)./delf).^2).^-1; % Calculate the Brillouin gain over the frequency range
lnoise=randn(size(f)); %Calculate the normally distributed noise
measured=0.1*lnoise+bg; % Add noise of standard deviation 0.1 to the gain profile
subplot(6,1,i)
plot(f,measured,'r',f,bg,'g'); % Plot the clean and the noisy data on the same graph
brillouin2=@(x) sum((measured-x(1)*(1+4*((f-x(2)*1e10)./(x(3)*1e7)).^2).^-1).^2);
[x,fval,exitflag,output]=fminsearch(brillouin2,[1,1.05,3.5]);
y(i,:)= x(1,:);
end
disp(y);

% Add more noise (0.2)
disp('Noise @ 0.2')
for i=4:1:6
    bg=amp*(1+4*((f-fb)./delf).^2).^-1; % Calculate the Brillouin gain over the frequency range
lnoise=randn(size(f)); %Calculate the normally distributed noise
measured=(0.2*lnoise)+bg; % Add noise of standard deviation 0.1 to the gain profile
subplot(6,1,i)
plot(f,measured,'r',f,bg,'g'); % Plot the clean and the noisy data on the same graph
brillouin2=@(x) sum((measured-x(1)*(1+4*((f-x(2)*1e10)./(x(3)*1e7)).^2).^-1).^2);
[x,fval,exitflag,output]=fminsearch(brillouin2,[1,1.05,3.5]);
y2((i-3),:)= x(1,:);
end
disp(y2);