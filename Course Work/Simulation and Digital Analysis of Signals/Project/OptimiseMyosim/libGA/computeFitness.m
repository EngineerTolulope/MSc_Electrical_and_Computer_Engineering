% Description: Compute fitness score of each individual.
%   Basically a score to compute if an individual is good enough. For
%   minimisation problems, it is pretty much the inverse of the output of
%   the objective function.
% Author: Shriram Raghu
% Inputs:
%   evaluation: Compute fitness score using the objective function output.
%   options: options structure;
% Outputs:
%   fitness: Fitness score.


function fitness = computeFitness(evaluation, options)

scaleParam = options.fitness.scale;

fitness = scaleParam./(scaleParam + evaluation);
