% Calculate MUAPt from given indeces --------------------------------------
% Yiyang Shi, Mar 8, 2017
function MUAPt_sig = compute_MUAPt_sig(MUAP_sig, pulse_ind, current)
L = floor(current.T*current.fs*1000);  % Required number of samples.
maxLen = max(L,pulse_ind(end));
numPulseIdx = length(pulse_ind);
numCH = size(MUAP_sig, 2);
numPersp = size(MUAP_sig, 3);
numSamples = size(MUAP_sig, 1);
conv_res = zeros(maxLen, numCH, numPersp);

for iPulse = 1:numPulseIdx
    conv_res(pulse_ind(iPulse) + 1 : min(pulse_ind(iPulse) + numSamples, ...
            maxLen),:,:) = ...
                conv_res(pulse_ind(iPulse) + 1 : ...
                    min(pulse_ind(iPulse) + numSamples, maxLen), :, :) + ...
                        MUAP_sig(1 : length(pulse_ind(iPulse) + ...
                            1 : min(pulse_ind(iPulse) + numSamples, ...
                                maxLen)), :, :);
end

%Truncate the signal by leaving out a few pulse widths either side of the
%convolution result. I took the middle part of the convolution.
MUAPt_sig = conv_res(floor(maxLen / 2) - floor(L / 2) + 1 : ...
                floor(maxLen / 2) - floor(L / 2) + L, :, :);
