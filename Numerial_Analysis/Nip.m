function y = Nip(xi, yi, a, d)
% conduct newton's interpolating polynomials
% 구현실패

clc, close all

y = yi(1);
b(d) = 0;
b(1) = yi(1);
b(2) = (yi(2)-yi(1))/(xi(2)-xi(1));
for i = 3:d+1
    b(i) = (((yi(i)-yi(i-1))/(xi(i)-xi(i-1)))-b(i-1))/(xi(i)-xi(1));
end
for i = 1:d
    t = 1;
    for j = 1:i
        t = t*(a-(xi(i)));
    end
    y = y+ b(i)*t;
end