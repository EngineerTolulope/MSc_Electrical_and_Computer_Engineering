clear;
clc;

%% Lab 3
%% Part 1)Generate sparse matrix
D=diag([-4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4],0);

D1=diag([1 1 1 1 1 1 1 1 1 1 1 1],-4);
D2=diag([1 1 1 1 1 1 1 1 1 1 1 1],4);
D3=diag([1 1 1 0 1 1 1 0 1 1 1 0 1 1 1],1);
D4=diag([1 1 1 0 1 1 1 0 1 1 1 0 1 1 1],-1);
D4=D+D1+D2+D3+D4;


%% Part 2) Matlab Backslash
X =  [0 0 0 -10 0 0 0 -10 0 0 0 -10 0 0 0 -10]';

tstart = tic;
for n = 1:1000
   Y = D4\X; 
end
elaspse_time = toc(tstart); %time is 0.0227/1000 s
disp(elaspse_time);

matrix_x = zeros(6,6);
count = 1;
for i = 2 : 5
    for j = 2:5
       matrix_x(i,j) = Y(count);
       count = count + 1;
    end
end

for i = 2:5
   matrix_x(i,6) = 10;
end

% Plot
figure(1);
surf(matrix_x);
title('Potential 3D plot');
xlabel('x');
ylabel('y');
zlabel('Potential');

%% Part 2
matrix_y = zeros(6,6);
for i = 2:5
   matrix_y(i,6) = 10;
end

tstart = tic;
iteration = 0;
true_error = 100; % initialize to be 100%
while(true_error > 1)
    max_change = 0; % initialize
    xy_cod = [1,1]; % initialize
    for i = 2:5
       for j = 2:5
          old_val = matrix_y(i,j);
          matrix_y(i,j) =  (matrix_y(i+1,j) + matrix_y(i-1,j) + matrix_y(i,j+1)+ matrix_y(i,j-1))/4;
          cur_change = abs(matrix_y(i,j) - old_val);
          if cur_change > max_change
              max_change = cur_change; % updated maximum error
              xy_cod = [i,j]; %updated the coordinate
              true_error = abs(matrix_y(i,j) - matrix_x(i,j))/matrix_x(i,j) * 100; % in percent
          end       
       end
    end
    figure(2);
    surf(matrix_y)
    iteration = iteration + 1;
%     disp(matrix_y);
%     disp(true_error);
%     disp(iteration);
%     pause;
end
elapse_time = toc(tstart);
disp(elapse_time);

%% Relaxation method
sta_val = 0.8;
end_val = 1.2;
[row column] = size(sta_val:0.01:end_val);
total_iteration = zeros(1,column);

count = 1;
for relax_coef = sta_val:0.01:end_val
    iteration = 0;
    true_error = 100; % initialize to be 100%
    matrix_y = zeros(6,6);
    for i = 2:5
       matrix_y(i,6) = 10;
    end
    
    while(true_error > 1)
        max_change = 0; % initialize
        xy_cod = [1,1]; % initialize
        for i = 2:5
           for j = 2:5
              old_val = matrix_y(i,j);
              matrix_y(i,j) =  (1-relax_coef)*old_val + relax_coef*(matrix_y(i+1,j) + matrix_y(i-1,j) + matrix_y(i,j+1)+ matrix_y(i,j-1))/4;
              cur_change = abs(matrix_y(i,j) - old_val);
              if cur_change > max_change
                  max_change = cur_change; % updated maximum error
                  xy_cod = [i,j]; %updated the coordinate
                  true_error = abs(matrix_y(i,j) - matrix_x(i,j))/matrix_x(i,j) * 100; % in percent
              end       
           end
        end
        iteration = iteration + 1;
%         disp(matrix_y);
%         disp(iteration);
    end
    total_iteration(count) = iteration; 
    count  = count + 1;
end

relax_coef = sta_val:0.01:end_val;
figure(3);
plot(total_iteration, relax_coef);
title('The plot of total iterations versus the relaxation coefficient given 1% true error');
xlabel('The number of iterations');
ylabel('The relaxation coefficients');
grid on;

%%Matrix Inverse

D_inv = inv(D4);
D_max = max(max(D_inv)); % absolute max
D_min = min(min(D_inv)); % absolute min


D_cond = cond(D4); % conditional number to indicate the relationship to singular matrix

tstart = tic;
for n = 1:1000
D_inv=inv(D4);
Y = D_inv*X;
end
elaspse_time = toc(tstart);
disp(elaspse_time);















