--no_ofsinmodi.m

Author: Tolulope Olugbenga
Id: 3643581
Date: 2019-05-31

Description: This script implements the matlab function sincomp() and
             generates a square wave from the summation of the results.
             Function inputs: Amplitude(k) in mV
                              Odd positive intergers(n)
                              Frequency (f0) in Hz
                              Duration (T) in Seconds
                              Sampling rate (fs) in Hz

% Getting the number of sinusoids
while (1)
    N = input('How many sinusoids do you want(2 <= x <= 100)...? ');
    if (N >= 2 && N <= 100)
        break;
    end
end
N = 100;    %N is the number of sinusoid components considered

% Setting sinusoids parameters & Plotting Waveforms
inc = 1;    %inc is a place holder for odd numbers
square = 0; %square stores the summation of sinusoids
figure(1)
for i = 1:N
    inputs: k, n, f0, T, fs; use [] to skip a parameter
    [g_t,t]= sincomp([],inc,[],[],[]);
    square = square + g_t;
    
    Creates a subplot for every sinusoid in [2,5,10,100]
    if (i==2)
        subplot(4, 1, 1);
        plot (t, square)
    elseif (i==5)
        subplot(4, 1, 2);
        plot (t, square)
    elseif (i==10)
        subplot(4, 1, 3);
        plot (t, square)
    elseif (i==100)
        subplot(4, 1, 4);
        plot (t, square)
    end
    xlabel('Time in Seconds');
    ylabel('Amplitude in Volts');
    
    inc= inc + 2;
end

suptitle('Generation of Square Wave using Fourier Series');
%%%%%%%%%%%%%%%%%%%% End of matlab script %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
