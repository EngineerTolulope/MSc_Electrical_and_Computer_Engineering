clear;
clc;

Ts = 1e-5; 
Vdc = 350; 
Rl = 50; 
f = 60; 
Efficiency = 0.80; 
N = 5; 
THDi=0.05
Pload = Vdc^2/Rl; 
Idc = Vdc/Rl; 
Vm = (pi*Vdc)/(3*sqrt(3)); %Phase peak voltage
XL_iXC_i = (1/N^2)*(THDi+1);



Pin = Pload/Efficiency; 

old_PF = 0.707; %lag
old_QF = Pin*tan(acos(old_PF)); %in VAR

new_PF = 0.96; %lag
new_Q = Pin*tan(acos(new_PF)); %in VAR

DeltaQ = old_QF-new_Q; %in VAR
XC_i= (Vm/sqrt(2))^2/DeltaQ; %in Ohms

C_i = 1/(2*pi*f*XC_i); %in Farads


L_i = (XL_iXC_i)/(C_i*(2*pi*f)^2); %in Henrys

fprintf('Input filter components\n');
fprintf('Ci = %f Farads\n',C_i);
fprintf('Li = %f Henrys\n',L_i);

Vo_n6 = 0.9549*Vm*2/35; %in Volts
Io_n6_peak = Vo_n6/Rl; %in Amperes
Delta_Vo = 5;
Co = (100*Io_n6_peak)/(sqrt(2)*Delta_Vo*Vdc*12*pi*f); %in Farads

fprintf('\n');
fprintf('Output filter Components\n');
fprintf('Co = %f Farads\n',Co);










