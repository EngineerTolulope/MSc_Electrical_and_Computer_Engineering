clc
clear all
Vo=90;
Vs=40;
D=inv(Vs/Vo+1)
F=200e3;
T=1/F;

Rl=27
LB=(1-D)*Rl*T*inv(2)
CB=D*T*inv(2*Rl)
L=15*LB
