% Description: Select individuals from a population based on given options.
% Author: Shriram Raghu
% Inputs:
%   population: current population.
%   fitness: fitness score of each member.
%   options: option structure.
% Outputs:
%   New population of the same size selected with the given options.

function selectedPopulation = selection(population, fitness, options)

if(strcmp(options.selection.method, 'FitnessProportionate'))
    selectedIndices = fitnessProportionateSelection(fitness);
elseif(strcmp(options.selection.method, 'Tournament'))
    selectedIndices = tournamentSelection(fitness, options.selection.methodValue);
elseif(strcmp(options.selection.method, 'StochasticUniversal'))
    selectedIndices = stochasticUniversalSelection(fitness);
else
    error('Unknown option.');
end

% Perform linear indexing on the data matrix as tables do not support it.
intermediatePopulation = population.Variables;
intermediatePopulation = intermediatePopulation(selectedIndices, :);
% Now return the values in a new variable.
selectedPopulation = population;
selectedPopulation.Variables = intermediatePopulation;
