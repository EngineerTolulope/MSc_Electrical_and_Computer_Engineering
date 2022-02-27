% Description: Optimise a given objective function using genetic algorithm.
%   Optimisation here is defined to be minimisation of the
%   objective function.
% Author: Shriram Raghu
% Inputs:
%   objectiveFun: a handle to the objective function. It should only take
%       two arguments, the first argument is a table of values
%       corresponding to the parameters being optimised and return a single
%       value. This value is optimised to 0. Typically, mean absolute error
%       or mean square error is used. The return value should be strictly
%       positive.
%       The second argument: the 'userData' field from the options
%       structure (defined below).
%   options: structure containing various options in sub-structures.
%       Required fields are:
%           population: structure consisting of fields:
%               size: size of population pool.
%           searchSpace: a structure with field names corresponding to the
%               parameter and the corresponding value containing a
%               structure with the fields: min, max, and step. The search
%               space is created from these values and randomly chosen
%               during the initialisation phase.
%           fitness: structure with the fields:
%               scale: constant to use for fitness score computation
%               (scale./(scale + evaluation)). Typically scale = 1;
%           selection: structure consisting of fields:
%               method: 'FitnessProportionate', 'Tournament' or
%                   'StochasticUniversal'.
%               methodValue: value corresponding to the selected selection
%                   method.
%                   'FitnessProportionate': [].
%                   'StochasticUniversal': [].
%                   'Tournament': number of indiviuals - usually 2.
%           crossover: structure consisting of fields:
%               rate: rate of crossover between [0, 1) - usually [0.6, 0.9].
%               method: 'K-point' or 'Uniform'.
%               methodValue: value corresponding to the selected crossover
%                   method.
%                   K-point: an integer value between [1, N), usually 1 or 2.
%                   uniform: value between [0, 1), usually 0.5.
%           mutation: structure consisting of fields:
%               rate: rate of mutation between [0, 1) - usually < 0.05.
%           termination: structure consisting of fields:
%               maximumGenerations: maximum number of generations/
%                   iterations to try before giving up.
%                   Has to be strictly positive value.
%                   Set value to Inf if you want to keep it running forever
%                   until the specified tolerance is reached
%                   (or until MATLAB crashes, which is more likely).
%                   The 'best' value from all the iterations is returned.
%               tolerance: specify an acceptable value of the objective
%                   function that, if reached, will stop the GA and return
%                   the results. In a strict sense, this is 0,
%                   but practically, depending on the application,
%                   a small enough value will suffice.
%           misc: structure consisting of fields:
%               shuffleRNG: setting this value to 'true' will shuffle the
%                   RNG before the start of the GA.
%               verbose: one of 'All', 'Sparse', or 'None'. 'All' will
%               print out all information, including current member being
%               evaluated, output of the evaluation, etc. 'Sparse' will
%               only print steps and the current generation. 'None' will
%               not print anything.
%           userData: can be used to store data that is passed to the
%               objective function.
%
%   Outputs:
%       optimumParameters: best parameters found. Multiple are returned
% For an understanding of GA, I recommend the following papers:
%   "GENETIC ALGORITHMS", Kumara Sastry, David Goldberg,
%       University of Illinois, USA
%   "Genetic Algorithm", Tom V. Mathew, Department of Civil Engineering,
%       Indian Institute of Technology Bombay
%   "Genetic Algorithms: Theory and Applications", Ulrich Bodenhofer
% Selection methods:
%   "Comparative Review of Selection Techniques in Genetic Algorithm",
%       A Shukla

function optimumParameters = geneticAlgorithm(objectiveFun, options)

% Perform some input checks.
% Objective function checks
if(~isa(objectiveFun, 'function_handle'))
    error('Objective function must be a function handle.');
end

% Options checks
requiredFields = {'population',...
    'selection',...
    'crossover', ...
    'mutation',...
    'termination',...
    'misc', ...
    'userData'};

if(~isstruct(options) || ~all(isfield(options, requiredFields)))
    error('Options has to be a structure with the specified fields.')
end

if(options.misc.shuffleRNG)
    rng('shuffle');
end

% Now that some input checks are done, proceed to the genetic algorithm.

if(strcmp(options.misc.verbose, "All"))
    fprintf("\nInitialising population of size %d.", options.population.size);
end

population = initialisePopulation(options);

currentGeneration = 1;

totalTime = tic;

while (currentGeneration <= options.termination.maximumGenerations)
    
    if(any(strcmp(options.misc.verbose, ["All"; "Sparse"])))
        fprintf("\nStarting generation %d.", currentGeneration);
    end
    
    if(any(strcmp(options.misc.verbose, ["All"; "Sparse"])))
        fprintf("\nEvaluating current population.");
    end
    
    evaluation = evaluatePopulation(objectiveFun, population, options);
    
    % Find the current best individual(s) in the pool to keep track of the
    % best so far.
    
    if(currentGeneration == 1)
        [curBestEval, curBestMem] = min(evaluation);
        curBestParam = population(curBestMem, :);
    else
        prevBestEval = curBestEval;
        prevBestMem = curBestMem;
        prevBestParam = curBestParam;
        
        [curBestEval, curBestMem] = min(evaluation);
        
        if (curBestEval < prevBestEval)
            curBestParam = population(curBestMem, :);
        else
            curBestMem = prevBestMem;
            curBestEval = prevBestEval;
            curBestParam = prevBestParam;
        end
    end
    
    % Check for threshold crieteria
    
    if(any(evaluation <= options.termination.tolerance))
        
        population.Evaluation = evaluation;
        
        bestMembers = evaluation <= options.termination.tolerance;
        
        optimumParameters = population(bestMembers, :);
        
        if(any(strcmp(options.misc.verbose, ["All"; "Sparse"])))
            % The best individual will also be the one with lowest evaluation.
            fprintf('\nTolerance criteria reached at generation %d.\n', ...
                currentGeneration);
        end
        
        if(strcmp(options.misc.verbose, "All"))
            fprintf('\nOptimised parameters:\n');
            disp(optimumParameters);
        end
        
        if(any(strcmp(options.misc.verbose, ["All"; "Sparse"])))
            fprintf("\nTotal optimisation time: %g sec.", toc(totalTime));
        end
        
        fprintf("\n");
        
        return
    end
    
    if(strcmp(options.misc.verbose, "All"))
        fprintf("\nCurrent best parameters with evaluation of %g: \n.", ...
            curBestEval);
        disp(curBestParam)
    end
    
    if(any(strcmp(options.misc.verbose, ["All"; "Sparse"])))
        fprintf("\nComputing fitness score.");
    end
    
    fitness = computeFitness(evaluation, options);
        
    if(any(strcmp(options.misc.verbose, ["All"; "Sparse"])))
        fprintf("\nSelecting best members of population.");
    end
    
    population = selection(population, fitness, options);
    
    if(any(strcmp(options.misc.verbose, ["All"; "Sparse"])))
        fprintf("\nPerforming crossover between members of the population.");
    end
    
    population = crossover(population, options);
    
    if(any(strcmp(options.misc.verbose, ["All"; "Sparse"])))
        fprintf("\nMutating random parameters.");
    end
    
    population = mutation(population, options);
    
    if(any(strcmp(options.misc.verbose, ["All"; "Sparse"])))
        fprintf("\nReached end of generation.");
    end
    
    currentGeneration = currentGeneration + 1;
end

fprintf('\nMaximum generations reached.');
fprintf('\nObjective function value = %g.\n', ...
    curBestEval);

curBestParam.Evaluation = ones(size(curBestParam, 1)) .* curBestEval;
optimumParameters = curBestParam;
