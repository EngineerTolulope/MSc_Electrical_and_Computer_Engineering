%--m_1a.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-10-23
%
% Description:  This script accesses a data file ('ex1.mat') containing 1xN
% record of simulated EMG data sampled at 1000Hz. It plots the data in the
% time domain, and generates the power spectrum of the signal.
%
%% Gets the data and uses it for calculation
clear
clc

load ('ex1.mat');
emg = emg - mean(emg);

fs=1000; T=5;   
dt = 1/fs; N=T/dt; df = 1/T;
t = 0:dt:T-dt;  % time range
f = 0:df:fs-df; % frequency range

% EMG = 2*(abs(fft(emg))/N).^2;

%pwelch returns the Power Spectrum and Frequency
[PSw, fw] = pwelch(emg, rectwin(length(emg)), 0, length(emg), fs, 'Power');

%% Plots the figures
figure(1)
subplot(2,1,1);
plot(t(t<1), emg(t<1))  %only one sec of the data is plotted
xlabel('Time in Seconds');
ylabel('Amplitude in Volts');
title('Time domain of the EMG signal');

subplot(2,1,2);
% plot(f(f<fs/2), EMG(f<fs/2))
plot(fw, PSw) %pwelch returns only the positive half of the spectrum by default.
xlabel('Frequency in Hertz');
ylabel('Power Spectral Density in V^2/Hz');
title('Power spectrum of the EMG signal');

%% Calculates and displays the power in the time and frequency domain
Ptd = mean(emg.^2); %power of the signal in the time domain
% Pf = sum(EMG(f<fs/2));
Pfd = sum(PSw); %power of the signal in the frequency domain
disp([Ptd Pfd])
