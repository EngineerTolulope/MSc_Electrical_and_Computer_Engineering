% getZC.m
% Author: Shriram Tallam Puranam Raghu
% Description: Get number of zero crossings in a signal. Original code by
% Adrian Chan, just pulled function out of loop.
% Inputs: Signal
%         Dead Zone value

function out=getZC(in, deadzone)

in = (in > deadzone) - (in < -deadzone);
a=1;
b=exp(-(1:size(in,1)/2))';
z = filter(b,a,in);
z = (z > 0) - (z < -0);
dz = diff(z);
out = (sum(abs(dz)==2));