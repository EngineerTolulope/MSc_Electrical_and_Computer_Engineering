%% Problem 8.3
clear;clc;close all;

A=[0 -6 5; 0 2 7;4 -3 7];   %define the coefficient matrix. 
b=[50; -30; -50];           % define the b vector
x=A\b;                      % solve the set of equations using left division

fprintf(' The solution is: \n x1 =  %0.4f \n x2 =  %0.4f  \n x3 =  %0.4f \n',x(1),x(2),x(3)) 
 
disp('The transpose of the coefficient matrix is: ')
disp(A')

disp('The inverse of the coefficient matrix is: ')
disp(inv(A))

%% Problem 9.4
clear;clc;close all;
A=[0 2 5; 2 1 1; 3 1 0]; %define the coefficient matrix. 
b=[1; 1; 2];           % define the b vector

% (a) Compute the determinant.
fprintf(' The determinant is: %0.4f \n',det(A))
fprintf('\n')

% (b) Cramer’s rule to solve for the x’s.
A_temp = A;  % creating a temporary matrix A_temp = A
A_temp(:,1)=b; % replacing the first column with b vector
x1=det(A_temp)/det(A); %solving for x1

A_temp = A;  % temporary matrix A_temp = A
A_temp(:,2)=b; % replacing the second column with b vector
x2=det(A_temp)/det(A); %solving for x2

A_temp = A;  % temporary matrix A_temp = A
A_temp(:,3)=b; % replacing the third column with b vector
x3=det(A_temp)/det(A); %solving for x3

fprintf(' The solution is: \n')
fprintf(' x1 = %0.4f \n',x1)
fprintf(' x2 = %0.4f \n',x2)
fprintf(' x3 = %0.4f \n',x3)
fprintf('\n')
% (c) Gauss elimination with partial pivoting
[m n]=size(A); % m is the number of rows and n is the number of columns
Ab = [A b];  % creating a matrix Ab = [ A b]





% Forward Elimination
 for k=1:n-1  % Loop for the columns
     
     % Partial Pivoting
     [M, I] = max (Ab(:,k)); % I is the index of the maximum pivot
     Ab_temp=Ab(k,:); % storing the kth row in a temporary vector
     Ab(k,:)=Ab(I,:); % Swaping the kth row and the maximum pivot row (I)
     Ab(I,:)=Ab_temp;
     
     for i=k+1:n % Loop for the rows
         factor = Ab(i,k)/Ab(k,k); %calculating the factor
         Ab(i,:)=Ab(i,:)-factor*Ab(k,:); % modify the row
     end 
 end

 % Back Substitution
 x=zeros(n,1); % creating a vector x to store the solution
 for i=n:-1:1       % Loop for the rows (unknows)
     x(i)=Ab(i,n+1); % First step in calculating the unknows
     for j=1:n
         if(j~=i) % The second step should be applied only if j not equal to i
         x(i)= x(i) - Ab(i,j)*x(j);   % Second step in calculating the unknows
         end
     end
  
     x(i)=x(i)/Ab(i,i); % Third step in calculating the unknows
 end
 
fprintf(' The solution using Gauss elimination with partial pivoting: \n')
fprintf(' x1 = %0.4f \n',x(1))
fprintf(' x2 = %0.4f \n',x(2))
fprintf(' x3 = %0.4f \n',x(3))
fprintf('\n')

% Calculating the determinant after the Forward Elimination
A_det = Ab(1,1)*Ab(2,2)*Ab(3,3);
fprintf('The determinant using Gauss elimination: %0.4f \n', A_det)
fprintf('\n')

% (d) Substitute your results back into the original equations

% Equation (1)
fprintf('The left side of equation (1): %0.4f \n', 2*x(2) + 5*x(3))
fprintf('The left side of equation (2): %0.4f \n', 2*x(1) + x(2) + x(3))
fprintf('The left side of equation (3): %0.4f \n', 3*x(1) + x(2))
fprintf('\n')

%% Problem 9.11
clear;clc;close all;

% Convert the probelm into equations as:
% 15 x1 + 17 x2 + 19 x3 = 2120
% 0.25 x1 + 0.33 x2 + 0.42 x3 = 434
% x1 + 1.2 x2 + 1.6 x3 = 164

% Convert the equations into natrix:
A=[15 17 19; 0.25 0.33 0.42; 1 1.2 1.6]; %define the coefficient matrix. 
b=[2.12;0.0434;0.164]*1000;           % define the b vector
x=A\b;   % solve the set of equations using left division
x=floor(x); % To convert x into integer
fprintf(' The number of components that can be produced per day are: \n')
fprintf(' The number of component 1 =  %0.0f \n', x(1)) 
fprintf(' The number of component 2 =  %0.0f \n', x(2)) 
fprintf(' The number of component 3 =  %0.0f \n', x(3)) 
 
%% Problem 10.5
clear;clc;close all;

A = [ 2 -6 -1; -3 -1 6; -8 1 -2];%define the coefficient matrix. 
b = [-38 ;-34; -40]; % define the b vector
P = [0 0 1; 0 1 0; 1 0 0]; % To implement the partial Pivoting

[L U]=lu(P*A); % Calculate the L and U Matrix


% Compute the d vector
d = L\(P*b);

% Find the solution x vecotr
x = U\d;


fprintf(' The solution using LU factorization with partial pivoting: \n')
fprintf(' x1 = %0.4f \n',x(1))
fprintf(' x2 = %0.4f \n',x(2))
fprintf(' x3 = %0.4f \n',x(3))
fprintf('\n')

%% Problem 12.2
clear;clc;close all;

% Re-arranging each equation to solve for unkowns
%            41 + 0.4 x2 
%  x1 =    --------------
%                0.8

%            25 + 0.4 x1 + 0.4 x3 
%  x2 =    ----------------------
%                   0.8

%            105 + 0.4 x2  
%  x3 =    -----------------
%                 0.8

% (a) Without Relaxation
Es=5/100;           % define the tolerance
Ea = 1+Es;      % Set the initial value of Ea > Es
x=zeros(3,1);   % initial values of the x's

while ( Ea > Es)
    x_old = x; % Storing the old values 
    
    % Calculating the new estimates 
    x(1) = (41 + 0.4*x(2))/0.8;
    x(2) = (25 +0.4*x(1) + 0.4*x(3))/0.8;
    x(3) = (105 + 0.4*x(2))/0.8;
    
    % calculate the relative error
    Ea = max ((x - x_old) ./ x); 
end

fprintf(' The solution using Gauss-Seidel method: \n')
fprintf(' x1 = %0.4f \n',x(1))
fprintf(' x2 = %0.4f \n',x(2))
fprintf(' x3 = %0.4f \n',x(3))
fprintf('\n')

% (b) With Relaxation
Es=5/100;           % define the tolerance
Ea = 1+Es;      % Set the initial value of Ea > Es
x=zeros(3,1);   % initial values of the x's
lamda = 1.2;

while ( abs(Ea) > Es)
    x_old = x; % Storing the old values 
    
    % Calculating the new estimates 
    x(1) = (41 + 0.4*x(2))/0.8;
    x(2) = (25 +0.4*x(1) + 0.4*x(3))/0.8;
    x(3) = (105 + 0.4*x(2))/0.8;
    
    % Add the relaxiation
    x = lamda * x + (1-lamda)*x_old;
    
    % calculate the relative error
    Ea = max(abs ((x - x_old) ./ x)); 
end

fprintf(' The solution using Gauss-Seidel method with Relaxation: \n')
fprintf(' x1 = %0.4f \n',x(1))
fprintf(' x2 = %0.4f \n',x(2))
fprintf(' x3 = %0.4f \n',x(3))
fprintf('\n')
%% Problem 12.9
clear;clc;close all;

% Re-arranging the equations 
%
% y = [5 - x^2] ^ 0.5   ------  (1)
%
% y = x^2 - 1 ----------------- (2)

% (a) Graphically
% Note that equation (1) domain: -5^0.5 < x < 5^0.5
x = -sqrt(5):0.01:sqrt(5);
y1= (5 - x.^2).^0.5;
y2= x.^2 - 1;

plot(x,y1,'r')
hold on
plot(x,y2)

clear;
% (b) Successive substitution
Es=0.5/100;     % define the tolerance (Students should pick the value)
Ea = 1+Es;      % Set the initial value of Ea > Es
x=[1.5 1.5];   % initial values of the x's

while ( Ea>Es)
     x_old = x; % Storing the old values 
    
    % Calculating the new estimates ( This arragment of equation will
    % converge
    x(1) = sqrt((x(2) +1));
    x(2) = sqrt(5 - x(1)^2);

    
    % calculate the relative error
    Ea = max(abs(((x - x_old) ./ x))); 
end

fprintf(' The solution using Successive substitution: \n')
fprintf(' x1 = %0.4f \n',x(1))
fprintf(' x2 = %0.4f \n',x(2))
fprintf('\n')

clear;
% (c) Newton-Raphson - Rearrange the equations as
%
%       f1 (x,y) = 5 - x^2 - y^2
%
%       f2 (x,y) = x^2 - y -1
%
Es=0.5/100;      % define the tolerance (Students should pick the value)
Ea = 1+Es;      % Set the initial value of Ea > Es
x=[1.5 1.5];   % initial values of the x's

while ( Ea>Es)
     x_old = x; % Storing the old values 
    
    % Calculating the functions values
    f1 = 5 - x(1)^2 - x(2)^2;
    f2 = x(1)^2 - x(2) - 1;
    f= [f1 ; f2];
    
    % Calculating the J matrix 
    df1_dx = -2* x(1);
    df1_dy = -2* x(2);
    df2_dx = 2*x(1);
    df2_dy = -1;
    J = [df1_dx df1_dy; df2_dx df2_dy];

    % calculating the new estimate
    x=x-J\f;
    
    % calculate the relative error
    Ea = max(abs(((x - x_old) ./ x))); 
end

fprintf(' The solution using Newton-Raphson: \n')
fprintf(' x1 = %0.4f \n',x(1))
fprintf(' x2 = %0.4f \n',x(2))
fprintf('\n')