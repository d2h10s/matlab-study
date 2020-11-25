clc, clear, close all
syms t;
s = tf('s');

time = 100;
K = 1; t1 = 2; t2 = 0.5;
ts = 0.6; tf = 0.1;

t = ts;

P = -K*(t1*s+1)*(t*s-2)/(t2*s+1)/(t*s+2);
E = -10/(s+10);
A = -(s+6)/s/(s^2+3*s+6);
Gs = P*E*A;
Ts = feedback(Gs,1);

t = tf;

P = -K*(t1*s+1)*(t*s-2)/(t2*s+1)/(t*s+2);
E = -10/(s+10);
A = -(s+6)/s/(s^2+3*s+6);
Gf = P*E*A;
Tf = feedback(Gf,1);

[ys, ts] = step(Ts, time);
[yf, tf] = step(Tf, time);

Gs
Ts
for idx = 1: size(ys)
    if ys(idx) > 1
        break
    end
end
SlowRiseTime = ts(idx)
%slow = stepinfo(Ts, 'RisingTimehreshold', [0 1]);
%RiseTime = slow.RiseTime
%SettlingTime2 = slow.SettlingTime
%slow = stepinfo(Ts, 'SettlingTimeThreshold', 0.05);
%SettlingTime5 = slow.SettlingTime
%Overshoot = slow.Overshoot

Gf
Tf
fast = stepinfo(Tf, 'RisingTimehreshold', [0 1]);
FastRiseTime = fast.RiseTime
FastSettlingTime2 = fast.SettlingTime
fast = stepinfo(Tf, 'SettlingTimeThreshold', 0.05);
FastSettlingTime5 = fast.SettlingTime
PercentFastOvershoot = fast.Overshoot
fastPeak = fast.Peak
FastSettlingTime02 = stepinfo(Tf, 'SettlingTimeThreshold', 0.002).SettlingTime;

for i = 1: length(tf)
    if tf(i) >= FastSettlingTime02
        break
    end
end
Mp = fast.Peak - yf(i)
PO = abs(fast.Peak-yf(i))/yf(i)*100

tt = [0 time];
yy = [1 1];
plot(ts, ys, tf, yf, ts(idx), ys(idx), 'o', FastRiseTime, 1, 'o', tt, yy, '--')
title('Step Response')
xlabel('\ittime')
ylabel('\ity(t)')
text(ts(idx), 3, 'Slow tr' + string(SlowRiseTime));
text(FastRiseTime, -1, 'Fast tr' + string(FastRiseTime));
grid on
legend('slow', 'fast', 'slowRiseTime', 'FastRiseTime')