% Character Represented In This Example Is a 'P'

%Array of Bézier splines
s=[
200 50 200 50 200 650 200 750
200 750 200 750 350 750 350 750
350 750 350 750 550 600 350 450
350 450 350 450 275 450 275 450
275 450 275 450 275 50 275 50
200 50 200 50 275 50 275 50
350 700 450 600 350 500 350 500
275 500 275 500 353 500 353 500
275 700 275 700 353 700 353 700
275 500 275 500 275 700 275 700
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
800 800 800 800 800 800 800 800];

%Application of appropriate formulae and graphing
t=0:0.01:1;
for n=1:16
x1=s(n,1);y1=s(n,2);x2=s(n,3);y2=s(n,4);x3=s(n,5);y3=s(n,6);x4=s(n,7);y4=s(n,8);
bx=3*(x2-x1);
cx=3*(x3-x2)-bx;
dx=x4-x1-bx-cx;
by=3*(y2-y1);
cy=3*(y3-y2)-by;
dy=y4-y1-by-cy;
x=x1+bx*t+cx*t.^2+dx*t.^3;
y=y1+by*t+cy*t.^2+dy*t.^3;
hold on
plot(x,y)
end

title('Character P: Represented with Bézier Splines')
xlabel('X Value')
ylabel('Y Value')