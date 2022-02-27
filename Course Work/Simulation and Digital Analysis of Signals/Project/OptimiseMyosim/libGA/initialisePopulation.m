% Description: Create a random initial population with given parameters.
% Author: Shriram Raghu
% Inputs:
%   population: population options.
% Outputs:
%   population: uniform random sampled population in a table.

function population = initialisePopulation(options)

popOptions = options.population;

searchSpace = popOptions.searchSpace;
optimParams = fieldnames(searchSpace);

rowNames = strsplit(sprintf('Member-%d ', 1:popOptions.size));
rowNames = rowNames(1:end - 1);

population = array2table(...
    zeros(popOptions.size, length(optimParams)), ...
    'RowNames', rowNames, ...
    'VariableNames', optimParams);

% Instead of creating multiple arrays, I am computing them as needed using
% the colon operator formula. See documentation for 'colon':
% x = j:i:k creates a regularly-spaced vector x using i as the increment
% between elements. The vector elements are roughly equal to
% [j,j+i,j+2*i,...,j+m*i] where m = fix((k-j)/i).

for numVar = 1:length(optimParams)
    paramOptions = searchSpace.(optimParams{numVar});
    numSteps = fix((paramOptions.max - paramOptions.min)./paramOptions.step);
    population{:, numVar} = paramOptions.min + ...
        randi([0, numSteps], popOptions.size, 1).*...
            paramOptions.step;
end
