% Description: Mutate random genome from the population.
% Author: Shriram Raghu
% Inputs:
%   population: current population
%   options: options structure
% Outputs:
%   mutated population


function mutatedPopulation = mutation(population, options)

popOptions = options.population;

searchSpace = popOptions.searchSpace;
optimParams = fieldnames(searchSpace);

randomValues = rand(size(population));

[memNum, varNum] = find(randomValues <= options.mutation.rate);

% We don't have to iterate through every element as it is. A better way
% would be to subset based on the unique variables and then loop through
% them
uniqueSelVars = unique(varNum);

for param = 1:length(uniqueSelVars)
    iVarNum = uniqueSelVars(param);
    curMemSubset = memNum(varNum == iVarNum);
    lenSubset = length(curMemSubset);
    
    if(lenSubset > 0) 
        paramOptions = searchSpace.(optimParams{iVarNum});
        numSteps = ...
            fix((paramOptions.max - paramOptions.min)./paramOptions.step);
        
        population{curMemSubset, iVarNum} = paramOptions.min + ...
            randi([0, numSteps], lenSubset, 1).*...
                paramOptions.step;
    end
end

mutatedPopulation = population;
