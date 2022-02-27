%Alex Tozer- 3616611
%Assignment 1
%Question 6- Problem 3.14
clear
clc
m=0;
t1=zeros(1,111);
v1=zeros(1,111);
for i=-5:0.5:50
 m=m+1;
 t1(m)=i;
 v1(m)=part(t1(m));
end
plot(t1,v1,'LineWidth',3);
xlabel('Time');
ylabel('Velocity');
function v=part(t)
if (t<0)
 x=0;
elseif (t<8)
 x=10.*t.^2-5.*t;
elseif (t<16)
 x=624-3.*t;
elseif(t<26)
 x=36.*t+12*(t-16).^2;
else
 x=2136.*exp(-0.1.*t+0.1*26);
end
v=x;
end