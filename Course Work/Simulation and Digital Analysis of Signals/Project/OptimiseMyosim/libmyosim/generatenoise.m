% generatenoise.m
% Author: Shriram Tallam Puranam Raghu
% Student ID: 3521860
% Date Created: 2016-01-31
% Date last modified: 2017-04-17
% Description: This function generates noise with the given parameters. The
% types of noise generated include: 1/f noise, white noise and power line
% interference. The input arguments are as follows:
% Structure containing information about the different noise.
% The fields include: 'pli_vals', 'fcp', & 'p0'.
% fs = Sampling frequency
% sz = size of data segment. It is an array consisting of the dimensions of
% the desired matrix. Each column is considered as a signal.


function n_t=generatenoise(noiseparams,fs,sz)
if(fs<=0||isempty(sz)||~all(isfield(noiseparams,{'p0','fcp','pli_vals'})))
    error('Invalid Parameters. Please check your parameters.');
end
f=((0:sz(1)-1)./sz(1))'.*fs;
f(f>fs/2)=f(f>fs/2)-fs;
whtnoise=sqrt(noiseparams.p0*fs/2).*randn(sz);
noisespec=fft(whtnoise);

f(f>=noiseparams.fcp)=noiseparams.fcp;
f(f<=-noiseparams.fcp)=-noiseparams.fcp;

F_F=1./sqrt(abs(f));
F_F(f==0)=0;

noisespec=bsxfun(@times,noisespec,F_F);

noise=real(ifft(noisespec));

t=(0:1/fs:sz(1)/fs-1/fs)';
plinoise=0;
for ii=1:length(noiseparams.pli_vals)
    if(ii*60>fs/2)
        break        
    else        
    %Add Random phase.
    plinoise=plinoise+sqrt(noiseparams.pli_vals(ii))*sin(2*pi*60*ii*t+2*pi*rand);
    end
end     
n_t=bsxfun(@plus,noise,plinoise);  
