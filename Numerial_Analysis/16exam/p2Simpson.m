function I = p2Simpson(func,a,b,n,varargin)
% Simpson: composite trapezoidal rule quadrature
%   I = Simspon(func,a,b,n,pl,p2,...):
%       composite Simpson 1/3 rule
% input:
%   func = name of function to be integrated
%   a, b = integration limits
%   n = number of segments (default = 100)
%   pl,p2,... = additional parameters used by func
% output:
%   I = integral estimate
if nargin<3,error('at least 3 input arguments required'),end
if ~(b>a),error('upper bound must be greater than lower'),end
if nargin<4|isempty(n),n=100;end
if mod(n,2), error('n should be even number to implement Simpson 1/3 rule'), end
x = a; h = (b - a)/n;
s=func(a,varargin{:});
for k = 1 : n-1
  x = x + h;
  if mod(k,2)
      s = 
  else
      s = 
  end  
end
s = s + func(b,varargin{:});
I = 