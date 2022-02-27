% getMAV.m
% Author: Shriram Tallam Puranam Raghu
% Description: Get mean absolute value of a signal. 
% Original code by Adrian Chan, just pulled function out of loop.
% Inputs: Signal

function out=getMAV(in)

out=mean(abs(in));