%--main.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-05-17
%
% Description: This script uses the matlab function makesin()to plot two
%              sinusoid signals
%              Function inputs: Amplitude (A) in mV
%                               Frequency (f0) in Hz
%                               Phase angle (phi) in degree
%                               Duration (T) in seconds
%                               Sampling rate (fs) in Hz
%
%% First sinusoidal signal
[g_t1,t1] = makesin(5*1e-3,2,0,1,100);
%% Second sinusoidal signal
[g_t2,t2] = makesin(5*1e-3,2,90,1,100);
%% Plotting the waveforms
figure(1)
plot(t1,g_t1,'b-')
hold on;
grid on;
plot(t2,g_t2,'r:')
title('Cosine WaveForm');
xlabel('Time(Seconds)');
ylabel('Amplitude(Volts)');
% text('Shift: 90 degrees, 0.125 seconds');


%%%%%%%%%%%%%%%%%%%%% End of matlab script %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%