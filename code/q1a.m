rng(0); 
a=0.5; b=1;

x = 2*a*rand()-a;
y = 2*b*rand()-b;
while (true)
    if (4*x*x + y*y <=1) % checking if the point is inside the ellipse
        break;
    end
    x = 2*a*rand()-a;
    y = 2*b*rand()-b;
end
x,y %these are the random numbers genrated inside the ellipse