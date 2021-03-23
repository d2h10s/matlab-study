l1 = 0.4
l2 = 0.4
l3 = 0.4
l4 = 0.2+0.15

px = 0.5
py = 0.3
thd = 0


x3 = px - l4*cos(thd+pi/2);
y3 = py - l4*sin(thd+pi/2);

c3 = (x3.^2 + (y3-l1).^2 - l2.^2 - l3.^2)./(2*l2*l3);
s3 = -sqrt(1-c3.^2);

th3 = atan2(s3, c3);
th2 = atan2(y3 - l1, x3) - atan2(l3.*sin(th3),l2+l3.*cos(th3));
th4 = thd - th3 - th2;
th5 = zeros(len);