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

for fs = 3:10
    %inputs: A, f0, phi, T, fs; use [] to skip a parameter
    [g_t,t,g_f,f]= makesin([],[],[],[],fs);
    
    figure(fs)  %Plots a new figure with each iteration
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
    pause(1) %Pauses for one second
    
    %     savefig(['fs' num2str(fs) '.fig']);
    fs = fs+1;
end


%%%%%%%%%%%%%%%%%%%%%%% End of matlab script %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
