rng(0);
N =10000000;
pointsx = 1:N;
pointsy = 1:N;
for i=1:N;
    while (true)
        y = rand()*exp(1);
        x = rand()*pi + pi*y/(3*exp(1));
        m = -(3*exp(1))/(2*pi);
        PIT = (m*pi)*(y-m*x+m*pi);
        if (PIT>=0)
        break;
        end
    end
    pointsx(i)=x;
    pointsy(i)=y;
end
histogram2(pointsx, pointsy, 1000, 'DisplayStyle','tile') 