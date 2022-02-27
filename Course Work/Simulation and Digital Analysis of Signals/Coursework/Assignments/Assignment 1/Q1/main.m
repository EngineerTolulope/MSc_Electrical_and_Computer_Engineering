%--main.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-05-17
%
% Description: This script tests the matlab function makesin()
%              Function inputs: Amplitude (A) in mV
%                               Frequency (f0) in Hz
%                               Phase angle (phi) in degree
%                               Duration (T) in seconds
%                               Sampling rate (fs) in Hz

%% Implementing the makesin fucntion
%inputs: A, fo, phi (in degrees), T, fs; use [] to skip a parameter'
[g_t,t] = makesin(5*1e-3,2,0,1,100);

%% Plotting the waveforms
figure(1)
plot(t,g_t)
grid on
title('Cosine WaveForm');
xlabel('Time(Seconds)');
ylabel('Amplitude(Volts)');

%%%%%%%%%%%%%%%%%%%%% End of matlab script %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
