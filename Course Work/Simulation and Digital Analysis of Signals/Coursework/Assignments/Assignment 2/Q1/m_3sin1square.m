%--m_3sin1square.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-05-31
%
% Description: This script implements the matlab function sincomp() and
%              generates a square wave from the summation of the results.
%              Function inputs: Amplitude(k) in mV
%                               Odd positive intergers(n)
%                               Frequency (f0) in Hz
%                               Duration (T) in Seconds
%                               Sampling rate (fs) in Hz

%% Getting the number of sinusoids
% while (1)
%     N = input('How many sinusoids do you want(2 <= x <= 100)...? ');
%     if (N >= 2 && N <= 100)
%         break;
%     end
% end
N = 3; %N is the number of sinusoid components considered

%% Setting sinusoids parameters & Plotting Waveforms
inc = 1;    %inc is a place holder for odd numbers
square = 0; %square stores the summation of sinusoids
figure(1)
for i = 1:N
    %inputs: k, n, f0, T, fs; use [] to skip a parameter
    [g_t,t]= sincomp([],inc,[],[],[]);
    square = square + g_t;
    
    %Creates a subplot for every sinusoid
    subplot(4, 1, i);
    plot (t, g_t)
    xlabel('Time in Seconds');
    ylabel('Amplitude in Volts');
    
    inc= inc + 2;
end

%Creates the final square wave
subplot(4,1,4);
plot (t, square)
xlabel('Time in Seconds');
ylabel('Amplitude in Volts');

suptitle('Generation of Square Wave using Fourier Series');


%%%%%%%%%%%%%%%%%%%%% End of matlab script %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
