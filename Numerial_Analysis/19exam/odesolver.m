function [t,y] = odesolver(dydt,tspan,y0,h,varagin)
if nargin < 4, error('at least 4 input arguments required'), end
ti = tspan(1);tf=tspan(2);
if ~(tf>ti),error('upper limit must be greater than lower'), end
t = (ti:h:tf)';n = length(t);
if t(n) <tf
    t(n+1) = tf;
    n = n+1;
end
y = zeros(n,length(y0));
y(1,:) = y0;
for i = 1: n-1
    hh =(t(i+1) - t(i));
    pred = y(i,:)+dydt(t(i)+hh,y(i,:))'*hh*0.5;
    phi=dydt(t(i)+hh/2,pred)';
    y(i+1,:) = y(i,:) + phi*hh;
end