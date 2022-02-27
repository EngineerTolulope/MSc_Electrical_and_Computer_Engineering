clear
clc


load mes_1.mat
emg = mes.MES.sig;
emg = emg - mean(emg);

fs = 1000; T = 5;
dt = 1/fs; N=T/dt; df = 1/T;
t = 0:dt:T-dt;
f = 0:df:fs-df;

EMG = 2*(abs(fft(emg))/N).^2;

Pt = mean(emg.^2);
Pf = sum(EMG(f<fs/2));


[PSw, fw] = pwelch(emg, rectwin(length(emg)/10), 0, length(emg)/10, fs);
Pw = sum(PSw);

figure(1)
plot(t, emg)

figure(2)
plot(f(f<fs/2), EMG(f<fs/2))


figure(3)
plot(fw(fw<fs/2), PSw(fw<fs/2))

disp([Pt Pf Pw])
