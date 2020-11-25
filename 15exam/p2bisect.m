function [root, ea, iter] = p2bisect(func,xl,xu,es,maxit)
% input:
% func = name of function
% xl, xu = lower and upper guesses
% es = desired relative error (default = 0.0001%)
% maxit = maximum allowable iterations (default = 50)
% output:
% root = real root
% ea = approximate relative error (%)
% iter = number of iterations
test = func(xl)*func(xu);
if test>0,error('no sign change'),end
if nargin<4|isempty(es), es=0.0001;end
if nargin<5|isempty(maxit), maxit=50;end
iter = 0; xr = xl; ea = 100;
while (1)
  xrold = xr;
  xr = (xu+xl)/2;
  iter = iter +1;
  ea = (xr - xrold)/xr*100;
  if xr ~= 0,ea = abs((xr - xrold)/xr) * 100;end
  test = func(xl)*func(xr);
  if test < 0
    xu = xr;
  elseif test > 0
    xl = xr;
  else
    ea = 0;
  end
  if ea <= es | iter >= maxit,break,end
end
root = xr; 

% question = @(x) exp(x)+x* sin(x)
% answer =  -3.155107498168945
% ea = 6.045273049870480e-05
% iter = 22