function [x,k]=p3Jacobi(A,b,x0, es, maxit)
% Input  A is an nonsingular matrix (n x n)
%        b is an righthand vector (n x 1)
%        x0 is the initial guess
%	     es is the stop criterion
%	     maxit is the maximum number of iterations
% Output - x is an N x 1 matrix: the jacobi approximation to
%	        the solution of AX = B
n = length(b);
x= zeros(n,1);
xold=x0;
for k=1:maxit
   for j=1:n
      x(j)=(b(j)-A(j,[1:j-1, j+1:n])*x([1:j-1, j+1:n]))/A(j,j);
   end
   fprintf('iter = %d\nx1 = %f\nx2 = %f\nx3 = %f\n\n', k, x(1), x(2), x(3));
   ea=abs((x-xold)./x);
   if (max(ea)<es)
      break;
   end
   xold=x;
end

