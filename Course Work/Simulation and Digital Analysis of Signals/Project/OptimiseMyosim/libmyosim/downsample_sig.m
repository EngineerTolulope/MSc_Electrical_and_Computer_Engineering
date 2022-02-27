
%DOWNSAMPLE SIGNAL-------------------------------------------------------
%===========================Modified by STPR==============================%
%Date: 2014-04-11
function struc_data = downsample_sig(struc_data, current)
%Using the 'resample' function to get the sampling frequency specified by
%user.
fs_real = current.fs / current.fs_scale;
[~, numCH, numPersp] = size(struc_data.signals.MES.sig);
MES_temp = zeros(floor(fs_real * current.T * 1000), numCH, numPersp);

for ii = 1:numPersp
    MES_temp(:, :, ii) = resample(struc_data.signals.MES.sig, 1, current.fs_scale);    
end

struc_data.signals.MES.sig = MES_temp;
