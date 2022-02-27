clear;
clc;

%% Lab 5 part 2 function and loop
r = 2; % radius is 2m
L = 5; % length is 5m
% d = 3; % the input depth

%% Initialize
init_step = 0.01;
init_end = 2*r;
x = 0:init_step:init_end;
[m,n] = size(x);
table_xy = zeros(2,n);


%% Create loop table
count = 1;
for d = 0:init_step:init_end
    [table_xy(1,count), table_xy(2,count)] = Lab5_func(r,L,d);
    count = count + 1;
end

table_xy'