%% Part 1, case A
% Graphical observation.  This method was tedious and not efficient. It
% used the programmer's ability to judge the roots and label them one by
% one.  Arrows were placed where the graph reached the x-axis and the
% points were found using a tool from MATLAB. It was not as accurate as it
% could be.
clear; clc;
%Set parameters
Zo = 50;
Z1 = 10;
beta1 = 0:(pi/16):(4*pi);

%values to save
Zin = zeros(1,65);
ZinR = Zin; %real values - set to 0
ZinI = Zin; %imaginary values - set to 0
root = Zin; %root values
%function and graphs
for ii = 1:1:65;
    %1i is a slightly faster version of imaginary j or i
    Zin(ii) = [Zo*((Z1 + 1i*Zo*tan(beta1(ii)))/(Zo+1i*Z1*tan(beta1(ii))))];
    ZinR(ii) = [real(Zin(ii))];
    ZinI(ii) = [imag(Zin(ii))];
    if (ZinI(ii)==0)
        root(ii) = beta1(ii);
        disp(['The roots are at beta1 = ' num2str(root(ii))]);
    end
end

hold on
plot(beta1, ZinR,'r-');
plot(beta1, ZinI, 'b');
hold off

axis([0 13 -150 250]);
xlabel('Electrical length of line (Beta1) (radians)');
ylabel('Input impedence (Zin) (ohms)');
title('Part 1 Case a- Graphical solution');

%with an arrow, students should indicate the zero values which are at:
%x = 1.571, 3.142, 4.712, 6.283, 7.854, 9.425, 11, 12.57
% labels should also show the Y - values at which will be very close to
% zero. Students shoud also list out the Real parts when Imag = 0