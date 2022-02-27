%% Lab 4
clear;
clc;
close all;

%% Set up the initial conditions
f=10e9:1e6:11e9; % Investigate frequencies between 10 GHz and 11 GHz
fb=10.5e9; % Set the Brillouin frequency at 10.5 GHz
delf=35e6; % The gain profile has a 35 MHz width
amp=1; % Set the initial amplitude to 1

 
%% Solve for and plot the Brillouin gain profile both with and without noise
bg=amp*(1+4*((f-fb)./delf).^2).^-1; % Calculate the Brillouin gain over the frequency range
lnoise=randn(size(f)); %Calculate the normally distributed noise
measured=0.1*lnoise+bg; % Add noise of standard deviation 0.1 to the gain profile
figure(1);
title('Noise of standard deviation 0.1');
plot(f,measured,'r',f,bg,'g'); % Plot the clean and the noisy data on the same graph

%% Add more noise
lnoise=randn(size(f));
measured=0.2*lnoise+bg;
figure(2);
title('Noise of standard deviation 0.2');
plot(f,measured,'r',f,bg,'g');

% Set up an anonymous function and search for a minimum
% Note that the function brillouin2 returns the sum of the squared error between the
%measured (noisy) data and the ideal curve. In this case x(1) corresponds to the
%amplitude of the Brillouin gain, x(2) corresponds to the Brillouin frequency scaled by a
%factor of 10GHz, and x(3) corresponds to the width of the profile and is scaled by a
%factor of 10MHz.
brillouin2=@(x) sum((measured-x(1)*(1+4*((f-x(2)*1e10)./(x(3)*1e7)).^2).^-1).^2);
[x,fval,exitflag,output]=fminsearch(brillouin2,[1,1.05,3.5])

%% Part A
% temp = 0;% from the first part
% n_level = 1.0; % initialize noise standard deviation
% freq_error = 0; 
% noise_std = 0; % in vector form
% freq_vec = 0; % in vector form
% 
% count = 1;
% 
% while(temp <= 2)
%     % Run new noise
%     % Record : standard deviation + frequency error
%     % Plot data + line of best fit (tools -> basic fitting)
%     % Identify the error limit on the graph
%     lnoise=randn(size(f));
%     measured=n_level*lnoise+bg;
%     figure(count);
%     title(['Noise of standard deviation ' num2str(n_level)]);
%     plot(f,measured,'r',f,bg,'g');
%     brillouin2=@(x) sum((measured-x(1)*(1+4*((f-x(2)*1e10)./(x(3)*1e7)).^2).^-1).^2);
%     [x,fval,exitflag,output]=fminsearch(brillouin2,[1,1.05,3.5])
%     
%     freq_error = abs(x(2)- 1.05)*1000; % in MHz
%     freq_vec(count) = freq_error;
%     noise_std(count) = n_level;
%     temp = freq_error/1; % 1Mhz/oC
%     n_level = n_level + 0.01;
%     count = count + 1;
% end
% 
% figure(count+1);
% title('The standard deviation of noise vs the frequency error');
% xlabel('Noise standard deviation');
% ylabel('Frequency error (MHz)');
% plot(noise_std, freq_vec,'r');
% grid on;
% 
% % the change happens at different values given different random noise!
% % typically greater than 1.0 and less than 2.0 of standard deviation

%% Part b)

s=[
237 620 237 620 237 120 237 120
237 120 237 35 226 24 143 19
143 19 143 19 143 0 143 0
143 0 143 0 435 0 435 0
435 0 435 0 435 19 435 19
435 19 353 23 339 36 339 109
339 109 339 108 330 620 339 620
339 620 339 620 393 620 393 620
393 620 507 620 529 602 552 492
552 492 552 492 576 492 576 492
576 492 576 492 570 662 570 662
570 662 570 662 6 662 6 662
6 662 6 662 0 492 0 492
0 492 0 492 24 492 24 492
24 492 48 602 71 620 183 620
183 620 183 620 237 620 237 620];

% rows : 16 lines
% per row: every two values represent a point
% start with : initial point, first control point, second control point,
% then end point
% [rows, columns] = size(s);
s= s*0.2;
s= s+100;

figure;
t=0:0.01:1;
for n=1:16
x1=s(n,1);y1=s(n,2);x2=s(n,3);y2=s(n,4);x3=s(n,5);y3=s(n,6);x4=s(n,7);y4=s(n,8);
bx=3*(x2-x1);
cx=3*(x3-x2)-bx;
dx=x4-x1-bx-cx;
by=3*(y2-y1);
cy=3*(y3-y2)-by;
dy=y4-y1-by-cy;
x=x1+bx*t+cx*t.^2+dx*t.^3;
y=y1+by*t+cy*t.^2+dy*t.^3;
hold on
plot(x,y)
end

% s = s*0.2
s1= s*0.2;
figure;
subplot(3,1,2);
title('s = s*0.2');
t=0:0.01:1;
for n=1:16
x1=s1(n,1);y1=s1(n,2);x2=s1(n,3);y2=s1(n,4);x3=s1(n,5);y3=s1(n,6);x4=s1(n,7);y4=s1(n,8);
bx=3*(x2-x1);
cx=3*(x3-x2)-bx;
dx=x4-x1-bx-cx;
by=3*(y2-y1);
cy=3*(y3-y2)-by;
dy=y4-y1-by-cy;
x=x1+bx*t+cx*t.^2+dx*t.^3;
y=y1+by*t+cy*t.^2+dy*t.^3;
hold on
plot(x,y)
end

subplot(3,1,3);
title('s = s+100');
s2 = s + 100;
t=0:0.01:1;
for n=1:16
x1=s2(n,1);y1=s2(n,2);x2=s2(n,3);y2=s2(n,4);x3=s2(n,5);y3=s2(n,6);x4=s2(n,7);y4=s2(n,8);
bx=3*(x2-x1);
cx=3*(x3-x2)-bx;
dx=x4-x1-bx-cx;
by=3*(y2-y1);
cy=3*(y3-y2)-by;
dy=y4-y1-by-cy;
x=x1+bx*t+cx*t.^2+dx*t.^3;
y=y1+by*t+cy*t.^2+dy*t.^3;
hold on
plot(x,y)
end

subplot(3,1,1)
title('Original plot');
t=0:0.01:1;
for n=1:16
x1=s(n,1);y1=s(n,2);x2=s(n,3);y2=s(n,4);x3=s(n,5);y3=s(n,6);x4=s(n,7);y4=s(n,8);
bx=3*(x2-x1);
cx=3*(x3-x2)-bx;
dx=x4-x1-bx-cx;
by=3*(y2-y1);
cy=3*(y3-y2)-by;
dy=y4-y1-by-cy;
x=x1+bx*t+cx*t.^2+dx*t.^3;
y=y1+by*t+cy*t.^2+dy*t.^3;
hold on
plot(x,y)
end
%% Question
% The character 'T' is represented by the above array
% The effect is the character is scale by a factor of 0.2
% The effect is the character shifts 100 units along both x/y directions 
% Create or find (indicate your source) another array to produce another
% character

% S
s = [0.0  591.0 0.0 864.0 1000.0  864.0 1000.0  591.0 
    1000.0 591.0 1000.0  591.0 1000.0 45.0 1000.0 45.0
    1000.0 45.0 1000.0 45.0 727.0 45.0 727.0 45.0
    727.0 45.0 727.0 45.0 727.0 136.0 727.0 136.0
    727.0 136.0 727.0 0.0 0.0 0.0 0.0 227.0
    0.0 227.0 0.0 545.0 727.0 545.0 727.0 364.0
    727.0  364.0 727.0  500.0 727.0  500.0  727.0 545.0
    727.0  545.0 727.0  727.0 272.0  727.0 272.0  592.0
    272.0  592.0 272.0  592.0   0.0  592.0   0.0  592.0
    636.0  280.0 636.0  90.0 136.0  119.0 136.0  250.0
    136.0  250.0 136.0  437.0 636.0 437.0 636.0 280.0];

figure;
title('Original plot');
t=0:0.01:1;
for n=1:11
x1=s(n,1);y1=s(n,2);x2=s(n,3);y2=s(n,4);x3=s(n,5);y3=s(n,6);x4=s(n,7);y4=s(n,8);
bx=3*(x2-x1);
cx=3*(x3-x2)-bx;
dx=x4-x1-bx-cx;
by=3*(y2-y1);
cy=3*(y3-y2)-by;
dy=y4-y1-by-cy;
x=x1+bx*t+cx*t.^2+dx*t.^3;
y=y1+by*t+cy*t.^2+dy*t.^3;
hold on
plot(x,y)
end

