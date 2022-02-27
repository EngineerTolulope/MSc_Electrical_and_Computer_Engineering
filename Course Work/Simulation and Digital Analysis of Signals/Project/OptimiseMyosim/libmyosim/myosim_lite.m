% myosim_lite.m
% Author: Shriram Tallam Puranam Raghu
% Student ID: 3521860
% Date Created: 2016-04-29
% Date Modified: 2017-05-04.
% Myosim version used: V4.5
% Description: Modified version of Myosim, removed all GUI elements,
% returns signals as output. LOAD FUNCTION NOT PRESENT.
% Parameter structure is the same as Myosim 4.5. The parameters should be
% passed to the function. Optionally the signal required can be passed as a
% second argument. The valid options for the second argument is
% 'MUAP','MUAPT', 'MES' or 'ALL'. Default option is 'ALL'.


function sig = myosim_lite(parameters, varargin)

narginchk(1, 2);

if(nargin == 1)
    mode_flag = 'ALL';
else
   if(ischar(varargin{1}))
       mode_flag=varargin{1};
   else
       error('Invalid mode specified. Please check your options.');
   end
end


MSL.signals.MUAP = struct('sig', [],...
                          'params', [], ...
                          'SFAP',struct('sig', [], 'params', []));
MSL.signals.MES  =  struct('sig', []);
MSL.signals.MUAPt = [];
MSL.params = parameters;

% current  =  pass_parameter(MSL);
current  =  MSL.params.create.current;

%Resample signal from >=3KHz if something smaller is specified.
fs_min = 5; %Minimum sampling in KHz.
if (current.fs < fs_min)
    current.fs_flag = 1;
    fs_real = current.fs;
    %Determine nearest scaling factor that will push it >=fs_min
    current.fs_scale = ceil(fs_min/fs_real);
    current.fs = current.fs_scale.*fs_real;
else
    current.fs_flag = 0;
end

% Generate signals

MSL = compute_MUAP(MSL, current);
MSL = compute_MUAPt_ind(MSL, current);
MSL = compute_MES(MSL, current);

%Downsample the signal to the specified value if required.
if(current.fs_flag)
    MSL = downsample_sig(MSL, current);    
end

if(current.ap.enable)
    %Add noise.
    if(current.ap.baseline.enable)
        MSL = add_baselinenoise(MSL, current);
    end
    
    %Amplify
    if(current.ap.amp.enable)
        MSL = add_gain(MSL, current);
    end
    
    %Filter signal (Both BPF and AA in one function).
    if(current.ap.filt_params.enable||current.ap.aa_filt_params.enable)
        MSL = filter_sig(MSL, current);
    end
end

% Quantize signals. Do this AFTER resampling if necessary to avoid
% errors.
if(current.ap.enable && current.ap.quant.enable)
    MSL = quantize_sig(MSL, current);
end

MSL.signals.params = current; % Update params, important for plots to have proper timescale
MSL.signals.timestamp = now; % To interpret use function datestr

switch mode_flag
    case 'MUAP'
        sig = MSL.signals.MUAP;
    case 'MUAPT'
        sig = MSL.signals.MUAPt;
    case 'MES'
        sig = MSL.signals.MES.sig;
    case 'ALL'
        sig = MSL.signals;
    otherwise
        warning('Unknown mode. Returning all signals.');
        sig = MSL.signals;
end
