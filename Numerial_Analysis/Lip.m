function y = Lip(xi, yi, a, d)
% conduct Lagrange's interpolating polynomials
% a = target value of x, d = dimension
clc, close all

y = 0;
for i = 1:d+1
    cash = 1;
    for j = 1:d+1
        if (i ~= j)
            cash = cash*(a-xi(j))/(xi(i)-xi(j));
        end
    end
    cash = cash * yi(i);
    y = cash + y;
end