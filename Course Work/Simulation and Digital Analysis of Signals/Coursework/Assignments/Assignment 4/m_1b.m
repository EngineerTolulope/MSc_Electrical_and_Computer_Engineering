%--m_1b.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-10-23
%
% Description:  This script accesses a data file ('ex1.mat') containing 1xN
% record of simulated EMG data sampled at 1000Hz. It plots the data in the
% time domain, and generates the power spectrum of the signal averaging
% with 0.5 sec square window epochs, with no overlap.
%
%% Gets the data and uses it for calculation
clear
clc

load ('ex1.mat');
emg = emg - mean(emg);

fs=1000; T=0.5;
dt = 1/fs; N=T/dt; df = 1/T;
t = 0:dt:T-dt;  % time range
f = 0:df:fs-df; % frequency range

% PWelch with averaging, pwelch returns the Power Spectrum and Frequency
Tseg = 0.5; Nseg = Tseg*fs; %Nseg: number of points in a segment
[PSw, fw] = pwelch(emg, rectwin(Nseg), 0, Nseg, fs, 'Power');

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
title('Power spectrum of the EMG signal with pwelch averaging of 0.5 epochs');

%% Calculates and displays the power in the time and frequency domain
Ptd = mean(emg.^2); %power of the signal in the time domain
Pfd = sum(PSw); %power of the signal in the frequency domain
disp([Ptd Pfd])
