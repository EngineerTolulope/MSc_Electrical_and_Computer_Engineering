% Description: Run the current member to generate the signals using Myosim,
%              and get the fitness score. Matched signals can be saved
%              here.
%   Inputs are the current memeber and the userData substructure. The
%   userData contains the fitscore threshold, the data being matched, the
%   sampling frequency, the origin file name and the location to save
%   matched data as fields.

function FitScore = runMyosim(member, options)

parameters = updateMyosimParameters(options.parameters, member);

mes = myosim_lite(parameters, 'ALL');

% spectralMAD = getSpectrumError(options.data, mes, options.fs);
FitScore = getHistFitScore(options.data, mes, options.timeperiod ,options.fs);

% Save the signal if a match is found.
if(FitScore >= options.threshold)
    fprintf('\nThe fitness score was found to be greater than threshold: %g >= %g.', ...
            FitScore, options.threshold)    
    originFileName = options.originFileName;
    saveFileName = sprintf('%d_GA_%s.mat', options.count, datestr(now, 30));
    fprintf('\nSaving matched signal as %s.', saveFileName);
    SamplingRate = options.fs;
    Threshold = options.threshold;
    save(sprintf('%s%s%s', options.resultsDir, filesep, saveFileName), ...
        'member', 'mes', 'originFileName', 'FitScore', 'SamplingRate', 'Threshold');
end
