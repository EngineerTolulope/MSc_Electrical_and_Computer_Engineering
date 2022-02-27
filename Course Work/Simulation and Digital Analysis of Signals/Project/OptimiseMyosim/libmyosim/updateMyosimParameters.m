% Update the myosim parameters based on the given member from population.

function parameters = updateMyosimParameters(parameters, member)
% For depth, we are assuming a fixed region that will contain all MUs. We
% will just adjust the 'offset' of this region based on the GA member.
% This region is assumed to be an ellipse.
regionCentre = [0, 13];
minAxisLen = 16;
majAxisLen = 40;

% Assume all MUs have same number of fibres to make things easy.
parameters.create.current.NSFAP_min = member.Fibres;
parameters.create.current.NSFAP_max = member.Fibres;

parameters.create.current.MMUAP = member.MUAP;

offsetValue = member.Offset;

parameters.create.current.depth_min = regionCentre(2) - ...
                                        (minAxisLen / 2) + offsetValue;
parameters.create.current.depth_init = regionCentre(2) + ...
                                        (minAxisLen / 2) + offsetValue;
parameters.create.current.align_min = regionCentre(1) - (majAxisLen / 2);
parameters.create.current.align_init = regionCentre(1) + (majAxisLen / 2);
parameters.create.current.cv_init = member.CV;

end
