%% constant
t = 0:1*10^-9:500*10^-9;
f = 30*10^6;
w = 2*pi*f;
ES = sin(w.*t);
L = 10;
R = 100;
func_current @(i) = -R/L.*i + ES/L
plot(t,ES);

for n = 1:500
   [t,y]=ode45(@vdp1,[0 20],[2 0]); 
end