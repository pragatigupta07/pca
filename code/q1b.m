rng(0); 
a=0.5; b=1;
N =10000000;
pointsx = 1:N;
pointsy = 1:N;
for i=1:N;
    while (true)
        x = 2*a*rand()-a;
        y = 2*b*rand()-b;
        if (4*x*x + y*y <=1)
            break;
        end
    end
    pointsx(i)=x;
    pointsy(i)=y;
end
histogram2(pointsx, pointsy, 1000, 'DisplayStyle','tile') 