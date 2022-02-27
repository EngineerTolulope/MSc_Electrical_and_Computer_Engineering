% quantise.m
% Author: Shriram Tallam Puranam Raghu
% Student ID: 3521860
% Date created: 30 May 2016
% Date modified: 31 May 2016
% Description: Quantise a signal using uniform quantisation.
% Inputs: 
% 1) Signal to be quantised. Can be a matrix where each column is a
% signal.
% 2) Number of bits.
% 3) Maximum value of the quantised output. All values greater than this
% are clipped.
% 4) Minimum value of the quantised output. All values smaller than this
% are clipped.


function qsig=quantise(sig,numbits,maxval,minval)
if((numbits<=0)||(maxval<=minval)||isempty(sig))
    qsig=zeros(size(sig));
    return;   
end
numlevel=2^numbits;
stepsize=(maxval-minval)/numlevel;
%Clip output to max and min values.
sig(sig<minval)=minval;
%Subtract eps to avoid issues while flooring;
sig(sig>=maxval)=maxval-eps;
sig(sig==max(sig(:)))=max(sig(:))-eps;
%Mid tread quantization formula.
qsig_temp=stepsize.*(floor(sig/stepsize+0.5));
qsig=qsig_temp;
  