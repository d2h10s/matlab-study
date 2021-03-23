function root = p3newtonRaphson(func,x,tol)
% Newton-Raphson method of finding a root of simultaneous
% equations fi(x1,x2,...,xn) = 0, i = 1,2,...,n.
% USAGE: root = newtonRaphson2(func,x,tol)
% INPUT:
% func = handle of function that returns[f1,f2,...,fn].
% x = starting solution vector [x1,x2,...,xn].
% tol = error tolerance (default is 1.0e4*eps).
% OUTPUT:
% root = solution vector.
if nargin == 2; tol = 1.0e4*eps; end
if size(x,1) == 1; x = x'; end % x must be column vector
for i = 1:30
   [jac,f0] = jacobian(func,x);
   if sqrt(dot(f0,f0)/length(x)) < tol
      root = x; return
   end
   dx = -jac\f0;
   x = x + dx;
   if sqrt(dot(dx,dx)/length(x)) < tol*max(abs(x),1.0)
      root = x; return
   end
end
error('Too many iterations')

function [jac,f0] = jacobian(func,x)
% Returns the Jacobian matrix and f(x).
h = 1.0e-4;
n = length(x);
jac = zeros(n);
f0 = feval(func,x);
for i =1:n
   temp = x(i);
   x(i) = temp + h;
   f1 = feval(func,x);
   x(i) = temp;
   jac(:,i) = (f1 - f0)/h;
end