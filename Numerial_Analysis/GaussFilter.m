function GaussFilter(a,sigma)
sigma = 0.1:0.1:10;
ratio = (exp(-(a*a + a*a) ./ (2 * sigma.^2)) ./ (2 * pi * sigma.^2))/(1 ./ (2 * pi * sigma.^2))
plot(sigma,ratio, 'o');