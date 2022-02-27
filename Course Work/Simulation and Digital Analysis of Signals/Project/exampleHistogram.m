clc;
clearvars;
close all;

% Example random signal.

sig = randn(1000, 1);

%% Two methods for histogram
figure;
numBins = 20;
histogram(sig, numBins); % This is specifying the number of bins.

figure;
binEdges = (-1:0.1:1)*3;
histogram(sig, binEdges); % This is specifying the bin edges.

%% Problem with method 1

numBins = 20;
sig1 = randn(1000, 1);
sig2 = randn(1000, 1) + 3;

figure;
hold on;
histogram(sig1, numBins, 'Normalization', 'probability'); 
histogram(sig2, numBins, 'Normalization', 'probability'); 
hold off;

legend('Histogram 1', 'Histogram 2')

sig1 = randn(1000, 1);
sig2 = 2*randn(1000, 1);

figure;
hold on;
histogram(sig1, numBins, 'Normalization', 'probability'); 
histogram(sig2, numBins, 'Normalization', 'probability'); 
hold off;

legend('Histogram 1', 'Histogram 2')

%% Solution with method 2

numBins = 20;
sig1 = randn(1000, 1);
sig2 = randn(1000, 1) + 3;

figure;
hold on;
hist = histogram(sig1, numBins, 'Normalization', 'probability'); 
binEdges = hist.BinEdges;
histogram(sig2, binEdges, 'Normalization', 'probability'); 
hold off;
