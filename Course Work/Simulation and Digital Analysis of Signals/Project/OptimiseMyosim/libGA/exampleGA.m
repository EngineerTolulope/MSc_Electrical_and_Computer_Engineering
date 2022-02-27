clc;
clearvars;
close all;

objFun = @(c, v) abs(c.X.^2 + c.Y.^2 + c.Z.^2);

searchSpace = struct('X', struct(), ...
                     'Y', struct(), ...
                     'Z', struct());
                 
searchSpace.X.min = -100;
searchSpace.X.max = 100;
searchSpace.X.step = 10;

searchSpace.Y.min = -10;
searchSpace.Y.max = 10;
searchSpace.Y.step = 1;

searchSpace.Z.min = -1;
searchSpace.Z.max = 1;
searchSpace.Z.step = 0.1;

options.population.size = 100;
options.population.searchSpace = searchSpace;                                    

options.fitness.scale = 1;

% options.selection.method = 'StochasticUniversal';
% options.selection.methodValue = [];

% options.selection.method = 'Tournament';
% options.selection.methodValue = 3;

options.selection.method = 'FitnessProportionate';
options.selection.methodValue = [];

options.crossover.rate = 0.6;

options.crossover.method = 'Uniform';
options.crossover.methodValue = 0.5;

% options.crossover.method = 'K-point';
% options.crossover.methodValue = 1;

options.mutation.rate = 0.05;

options.termination.maximumGenerations = 100;
options.termination.tolerance = 0.01;

options.misc.shuffleRNG = true;
options.misc.verbose = "Sparse";

options.userData = [];

optParams = geneticAlgorithm(objFun, options);

