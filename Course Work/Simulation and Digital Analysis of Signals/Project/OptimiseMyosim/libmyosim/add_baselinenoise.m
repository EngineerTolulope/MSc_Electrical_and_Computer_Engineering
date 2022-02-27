%ADD BASELINE NOISE-------------------------------------------------------
%===========================Modified by STPR==============================%
%Date: 30 July 2016.
% Keep in mind that we are considering the noise as being constant across
% perspectives.

function struc_data = add_baselinenoise(struc_data, current)
fs = current.fs*1000;

[numSamples, numCH, ~] = size(struc_data.signals.MES.sig);
noise = generatenoise(current.ap.baseline, fs, [numSamples, numCH]);

noise = 1000.*noise; %Noise in mV.

struc_data.signals.MES.sig = bsxfun(@plus, struc_data.signals.MES.sig, noise);
