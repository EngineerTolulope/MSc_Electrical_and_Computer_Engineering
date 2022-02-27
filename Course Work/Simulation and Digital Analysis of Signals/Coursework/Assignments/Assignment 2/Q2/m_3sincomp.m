%--m_3sincomp.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-05-31
%
% Description: This script implements the matlab function sincomp() and
%              generates a Fourier transform and line spectrum of a square
%              wave.
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

%% Setting parameters of sinusoids
inc = 1;    %inc is a place holder for odd numbers
square = 0; %square stores the summation of sinusoids
Amp = [];   %to contain a list of amplitudes
freq = [];   %to contain a list of frequencies

% figure(1)
for i = 1:N
    %inputs: k, n, f0, T, fs; use [] to skip a parameter
    [g_t,t,tmpa,tmpf,fs]= sincomp([],inc,[],[],[]);
    square = square + g_t;
    Amp(i) = tmpa;
    freq(i) = tmpf;
    
    inc= inc + 2;
end

%% Plotting of figures and calculation of Fourier transform
%Plotting the square wave
figure(1)
subplot(2,1,1);
plot (t, square)
xlabel('Time in Seconds');
ylabel('Amplitude in Volts');
title('Generation of a Square Wave');

%Superimposing the Fourier transform and line spectrum
subplot(2,1,2);
Nsamples=fs*2*pi; %Nsamples: Number of samples in square
df = 1/(2*pi);
f = 0:df:fs/2-df;
Aspectrum = abs(fft(square)); %square: square wave created with N=3
Aspectrum = (2/Nsamples)*Aspectrum(1:Nsamples/2);

stem(freq, Amp, 'r:');
hold on
plot(f, Aspectrum)
title('Fourier Transform and Line Spectrum of a Square Wave');
xlabel('Frequency in Hertz');
ylabel('Amplitude in Volts');

%%%%%%%%%%%%%%%%%%%%% End of matlab script %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
