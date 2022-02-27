clear
clc

load emgSigs.mat
sig = downsample(sig,5);

save('records/emgSigsFs1000.mat', 'sig');