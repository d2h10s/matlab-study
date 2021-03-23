function mlr(x1,x2,y)
%conduct multiple linear regression
clc, close all

n = length(x1)
sx1 = sum(x1)
sx2 = sum(x2)
sx1_2 = sum(x1.^2)
sx12 = sum(x1.*x2)
sx2_2 = sum(x2.^2)
sy = sum(y)
sx1y = sum(x1.*y)
sx2y = sum(x2.*y)

Z = [ n sx1 sx2;
    sx1 sx1_2 sx12;
    sx2 sx12 sx2_2]
Y = [sy; sx1y; sx2y]
a = pinv(Z)*Y
fx = @(t1,t2) a(1)+a(2)*t1+a(3)*t2;
[i, j] = meshgrid(0:5,0:5);
k = fx(i,j);
plot3(x1,x2,y,'o')
hold on
surf(i,j,k)
hold off