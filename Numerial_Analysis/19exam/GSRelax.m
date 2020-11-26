function [x,ea,iter] = GSRelax(A,b,lambda, es,maxit)
% GaussSeidel: Gauss Seidel method
% x = GaussSeidel(A,b): Gauss Seidel without relaxation
% input:
% A = coefficient matrix
% b = right hand side vector
% lamda = relaxation factor (default =1)
% es = stop criterion (default = 0.00001%)
% maxit = max iterations (default = 50)
% output:
% x = solution vector
% ea = maximum relative error (%)
% iter = number of iteration
if nargin<2,error('at least 2 input arguments required'),end
if nargin<5|isempty(maxit),maxit=50;end
if nargin<4|isempty(es),es=0.00001;end
if nargin<3|isempty(lambda),lambda=1;end

[m,n] = size(A);
if m~=n, error('Matrix A must be square'); end
C = A;
for i = 1:n
C(i,i) = 0;
x(i) = 0;
end
x = x';
for i = 1:n
C(i,1:n) = C(i,1:n)/A(i,i);
end
for i = 1:n
d(i) = b(i)/A(i,i);
end
iter = 0;
while (1)
xold = x;
for i = 1:n
x(i) = d(i)-C(i,:)*x;
x(i) = lambda*x(i)+(1-lambda)*xold(i)
if x(i) ~= 0
ea(i) = abs((x(i) - xold(i))/x(i)) * 100;
end
end
iter = iter+1;
if max(ea)<=es | iter >= maxit, break, end
end