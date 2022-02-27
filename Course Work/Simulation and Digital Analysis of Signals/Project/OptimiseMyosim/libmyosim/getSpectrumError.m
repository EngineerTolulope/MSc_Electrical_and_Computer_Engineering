% Get spectrum error between matched signal and record.
% There are some hard-coded values in this function, modify parameters in
% the function as required.
% TODO: Try to remove hard coded values later.

function relativeMAD = getSpectrumError(recordSig, simulatedSig, fs)
% Remove any DC component.
recordSig = bsxfun(@minus, recordSig, mean(recordSig));

simulatedSig = [simulatedSig.MES];
simulatedSig = [simulatedSig.sig];

simulatedSig = bsxfun(@minus, simulatedSig, mean(simulatedSig));

% Set pwelch parameters in this function. Not the best way to do it, try to
% pass value instead. Fix later.

winLen = fs/2;
nfft = fs/2;
overLap = fs/4;

[recordSpec, f] = pwelch(recordSig, winLen, overLap, nfft, fs);

% Consider frequencies only between 20-58 and 62-150.

freqVec = (f >= 20 & f<= 58) | (f >= 62 & f <= 150);

% Convert a potential 3D matrix to 2D for pwelch.
[numSamples, numCH, numPersp] = size(simulatedSig);
simulatedSig = reshape(simulatedSig, numSamples, numCH*numPersp);

[simSpec, ~] = pwelch(simulatedSig, winLen, overLap, nfft, fs);

specDiff = bsxfun(@minus, recordSpec(freqVec), simSpec(freqVec, :));

% Compute relative mean absolute difference (i.e. difference normalised by
% power of record.
relativeMAD = mean(abs(specDiff)) ./ sum(recordSpec);

% Now finally get the best match from all channels and perspectives.
relativeMAD = min(relativeMAD, [], 'all');
end

