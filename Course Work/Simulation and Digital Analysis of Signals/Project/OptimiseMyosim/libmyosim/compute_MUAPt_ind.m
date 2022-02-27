% COMPUTE MUAPt -------------------------------------------------------------------------------
function struc_data = compute_MUAPt_ind(struc_data, current)

%==============Modified by STPR==========================================%
%Date: 11/July/2016 Instead of saving them in files, save them in cell
%array.
struc_data.signals.MUAPt=cell(1,current.MMUAP);
%The rest of the code is adjusted accordingly.

% Now only indices are calculated here. The corresponding MUAPt is calculated
% upon request for optimal memory use.
% Modified by Yiyang Shi on Mar 6, 2017


for m = 1:current.MMUAP  % for each motor unit train to be created
    % Initialize MUAPt structure: MUAPt.sig, MUAPt.params
    %=======================Modified by STPR==========================%
    %Date: 12 September 2016 Change Fr to be the random Fr of each MU. The
    %Fr was already randomised in compute_MUAP function and stored in the
    %structre. Use that value here.
    MUAPt = struct('pulse_ind',[], ...
            'params', struct('Fr',struc_data.signals.MUAP(m,1).params.Fr,'C',current.C));  
    
    ipi = 1/struc_data.signals.MUAP(m,1).params.Fr;   % mean inter-pulse interval (in sec)
    
    
    % Get the maximum possible number of pulses with the given parameters.
    % Smallest time period gives the max possible pulses. So get
    % mu-3*sigma.
    % Generate a few extra pulses on either side to account for the edges.
    % I just decided a few to be like 4-6.
    Extra_Pulses=6;
    Max_pulses=floor((current.T)/(ipi-3*(ipi*current.C)))+Extra_Pulses;
    tk=(ipi*current.C).*randn(Max_pulses,1)+ipi;
    
    % Updated 2017-05-08: Mirror values around 20ms. That is, all values
    % below 20ms will be wrapped around.
    t_lim=0.02;
    % First take care of any negative values.
    
    tk(tk<0)=0-tk(tk<0);
    
    % Now anything smaller than 20ms should be wrapper around.
    
    tk(tk<t_lim)=t_lim+(t_lim-tk(tk<t_lim));
    
    pulse_ind=floor(tk.*current.fs*1000);
    pulse_ind=cumsum(pulse_ind);
    
    %Truncate the signal by leaving out a few pulse widths either side of the
    %convolution result. I took the middle part of the convolution.
    MUAPt.pulse_ind=pulse_ind;
    struc_data.signals.MUAPt{m}=MUAPt;    
end % for m = each MUAP
