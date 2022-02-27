% Description: Perform crossover using k-point crossover.
% Author: Shriram Raghu
% Inputs:
%   populationSize: 2 element array that is size(population).
%   options: crossover options structure.
% Outputs:
%   indices of mixed population.


function crossoverIndices = kPointCrossover(populationSize, options)
% Select member to crossover from the population.

numCrossPoints = options.crossover.methodValue;

populationIndices = reshape(1:prod(populationSize), populationSize(1), ...
    populationSize(2));

randomValues = rand(populationSize(1), 1);

selectedMembers = find(randomValues <= options.crossover.rate);

% Each selected member is a parent and 2 parents produce an offspring.
numParents = length(selectedMembers);

% We need atleast 2 parents to crossover and the total has to be a multiple 
% of 2.

if(numParents >= 2)   
    
    % We need to pick random parents from the pool. To make it easy, I am
    % going to shuffle the population and then select adjacent parents.
    selectedMembers = selectedMembers(randperm(numParents));
    
    for iParent = 1:floor(numParents / 2)
        % Select random split points based on given K.
        splitPoints = ...
            sort(randperm(populationSize(2) - 1, numCrossPoints));
        
        % Think of individuals as containing sections of parameters.
        selectedSection = 1:populationSize(2);
        
        % The first section is always going to be preserved.
        selectedSection(1:splitPoints(1)) = [];
        
        for splits = 1:length(splitPoints)
            % Every other section is always preserved, so don't swap.
            if(mod(splits, 2) == 1)
                continue                
            else
                if(splits+1 > length(splitPoints))
                    selectedSection(splitPoints(splits) : end) = [];
                else
                    selectedSection(splitPoints(splits) : ...
                        splitPoints(splits + 1)) = [];
                end
            end
        end
        
        temp = populationIndices(selectedMembers(2*iParent - 1), ...
            selectedSection);
        populationIndices(selectedMembers(2*iParent - 1), ...
            selectedSection) = ...
                populationIndices(selectedMembers(2*iParent), ...
                    selectedSection);
        populationIndices(selectedMembers(2*iParent), selectedSection) = ...
            temp;
    end
end

crossoverIndices = populationIndices;
