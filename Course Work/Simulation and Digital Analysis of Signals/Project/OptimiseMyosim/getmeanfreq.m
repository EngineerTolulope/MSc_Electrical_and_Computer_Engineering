% getmeanfreq.m
% Author: Shriram Tallam Puranam Raghu
% Description: Get mean frequency of signal. 
% Inputs: signal
%         sampling frequency
% Optional arguments: window, overlap, nfft.


function mf=getmeanfreq(sig,fs,varargin)

narginchk(2,5);

winlen=fs;
nfft=fs;
Over_Lap=0;

if(nargin>2)
    winlen=varargin{1};
    nfft=winlen;
    if(nargin>3)
        Over_Lap=varargin{2};
        if(nargin>4)
            nfft=varargin{3};
        end
    end
end

[Pxx,f] = pwelch(sig,winlen,Over_Lap,nfft,fs);

P=bsxfun(@times,Pxx,f);

mf=sum(P)./sum(Pxx);