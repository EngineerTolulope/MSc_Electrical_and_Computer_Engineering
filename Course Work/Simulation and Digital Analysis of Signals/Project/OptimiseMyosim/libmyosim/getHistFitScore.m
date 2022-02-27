% Get the fitness score using the Bhattacharyya Coefficient (BC) to compare
% between the  matched signal and record.

function fitscore = getHistFitScore(recordSig, simulatedSig,T, fs)
% Remove any DC component.
recordSig = bsxfun(@minus, recordSig, mean(recordSig));

simulatedSig = [simulatedSig.MES];
simulatedSig = [simulatedSig.sig];

simulatedSig = bsxfun(@minus, simulatedSig, mean(simulatedSig));

signal1 =  recordSig(1:T*fs); %Measured Signal
signal2 = simulatedSig(1:T*fs); %Simulated Signal

numBins = 50;
[hist1, binEdges] = histcounts(signal1, numBins, 'Normalization', 'probability');
[hist2, binEdges] = histcounts(signal2, binEdges, 'Normalization', 'probability');

%Bhattacharyya Coefficient (BC)
P = hist1;
Q = hist2;
fitscore= sum(sqrt(P .* Q)); 

% disp(fitscore)
% 
% figure;
% hold on;
% hist3 = histogram(signal1, numBins, 'Normalization', 'probability');
% histogram(signal2, hist3.BinEdges, 'Normalization', 'probability')
% drawnow
% hold off;

end

