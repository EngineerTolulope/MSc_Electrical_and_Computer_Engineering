% Lab 2 - partial solutions

%% Part 1, case A
% Graphical observation.  This method was tedious and not efficient. It
% used the programmer's ability to judge the roots and label them one by
% one.  Arrows were placed where the graph reached the x-axis and the
% points were found using a tool from MATLAB. It was not as accurate as it
% could be.
clear; clc; clf;
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

%% Part 1 Case B - Bisection
%This method has roots found by code of bisection method. It was more
%accurate than graphically

clear; clc; clf;
%Set parameters
Z0 = 50;
Z1 = 10;
beta1 = 0:(pi/16):(4*pi);
n=1;
ma = 1;
mb = 2;
nmax = 110;
Zin = zeros(1,length(beta1));

f=@(x) Z0*((Z1 + 1i*Z0*tan(x))/(Z0 + 1i*Z1*tan(x)));

for ii=1:1:length(beta1)
    Zin(ii)=Z0*((Z1+1i*Z0*tan(beta1(ii)))/(Z0 + 1i*Z1*tan(beta1(ii))));
end

for ii = 0:1:4*pi
    ma = ii+ii; %advance starting point
    n
    while n<nmax
        mid = (mb+ma)/2;
        fc = imag(f(mid))
        fa=imag(f(ma));
        fb=imag(f(mb));
        if ((fc ==0) || (abs(fc) < 0.01))
            disp(['Root found'])
            break;
        end
        n = n+1;
        if sign(fc)==sign(fa)
            ma = mid;
        else
            mb = mid;
        end
    end
    hold on
    plot(mid,imag(f(mid)),'o') %this will indicate where on the graph the roots are located
end

plot(beta1,real(Zin),'k')
plot(beta1,imag(Zin),'r')
xlabel('Electrical length of line (Beta1) (radians)');
ylabel('Input impedence (Zin) (ohms)');
title ('Part 1 Case b - Bisection solution');
%It is observed that the Bisection method has the same roots as the
%graphical method. This was, however, a more efficient way to solve the
%problem since it took less time and effort, as well as being coded rather
%than hard coded.
%(also make sure to list the real parts when imaginary parts are = 0)
%%Q3 - Part 1 case c - fzero

%% part 1 - Case C -
%use fzero function
%This method uses open methods of root finding. It uses one initial guess
%of the location of the root rather than two points for the beginning and
%the end
clear; clc; clf;
Z0 = 50;
Z1 = 10;
x=0:(pi/16):(4*pi);
%function and graphs
%NOTE THE CHANGE ADDING THE IMAG COMMAND IN FRONT OF THE FUNCTION
f=@(x) imag(Z0*((Z1 + 1i*Z0*tan(x))/(Z0 + 1i*Z1*tan(x))));

ii = 0:(pi/2):13;
R = zeros(1,length(ii));

for A = 1:1:length(ii)
    R(A) = fzero(f,ii(A));
end

disp(['The roots for this function are ' num2str(R)]);
%Sentence commenting on the accuracy of this method compared to the
%previous two, noting the required change, etc.


%% Part 2: Case 1
%This question asks for find the maximum of a function using contour plots,
%as well as mesh and surf plots

clear; clc; clf;

a = 0.1;
b = 0.05;

x= linspace(0,0.1);
y = linspace(0,0.05);
P = zeros(length(x),length(y));
%power density
for m = 0:1:5
    for n =0:5
        for ii= 1:1:length(x)
            for jj = 1:1:length(y)
                P(ii,jj) = ((sin(m*pi.*x(ii)/a)).^2.*(cos(n.*pi.*y(jj)/b)).^2) + ...
                    ((cos(m.*pi.*x(ii)/a)).^2.*(sin(n.*pi.*y(jj)/b)).^2);
            end
        end
        figure(1)
        subplot(3,1,1)
        contour(P);
        subplot(3,1,2)
        surf(P);
        subplot(3,1,3)
        mesh(P);
    end
    
end

%Students should show snapshots of at least 3 plots (make sure to state the m and n values for each)

%% part 2 - Case B
%the maximum of the above function was calculated using the function
%FMINSEARCH, but with adjusted values to convert that into a maximum value
%search

clear; clc; clf;
a = 0.1;
b = 0.05;
m = 1;
n = 1;

power = @(x) - ...
((sin(m*pi*x(1)/a)).^2.*(cos(n*pi*x(2)/b)).^2 + ...
    ((cos(m*pi*x(1)/a)).^2.*(sin(n*pi*x(2)/b)).^2));

[xy, fval] = fminsearch(power,[0.01 0.01]);
powervalue = abs(fval);
disp(['are the y, x and max values respectively ' fprintf('\n%g, %g', xy, powervalue)]);


%students should find the maximum value for more than one case, and then
%compare the values they get to the plots


%Conclusion:
% The method practiced with the above are valueable for optimizing and knowing the roots of functions.
% Practice and knowledge of how your function works, as well as its purpose, would help to know which method of root-finding will be the most efficient.
% In this lab, fzero proved to be the easiest, fastest and cleanest of the
% 3. 
