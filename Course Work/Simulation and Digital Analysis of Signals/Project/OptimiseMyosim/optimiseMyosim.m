% Description: Try to match records with Myosim by varying key parameters.
% For this work, assume depth, CV, number of fibres, number of MUs to be
% the key parameters. Modify as required.

clearvars;
close all
clc

% Run diary command if the console output should be saved.

% Add relevant libraries to path.

libDirs = {'libGA', 'libMyosim', 'libMisc'};

for iDir = 1:length(libDirs)
    addpath(genpath(libDirs{iDir}));
end

% Path to the records to match. Can be relative.

recordDir = 'records';
resultsDir = 'matchedSigs';

if(exist(resultsDir,'dir') == 0)
    mkdir(resultsDir)
end

bestsigDir = 'BestSigs';
if(exist(bestsigDir,'dir') == 0)
    mkdir(bestsigDir)
end

% Declare geneticAlgorithm options.

% First, this are all parameters required by Myosim. We will declare the
% search space parameters and also any other data that is not part of the
% optimisation will go into userData field.

objFun = @runMyosim;

searchSpace = struct('Fibres', struct(), ...
                     'MUAP', struct(), ...
                     'Offset', struct(), ...
                     'CV', struct());
                 
searchSpace.Fibres.min = 100;
searchSpace.Fibres.max = 400;
searchSpace.Fibres.step = 20;

searchSpace.MUAP.min = 50;
searchSpace.MUAP.max = 200;
searchSpace.MUAP.step = 10;

searchSpace.Offset.min = 1;
searchSpace.Offset.max = 15;
searchSpace.Offset.step = 0.25;

searchSpace.CV.min = 3;
searchSpace.CV.max = 6;
searchSpace.CV.step = 0.2;

% GA options
options.population.size = 100;
options.population.searchSpace = searchSpace;                                    

options.fitness.scale = 4.8e-3;

options.selection.method = 'StochasticUniversal';
options.selection.methodValue = [];

% options.selection.method = 'Tournament';
% options.selection.methodValue = 3;

% options.selection.method = 'FitnessProportionate';
% options.selection.methodValue = [];

options.crossover.rate = 0.1;

options.crossover.method = 'Uniform';
options.crossover.methodValue = 0.5;

% options.crossover.method = 'K-point';
% options.crossover.methodValue = 1;

options.mutation.rate = 0.05;

options.termination.maximumGenerations = 5;
options.termination.tolerance = 4.8e-3;

options.misc.shuffleRNG = true;
options.misc.verbose = "All";
 
% Save stuff misc stuff in userData that is required by various functions.
options.userData.parameters = initMyosimParameters;
options.userData.threshold = 0.975;
options.userData.fs = 1000; %sampling rate
options.userData.timeperiod = 1; %Time period in secs
options.userData.resultsDir = resultsDir;

% Reads the records file
recordfilename = 'emgSigsFs1000.mat';
recordFile = load(sprintf('%s%s%s', recordDir, filesep, recordfilename));
options.userData.originFileName = recordfilename;

% Start the loop.
for i = 1:22
    options.userData.count= i;
    options.userData.data = recordFile.sig(:,i);
    optimParams = geneticAlgorithm(objFun, options);
    
    %Filters out the best signals and save them in a new folder
    Records_Dir = 'matchedSigs';
    file = dir(sprintf('%s%s%d_GA_*.mat', Records_Dir, filesep, i));
    
    if (~isempty(file)) % checks if a match exists
        fitscore = 0;
        for j=1:length(file)
            Record_File = load(sprintf('%s%s%s', Records_Dir, filesep, file(j).name));
            
            if (Record_File.FitScore > fitscore)
                fitscore = Record_File.FitScore;
                bestscore = j;
            end
        end
        
        Best_Results = 'BestSigs';
        bestfile = sprintf('%s%s%s', Records_Dir, filesep, file(bestscore).name);
        copyfile (bestfile, Best_Results); %copys the best signal to the new folder
    end
end
