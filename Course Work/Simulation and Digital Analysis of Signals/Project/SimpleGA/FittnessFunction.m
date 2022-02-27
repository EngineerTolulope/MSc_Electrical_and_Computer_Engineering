

function [fitt, pass] = FittnessFunction(params)
fitt = params(1)^2 - params(2)^2 + params(3)^2; %function x^2-y^2+z^2

end