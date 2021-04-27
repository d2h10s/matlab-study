s = tf('s');
Kp = 300;
Kd = 10;
num = [Kd Kp];
den = [ 1 10+Kd 20 + Kp];
subplot(1,2,1)
step(num, den, 2);
title('a')
G=1/(1*s^2+1*s+1);
subplot(1,2,2)
step(G, 80)
xticklabels(0:0.2:2)
title('b')