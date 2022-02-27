clearvars;
close all
clc

% load('.\matchedSigs\matchedSignals5Sec10Signals.mat')
%
% start = 1;
% end_ = 5;
% for i=1:220
%     newsig(:,i) = reshape(sigs(:,start:end_), [], 1);
%     start = start +5;
%     end_ = end_ +5;
% end

% load('ShriSigs.mat')
% sig = downsample(newsig,5);
%
% save('.\ShriSigs_fs1000.mat', 'sig')

load('ShriSigs_fs1000.mat')
shrisig = sig;

load('.\records\emgSigsFs1000.mat')

for i = 1:22
    recorded = sig(:,i);
    recorded = bsxfun(@minus, recorded, mean(recorded));
    start = 1;
    endi = 10;
    
    bestfit = 0;
    for j=start:endi
        simulated = shrisig(:,j);
        simulated = bsxfun(@minus, simulated, mean(simulated));
        
        signal1 = recorded;
        signal2 = simulated;
        
        numBins = 50;
        [hist1, binEdges] = histcounts(signal1, numBins, 'Normalization', 'probability');
        [hist2, binEdges] = histcounts(signal2, binEdges, 'Normalization', 'probability');
        
        P = hist1;
        Q = hist2;
        fitscore= sum(sqrt(P .* Q));
        
        if (fitscore >= bestfit)
            bestsig(:,i) = simulated;
            bestfit = fitscore;
            bestind = j;
        end
        
    end
    start = start +10;
    endi= endi +10;
end

save('.\BestShriSigs_fs1000.mat', 'bestsig')
