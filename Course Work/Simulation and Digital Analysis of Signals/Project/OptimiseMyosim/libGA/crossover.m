% Description: Perform crossover on individuals from a population
%   based on given options.
% Author: Shriram Raghu
% Inputs:
%   population: current population.
%   options: option structure.
% Outputs:
%   New population of the same size selected with the given options.

function population = crossover(population, options)

[numMems, numVars] = size(population);

if(numMems > 1)
    % There is no point performing a crossover if there is just one
    % parameter being optimised. So if there is such a case, just return
    % the same array as input.
    if(strcmp(options.crossover.method, 'K-point'))
        crossoverIndices = kPointCrossover([numMems, numVars], options);
    elseif(strcmp(options.crossover.method, 'Uniform'))
        crossoverIndices = uniformCrossover([numMems, numVars], options);
    else
        error('Unknown option.');
    end
    % Tables do not support linear indexing, so create an intermediate
    % array to speed up the process.
    
    mixedPopulation = table2array(population);
    mixedPopulation = mixedPopulation(crossoverIndices);
    population.Variables = mixedPopulation;
end

