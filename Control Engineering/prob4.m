clc, clear, close all, format short

time = 10;
% syms s
% ilaplace((1262646*s+288162)/106301/(s*s+8*s+25))
s = tf('s');
T = 2700*7*(s+25)/(s+1)/(s+45)/(s+60)/(s*s+8*s+25)
% pole(T)
% zero(T)
subplot(3,3,1)
rlocus(T)
subplot(3,3,2)
pzmap(T)
subplot(3,3,3)
step(T, time)
stepinfo(T,'SettlingTimeThreshold', 0.05)

s1 = 1/s;
s2 = 1/(s+1);
s3 = 45/(s+45);
s4 = 60/(s+60);
s5 = (s+25)/(s^2+8*s+25);
s6 = 25/(s^2+8*s+25);
st = 7/s -6300/649/(s+1)-14/1859/(s+45)+147/37111/(s+60)+288162/106301*s/(s^2+8*s+25)+1262646/106301/(s^2+8*s+25);

subplot(3,3,4)
% hold on
% [ss1 tt1] = impulse(s1, time);
% impulse(s1, time)
% [ss2 tt2] = impulse(s2, time);
% impulse(s2, time)
% [ss3 tt3] = impulse(s3, time);
% impulse(s3, time)
% [ss4 tt4] = impulse(s4, time);
% impulse(s4, time)
% [ss5 tt5] = impulse(s5, time);
% impulse(s5, time)
% [ss6 tt6] = impulse(s6, time);
% impulse(s6, time)
% [sst, ttt] = impulse(st, time);
% impulse(st, time)
% hold off
% legend('s1', 's2', 's3', 's4', 's5', 's6', 'st')
% lsiminfo(sst,ttt,7)
% lsiminfo(ss1,tt1,0)
% lsiminfo(ss2,tt2,0)
% lsiminfo(ss3,tt3,0)
% lsiminfo(ss4,tt4,0)
% lsiminfo(ss5,tt5,0)
% lsiminfo(ss6,tt6,0)

tt = 0:0.01:time;
y1 = ones(1,length(tt)).*7;
y2 = @(t) -6300/649*exp(-t);
y3 = @(t) -14/1859*exp(-45*t);
y4 = @(t) 147/37111*exp(-60*t);
y5 = @(t) 288162/106301*exp(-4*t).*cos(3*t);
y6 = @(t) 724/2099*exp(-4*t).*sin(3*t);
yt = @(t) 7 -6300/649*exp(-t)-14/1859*exp(-45*t)+147/37111*exp(-60*t)+288162/106301*exp(-4*t).*cos(3*t)+724/2099*exp(-4*t).*sin(3*t);
subplot(3,3,5)
plot(tt, y1, tt, y2(tt), tt, y3(tt), tt, y4(tt), tt, y5(tt), tt, y6(tt), tt, yt(tt))
yt(0.75)
legend('y1', 'y2', 'y3', 'y4', 'y5', 'y6', 'yt')