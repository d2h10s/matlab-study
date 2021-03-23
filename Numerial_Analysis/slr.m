function slr(xi, yi)
% conduct Simple Linear Regression
% xi, yi is row vector
clc, close
n = length(xi);
sx = sum(xi)
sx2 = sum(xi.^2)
sy = sum(yi)
sxy = sum(xi.*yi)

y_ = mean(yi)
x_ = mean(xi)
a(2) = (n*sxy-sx*sy)/(n*sx2-sx^2);
a(1) = y_-a(2)*x_;
fprintf('y = %f %+fx\n\n', a(1), a(2));
d
fx=@(t) a(1)+a(2)*t;

St = sum((yi-y_).^2)
Sr = sum((yi-fx(xi)).^2)
R = sqrt((St-Sr)/St)
R2 = (St-Sr)/St

subplot(1,3,1)
plot(xi,yi, 'o')
hold on
fplot(fx)
subplot(1,3,2)
m = polyfit(xi,yi,1)
fplot(@(t) m(2)+m(1)*t)
subplot(1,3,3)
fplot(@(t) m(2)+m(1)*t)
fplot(@(t) a(1)+a(2)*t)