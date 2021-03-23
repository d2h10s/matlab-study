function lsmlog10(xi,yi)
% conduct Least Squre Method
clc, close all
n = length(xi)
Z = zeros(length(xi), 2);
Y = log10(yi)'
for i = 1:length(xi)
    for j = 0:1
        Z(i,j+1) = log10(xi(i))^j;
    end
end
Z
a = ((Z'*Z)^-1)*Z'*Y
a(1) = 10^(a(1))
plot(xi,yi, 'o')
hold on
fx = @(t) a(1)*t.^(a(2));
fplot(fx)

St = sum((yi-sum(yi)/n).^2)
Sr = sum((yi-fx(xi)).^2)
R = sqrt((St-Sr)/St);
R2 = (St-Sr)/St