%p3nlsys.m
function y = p3nlsys(x)
y = [sin(x(1)) + x(2)^2+log(x(3))-7; 3*x(1)+2^x(2)-x(3)^3+1; x(1)+x(2)+x(3)-5];
