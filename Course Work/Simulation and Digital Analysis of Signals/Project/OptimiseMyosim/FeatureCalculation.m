clearvars;
close all
clc

load('.\records\emgSigsFs1000.mat')
record = sig;
load('.\Fit_PowerSpectrum\BestShriSigs_fs1000.mat')
powerspec = bestsig;

fs = 1000;
T = 5;
OneSec = fs*1;
deadzone = 0.005;

for i=1:22
    %Gets the simulated signal and loads it
    recordDir = 'Fit_AmplitudeHistogram';
    file = dir(sprintf('%s%s%d_GA_*.mat', recordDir, filesep, i));
%     if (isempty(file))
%         continue;
%     end
    recordfile = load(sprintf('%s%s%s', recordDir, filesep, file.name));
    
    recorded = record(:,i);
    simulatedPow = powerspec(:,i);
    simulatedHist = recordfile.mes.MES.sig;
    % Remove any DC component.
    recorded = bsxfun(@minus, recorded, mean(recorded));
    simulatedPow = bsxfun(@minus, simulatedPow, mean(simulatedPow));
    simulatedHist = bsxfun(@minus, simulatedHist, mean(simulatedHist));
    
    startsig = 1;
    endsig = OneSec;
    for j=1:T
        MAV = getMAV(recorded(startsig:endsig));
        MF = getmeanfreq(recorded(startsig:endsig), fs);
        SSC = getSSC(recorded(startsig:endsig), deadzone); %check dead zone value
        WL = getWL(recorded(startsig:endsig));
        ZC = getZC(recorded(startsig:endsig), deadzone); %check dead zone value
        
        rec_MAV(j,i) = MAV;
        rec_MF(j,i) = MF;
        rec_SSC(j,i) = SSC;
        rec_WL(j,i) = WL;
        rec_ZC(j,i) = ZC;
        
        %Features from Simulated Power Fitness
        MAV = getMAV(simulatedPow(startsig:endsig));
        MF = getmeanfreq(simulatedPow(startsig:endsig), fs);
        SSC = getSSC(simulatedPow(startsig:endsig), deadzone); %check dead zone value
        WL = getWL(simulatedPow(startsig:endsig));
        ZC = getZC(simulatedPow(startsig:endsig), deadzone); %check dead zone value
        
        simP_MAV(j,i) = MAV;
        simP_MF(j,i) = MF;
        simP_SSC(j,i) = SSC;
        simP_WL(j,i) = WL;
        simP_ZC(j,i) = ZC;
        
        %Features from Simulated Histogram Fitness
        MAV = getMAV(simulatedHist(startsig:endsig));
        MF = getmeanfreq(simulatedHist(startsig:endsig), fs);
        SSC = getSSC(simulatedHist(startsig:endsig), deadzone); %check dead zone value
        WL = getWL(simulatedHist(startsig:endsig));
        ZC = getZC(simulatedHist(startsig:endsig), deadzone); %check dead zone value
        
        simH_MAV(j,i) = MAV;
        simH_MF(j,i) = MF;
        simH_SSC(j,i) = SSC;
        simH_WL(j,i) = WL;
        simH_ZC(j,i) = ZC;
        
        startsig = startsig + OneSec;
        endsig = endsig + OneSec;
        
    end
end

%Plots the features
figure (1)
plot(1:22, rec_MAV, 'ko', 1:22, simH_MAV, 'bx', 1:22, simP_MAV, 'rd', 'MarkerSize', 8)
title('Mean Absolute Value (MAV)')
figure (2)
plot(1:22, rec_MF, 'ko', 1:22, simH_MF, 'bx', 1:22, simP_MF, 'rd', 'MarkerSize', 8)
title('Mean Frequency (MF)')
figure (3)
plot(1:22, rec_SSC, 'ko', 1:22, simH_SSC, 'bx', 1:22, simP_SSC, 'rd', 'MarkerSize', 8)
title('Slope Sign Changes (SSC)')
figure (4)
plot(1:22, rec_WL, 'ko', 1:22, simH_WL, 'bx', 1:22, simP_WL, 'rd', 'MarkerSize', 8)
title('Waveform Length (WL)')
figure (5)
plot(1:22, rec_ZC, 'ko', 1:22, simH_ZC, 'bx', 1:22, simP_ZC, 'rd', 'MarkerSize', 8)
title('Zero Crossings (ZC)')

%Saves the features
save('.\z_Features.mat', 'rec_MF', 'simH_MF', 'simP_MF', 'rec_MAV', 'simH_MAV','simP_MAV', ...
    'rec_SSC', 'simH_SSC', 'simP_SSC', 'rec_WL', 'simH_WL', 'simP_WL', 'rec_ZC', 'simH_ZC', 'simP_ZC');


