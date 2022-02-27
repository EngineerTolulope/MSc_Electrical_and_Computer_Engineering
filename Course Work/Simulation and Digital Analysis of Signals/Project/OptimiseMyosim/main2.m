signal1 =  recordFile.sig(:,1); %Measured Signal
signal2 = recordFile.sig(:,3);

numBins = 100;

% figure;
% hold on;
% hist1 = histogram(signal1, numBins, 'Normalization', 'probability');
% binEdges = hist1.BinEdges;
% hist2 = histogram(signal2, binEdges, 'Normalization', 'probability');
% hold off;

[hist1, binEdges] = histcounts(signal1, numBins, 'Normalization', 'probability');
[hist2, binEdges] = histcounts(signal2, binEdges, 'Normalization', 'probability');


%Bhattacharyya Coefficient (BC)
P = hist1;
Q = hist2;
fitscore= sum(sqrt(P .* Q));

disp(fitscore)