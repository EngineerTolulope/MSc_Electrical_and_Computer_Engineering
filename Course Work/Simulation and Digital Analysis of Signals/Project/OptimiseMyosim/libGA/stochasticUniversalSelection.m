% Description: Select individuals using stochastic universal sampling.
% Author: Shriram Raghu
% Inputs:
%   fitness: fitness of each member.
% Outputs:
%   Indices of selected indiviuals.

function selectedIndices = stochasticUniversalSelection(fitness)

probabilityOfSelection = fitness./sum(fitness);
cumulativeProbability = cumsum(probabilityOfSelection);

populationSize = length(fitness);

pointerStart = rand/populationSize;
pointerLocations = pointerStart + (0:populationSize - 1) * pointerStart;

selectedIndices = zeros(populationSize, 1);

for individual = 1:populationSize    
    selectedIndices(individual) = ...
        find(pointerLocations(individual) <= cumulativeProbability, ...
            1, 'first');   
end
