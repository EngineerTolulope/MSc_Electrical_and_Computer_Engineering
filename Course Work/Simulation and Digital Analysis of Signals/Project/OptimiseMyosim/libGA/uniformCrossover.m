% Description: Perform crossover using uniform crossover algorithm.
% Author: Shriram Raghu
% Inputs:
%   populationSize: 2 element array that is size(population).
%   options: crossover options structure.
% Outputs:
%   indices of mixed population.


function crossoverIndices = uniformCrossover(populationSize, options)

% Select parents to crossover from the population.

populationIndices = reshape(1:prod(populationSize), populationSize(1), ...
    populationSize(2));

randomValues = rand(populationSize(1), 1);

selectedChromosomes = find(randomValues <= options.crossover.rate);

% Each selected chromosome is a parent and 2 parents produce an offspring.
numParents = length(selectedChromosomes);

% We need atleast 2 parents to crossover and it has to be a multiple 
% of 2.
if(numParents >= 2)    
    % We need to pick random parents from the pool. To make it easy, I am
    % going to shuffle the population and then select adjacent parents.
    selectedChromosomes = selectedChromosomes(randperm(numParents));
    
    for iParent = 1:floor(numParents/2)
        % Select random parameters to be swapped
        randomValues = rand(populationSize(2), 1);
        selectedGenome = find(randomValues <= options.crossover.methodValue);
        temp = populationIndices(selectedChromosomes(2*iParent - 1), ...
            selectedGenome);
        populationIndices(selectedChromosomes(2*iParent - 1), ...
            selectedGenome) = ...
                populationIndices(selectedChromosomes(2*iParent), ...
                selectedGenome);
        populationIndices(selectedChromosomes(2*iParent), ...
            selectedGenome) = temp;
    end
end

crossoverIndices = populationIndices;
