close
t = 2:0.1:6
th0 = -180
th1 = -90
th = th0./(1+exp(-t))
plot(t,th)