t = 0:0.1:6
th0 = -180
th1 = -90
th = (th1 - th0)*(1-exp(-t))+th0
plot(t,th)