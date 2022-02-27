clear;
clc;

%% Lab 5 - Part 2
r = 2; % radius is 2m
L = 5; % length is 5m
d = 2; % the input depth

% Calculation
y1 = d - r;
x1 = sqrt(r^2 - y1^2);

f=@(x) sqrt(r.^2-x.^2) - y1;
area_half = quad(f,0,x1)
area_full = 2*area_half

volume = L * area_full

