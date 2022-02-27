% Description: Select individuals using fitness proportionate selection
%   (a.k.a Roulette Wheel selection). 
% Author: Shriram Raghu
% Inputs:
%   fitness: fitness score of each member.
% Outputs:
%   Indices of selected indiviuals.

function selectedIndices = fitnessProportionateSelection(fitness)

probabilityOfSelection = fitness./sum(fitness);
cumulativeProbability = cumsum(probabilityOfSelection);

populationSize = length(fitness);
selectedIndices = zeros(populationSize, 1);

for individual = 1:populationSize
    randomNumber = rand;
    selectedIndices(individual) = ...
        find(randomNumber <= cumulativeProbability, 1, 'first');
end
