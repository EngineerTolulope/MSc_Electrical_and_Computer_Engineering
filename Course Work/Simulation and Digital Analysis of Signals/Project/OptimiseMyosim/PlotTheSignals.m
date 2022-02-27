%   Description: This script loads the recorded signal and the simulated
%   signals stored in a particular directory. It plots the signals, power
%   spectrums, and the histograms of the signals. It also displays the
%   fitness scores and the signal parameters.

clearvars;
close all
clc

load('.\records\emgSigsFs1000.mat')

fs = 1000;
T = 1;
numBins = 50; %histogram bin count

for i=1:22
    %Gets the simulated signal and loads it
    recordDir = 'Fit_AmplitudeHistogram';
    file = dir(sprintf('%s%s%d_GA_*.mat', recordDir, filesep, i));
    if (isempty(file))
        continue;
    end
    recordfile = load(sprintf('%s%s%s', recordDir, filesep, file.name));
    
    recorded = sig(:,i);
    simulated = recordfile.mes.MES.sig;
    % Remove any DC component.
    recorded = bsxfun(@minus, recorded, mean(recorded));
    simulated = bsxfun(@minus, simulated, mean(simulated));
    
    recorded = recorded(1:fs*T);
    simulated = simulated(1:fs*T);
    
    disp(recordfile.member)
    fitscore = recordfile.FitScore;
    fprintf('Fitness Score %d = %.4f\n\n', i,fitscore);
    
    % Plots the signals
    figure(1)
    Vmin = min([recorded simulated], [], 'all');
    Vmax = max([recorded simulated], [], 'all');
    Ylimits = [Vmin Vmax];
    subplot(2,1,1);
    plot(recorded), ylim(Ylimits);
    xlabel('Time in Seconds');
    ylabel('Amplitude of the signal');
    title('Time domain of the recorded signal');
    subplot(2,1,2);
    plot(simulated), ylim(Ylimits);
    xlabel('Time in Seconds');
    ylabel('Amplitude of the signal');
    title('Time domain of the simulated signal');
    
    % Gets the power spectrum and plots them
    [PSw, fw] = pwelch(recorded, rectwin(length(recorded)), 0, length(recorded), fs, 'Power');
    [PSw1, fw1] = pwelch(simulated, rectwin(length(simulated)), 0, length(simulated), fs, 'Power');
    
    Vmin = min([PSw PSw1], [], 'all');
    Vmax = max([PSw PSw1], [], 'all');
    Ylimits = [Vmin Vmax];
    figure(2)
    subplot(2,1,1);
    plot(fw, PSw), ylim(Ylimits); %pwelch returns only the positive half of the spectrum by default.
    xlabel('Frequency in Hertz');
    ylabel('Power Spectral Density in V^2/Hz');
    title('Power spectrum of the recorded signal');
    subplot(2,1,2);
    plot(fw1, PSw1), ylim(Ylimits); %pwelch returns only the positive half of the spectrum by default.
    xlabel('Frequency in Hertz');
    ylabel('Power Spectral Density in V^2/Hz');
    title('Power spectrum of the simulated signal')
    
    % Plots the histogram distributions
    figure(3)
    clf;
    hold on;
    hist = histogram(recorded, numBins);
    histogram(simulated, hist.BinEdges);
    legend('Recorded', 'Simulated')
    xlabel('The Bin Edges');
    ylabel('Number of Occurences in Each Bin');
    title('The histogram of the recorded and simulated signal');
    hold off;
end

