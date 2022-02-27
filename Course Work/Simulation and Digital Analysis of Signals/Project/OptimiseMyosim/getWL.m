% getWL.m
% Author: Shriram Tallam Puranam Raghu
% Description: Get wavelength of a signal. Original code by
% Adrian Chan, just pulled function out of loop.
% Inputs: Signal

function out=getWL(in)

out=sum(abs(diff(in)));