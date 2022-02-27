%FILTER SIGNAL-------------------------------------------------------
%===========================Modified by STPR==============================%
%Date: 30 July 2016
%Modified: 23 August 2016

function struc_data = filter_sig(struc_data, current)

% Filter the signal using the SP toolbox butterworth filter implementation.

fs = current.fs * 1000;

if(current.ap.filt_params.enable)
    %Design the BPF
    %HPF
    [hpf_num, hpf_den] = butter(current.ap.filt_params.hpf_ord, ...
                                current.ap.filt_params.hpf_fc/(fs/2), ...
                                'high');
                            
    hpf_flag = isstable(hpf_num,hpf_den);
    
    %LPF
    [lpf_num, lpf_den] = butter(current.ap.filt_params.lpf_ord, ...
                                current.ap.filt_params.lpf_fc/(fs/2), ...
                                'low');
    lpf_flag = isstable(lpf_num, lpf_den);
else
    hpf_flag = 1;
    lpf_flag = 1;
end

if(current.ap.aa_filt_params.enable)
    %AA=lpf filter
    [aa_filt_num, aa_filt_den] = butter(current.ap.aa_filt_params.ord, ...
                                        current.ap.aa_filt_params.fc/(fs/2), ...
                                        'low');
                                    
    aa_filt_flag = isstable(aa_filt_num, aa_filt_den);
else
    aa_filt_flag = 1;
end

%Sometimes filter might be unstable, if that is the case, skip filtering.
if(~hpf_flag)
    warning('High Pass filter with the given specifications is unstable.Skipping filtering.');
    return
elseif(~lpf_flag)
    warning('Low Pass filter with the given specifications is unstable.Skipping filtering.');
    return
elseif(~aa_filt_flag)
    warning('AA filter with the given specifications is unstable.Skipping filtering.');
    return
else    
    [~, numCH, numPersp] = size(struc_data.signals.MES.sig);
    
    for iCH = 1:numCH
        for iPersp = 1:numPersp
            if(current.ap.filt_params.enable)
                struc_data.signals.MES.sig(:, iCH, iPersp) = ...
                    filter(hpf_num, hpf_den, ...
                        struc_data.signals.MES.sig(:, iCH, iPersp));
                struc_data.signals.MES.sig(:, iCH, iPersp) = ...
                    filter(lpf_num, ...
                        lpf_den, struc_data.signals.MES.sig(:, iCH, iPersp));
            end
            if(current.ap.aa_filt_params.enable)
                struc_data.signals.MES.sig(:, iCH, iPersp) = ...
                    filter(aa_filt_num, aa_filt_den, ...
                        struc_data.signals.MES.sig(:, iCH, iPersp));
            end
        end        
    end
end
