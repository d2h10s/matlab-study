function yp = predprey(t,y)
k1=3; k2=0.003; k3= 0.001; k4= 0.5;
yp = [k1*y(1) - k2*y(1)*y(2);k3*y(1)*y(2) - k4*y(2)];