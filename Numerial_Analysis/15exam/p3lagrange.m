function yint = p3lagrange(x,y,xx)
% input:
%   x = independent variable
%   y = dependent variable
%   xx = value of independent variable at which the
%        interpolation is calculated
% output:
%   yint = interpolated value of dependent variable
n = length(x);
s = 0;
for i = 1:n
  product = y(i);
  for j = 1:n
    if i ~= j
      product = product.*(xx-x(j))./(x(i)-x(j));
    end
  end
  s = s+product;
end
yint = s;