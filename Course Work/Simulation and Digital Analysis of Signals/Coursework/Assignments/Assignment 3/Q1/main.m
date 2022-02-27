%--main.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-07-29
%
% Description: This script implements the matlab function makesin() and
%              plots a sinusoid in time and frequency domain.
%              Function inputs: Amplitude (A) in mV
%                               Frequency (f0) in Hz
%                               Phase angle (phi) in degree
%                               Duration (T) in seconds
%                               Sampling rate (fs) in Hz
%% Implementing the makesin function
clear
clc

[g_t,t,g_f,f]= makesin();

figure(1)
subplot(2,1,1);
plot(t,g_t)
xlabel('Time in Seconds');
ylabel('Amplitude in Volts');
title('Time domain of a sinusoid');

subplot(2,1,2);
plot(f, g_f)
xlabel('Frequency in Hertz');
ylabel('Amplitude in Volts');
title('Frequency domain of a sinusoid');

% %%%%%%%%%%%%%%%%%%%%% End of matlab script %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
