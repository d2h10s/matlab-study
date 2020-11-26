function s=p1DivAvg(a,eps)
if a > 0
    x = a / 2;
    while(1)
        y = 
        e = abs((y - x) / y);
        x = y;
        if e < eps
            
        end
    end
    s = x;
else
    error('a should be positive');
end
