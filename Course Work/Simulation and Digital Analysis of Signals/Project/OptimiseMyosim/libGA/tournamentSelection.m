% Description: Select individuals using tournament sampling.
% Author: Shriram Raghu
% Inputs:
%   fitness: fitness of each member.
%   tournamentSize: number of individuals in the tournament
% Outputs:
%   Indices of selected indiviuals.

function selectedIndices = tournamentSelection(fitness, tournamentSize)

% It is possible to incorporate some randomness in the tournament, 
% but we will ignore it for the time being.

populationSize = length(fitness);
selectedIndices = zeros(populationSize, 1);

for individual = 1:length(fitness)
    chosenIndividuals = randi(populationSize, tournamentSize, 1);
    [~, bestIndividual] = max(fitness(chosenIndividuals));
    selectedIndices(individual) = chosenIndividuals(bestIndividual);
end
