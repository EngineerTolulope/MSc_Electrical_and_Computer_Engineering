%--main.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-05-17
%
% Description: This script implements a matlab function "makesinQ()" which generates a
%              sinusoid (a cosine) given in-phase and quadrature
%              components.
%              Function inputs: In-Phase Component (Aip) in mV
%                               Quadrature Component (Aqu) in mV
%                               Frequency (fo) in Hz
%                               Duration (T) in seconds
%                               Sampling rate (fs) in Hz

%% Implementing the makesinQ function
T = 1;
fs = 100;
%inputs: Aip, Aqu, fo, T, fs; use [] to skip a parameter
[g_t1,t1,arr] = makesinQ([],[],[],T,fs);
%% Implementing the makesin fucntion
A =sqrt(arr(1)^2 + arr(2)^2);   %arr contains all input of the makesinQ
f0 = arr(3);
phi = atan(arr(2)/arr(1));
%T and fs is already predefined

%inputs: A, fo, phi (in degrees), T, fs; use [] to skip a parameter'
[g_t2,t2] = makesin(A, f0, phi, T,fs);

%% Plotting the waveforms
figure(1)
plot(t1,g_t1,'b-')
hold on;
grid on;
plot(t2,g_t2,'r:')
title('SuperImposed WaveForm');
xlabel('Time(Seconds)');
ylabel('Amplitude(Volts)');

%%%%%%%%%%%%%%%%%%%%% End of matlab script %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%