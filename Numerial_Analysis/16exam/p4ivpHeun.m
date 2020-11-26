function [t,y] = p4ivpHeun(dydt,tspan,y0,h,varargin)
% input:
%   dydt = name of the M-file that evaluates the ODE
%   tspan = [ti, tf] where ti and tf = initial and
%           final values of independent variable
%   y0 = initial value of dependent variable
%   h = step size
% output:
%   t = vector of independent variable
%   y = vector of solution for dependent variable
if nargin<4,error('at least 4 input arguments required'),end
ti = tspan(1);tf = tspan(2);
if ~(tf>ti),error('upper limit must be greater than lower'),end
t = (ti:h:tf)'; n = length(t);
% if necessary, add an additional value of t
% so that range goes from t = ti to tf
if t(n)<tf
  t(n+1) = tf;
  n = n+1;
end
y=zeros(n, length(y0));%preallocate y to improve efficiency
y(1,:)=y0;
for i = 1:n-1 %implement Heuns method
  hh=(t(i+1)-t(i));
  ytemp=y(i,:)+dydt(t(i),y(i,:))'*hh;
  phi=(dydt(t(i),y(i,:))+dydt(t(i)+hh,ytemp))/2;
  y(i+1,:) = y(i,:) + phi*hh;  
end