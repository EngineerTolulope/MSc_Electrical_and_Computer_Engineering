% Description: Evaluate the population with the given objective function.
% Author: Shriram Raghu
% Inputs:
%   objFun: Handle to the objective function. 
%       The function has to take in an array and return a single value.
%   population: Population of possible solutions.
%   options: The main options structure
% Outputs:
%   Objective function results.

function objResults = evaluatePopulation(objFun, population, options)

objResults = zeros(options.population.size, 1);

popEvalTime = tic;

for member = 1:options.population.size
    if(strcmp(options.misc.verbose, "All"))
        fprintf("\nEvaluating member number %d with the parameters:\n", member);
        disp(population(member, :))
    end
    
    memEvalTime = tic;
    objResults(member) = objFun(population(member, :), options.userData);
    
    if(strcmp(options.misc.verbose, "All"))
        fprintf("\nEvaluation result: %g, time to evaluate: %g sec.", ...
            objResults(member), toc(memEvalTime));
    end
    
end

if(any(strcmp(options.misc.verbose, ["All"; "Sparse"])))
    fprintf("\nTotal evalation time for population: %g sec.", ...
        toc(popEvalTime));
end
