%Constants
f=10e9:1e6:11e9;
fb = 10.5e9;
delf=35e6;
amp=1;
bg=amp*(1+4*((f-fb)./delf).^2).^-1;

st(1) = 0; %Array of Standard Deviation Values
er(1) = 0; %Array of Error Values
j = 2; %Index of the Array


%Creates errors in Brillouin values with varying standard devations
for i = 0.1:0.01:1
    lnoise=randn(size(f));
    measured= i*lnoise + bg;
    
    brillouin2=@(x) sum((measured-x(1)*(1+4*((f-x(2)*1e10)./(x(3)*1e7)).^2).^-1).^2);
    [x,fval,exitflag,output]=fminsearch(brillouin2,[1,1.05,3.5])

    st(j) = i;
    er(j) = abs(1.05 - x(2));
    j = j + 1;
end

%Plots Error v.s. Standard Deviation
%plot(st,er,'o',st,guide)
plot(st,er,'o')
title(' Error in Brillouin Frequency v.s. Std Dev of Noise Level')
xlabel('Std Dev of Noise')
ylabel('Error in Brillouin Frequency')