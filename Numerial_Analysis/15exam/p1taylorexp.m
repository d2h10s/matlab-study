function [expvalue] = p1taylorexp(x,n)
expvalue=0;
temp=0;
for k=0:n
	temp=x^n/factorial(k);
	expvalue=expvalue+temp;
end

% question = p1taylorexp(1,10)
% answer = 2.718281801146385

%error= ( exp(1) - p1taylorexp(1,10))/exp(1)*100
% answer = 1.004776647358234e-06