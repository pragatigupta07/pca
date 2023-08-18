rng(0);
while (true)
    y = rand()*exp(1); %generating a random no between 0 and e(height of parallelogram) 
    x = rand()*pi + pi*y/(3*exp(1));  %generating a random no between 0 and pi(base of parallelogram)
        %then adding t which we mentioned in report to get the point inside the parallelogram
    m = -(3*exp(1))/(2*pi);  %slope of diagonal 
    PIT = (m*pi)*(y-m*x+m*pi); %this quantity will tell if the point is inside of triangle
    if (PIT>=0)  % checking if the point is inside triangle
    break;
    end
end
x,y %random point inside the triangle given