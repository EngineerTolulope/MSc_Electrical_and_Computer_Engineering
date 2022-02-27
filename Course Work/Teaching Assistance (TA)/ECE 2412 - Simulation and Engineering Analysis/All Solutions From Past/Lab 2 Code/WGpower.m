function P = WGpower(x,a,b,m,n)
% Input x and y value to calculate P
% x(1) is x and x(2) is y
P = -(((sin(m*pi*x(1)/a)).^2.*(cos(n*pi*x(2)/b)).^2)+((cos(m*pi*x(1)/a)).^2.*(sin(n*pi*x(2)/b)).^2));
end

