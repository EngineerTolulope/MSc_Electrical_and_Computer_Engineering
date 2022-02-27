%--m_2.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-10-23
%
% Description:  This script accesses a data file ('ex1.mat') containing 1xN
% record of simulated EMG data sampled at 1000Hz. It plots a 20-bin
% histogram of the amplitude of the emg signal.
%
%% Gets the data and uses it for calculation
clear
clc

load ('ex1.mat');
emg = emg - mean(emg);

nbin = 20; %nbin is the number of bins

[N, edges] = histcounts(emg, nbin); %returns the counts in each bin, and the edges.
edges = edges(1,2:length(edges));   %edges was higher than N by a value of 1

%% Plots the figures
figure(1)
bar(edges, N)
xlabel('The Bin Edges');
ylabel('Number of Occurences in Each Bin');
title('The histogram distribution of the amplitudes in a EMG signal');

figure(2)
histogram(emg, nbin)
xlabel('The Bin Edges');
ylabel('Number of Occurences in Each Bin');
title('The histogram distribution of the amplitudes in a EMG signal');
