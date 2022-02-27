clear
clc

T=5; fs=100;
dt = 1/fs; N=T/dt; df = 1/T;
t = 0:dt:T-dt;
f = 0:df:fs-df;

A = 1; f0=10;
x = A*cos(2*pi*f0*t);
X = 2*(abs(fft(x))/N).^2;



figure(1)
plot(t, x)

figure(2)
plot(f(f<fs/2), X(f<fs/2))