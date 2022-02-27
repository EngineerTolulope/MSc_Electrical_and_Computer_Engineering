% getnoiseparams.m
% Author: Shriram Tallam Puranam Raghu
% Student ID: 3521860
% Date Created: 2017-03-27
% Date last modified: 2017-04-17
% Description: Get noise parameters to use in conjuntion with
% generatenoise.m. fcp must be manually entered. 


function noiseparams=getnoiseparams(sig,fs)

sig=bsxfun(@minus,sig,mean(sig));
[Xn,f]=pwelch(sig,fs,0,fs,fs);
H=figure;loglog(f,Xn,'LineWidth',1.3);
xlabel('f');ylabel('V^2/Hz');title('PSD');
nparams.fcp=input(sprintf('\nEnter approximate fcp by visually inspecting the plot shown. Numeric only: \n'));
close(H);
if(nparams.fcp>0)
    F_F=1./f;
    F_F(1)=0;
    F_F(f>=nparams.fcp)=1./nparams.fcp;    
else
    F_F=ones(length(f),1);
end
%Ignore fs/2 and 0 component.
nparams.p0=mean(Xn(2:end-1)./F_F(2:end-1));
nparams.pli_vals=Xn(f==60|f==120|f==180|f==240|f==300);
noiseparams=nparams;
