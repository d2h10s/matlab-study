function pr2(xi,yi)
% conduct plynomial regression of degree 2

clc, close all

n = length(xi)
sx = sum(xi)
sx2 = sum(xi.^2)
sx3 = sum(xi.^3)
sx4 = sum(xi.^4)
sy = sum(yi)
sxy = sum(xi.*yi)
sx2y = sum(sxy.^2.*yi)

A = [n sx sx2; sx sx2 sx3;sx2 sx3 sx4]
condition = cond(A)
b = [sy; sxy; sx2y]
x = A\b