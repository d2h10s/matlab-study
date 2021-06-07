clear, close, clc
m = 0.05; k = 1e-4; L = 0.01; R = 1; g= 9.81; h = 0.01; i = 7;
A = [0,              1,              0;
    (k*i^2)/(m*h^2), 0, -(2*k*i)/(m*h);
    0,               0,           -R/L];
B = [0; 0; 1/L];
C = [1, 0, 0];
D = 0;

poles = eig(A)

t = 0:0.01:2;
u = zeros(size(t));
x0 = [0.01 0 0];
sys = ss(A, B, C, D)
[y,t,x] = lsim(sys, u, t, x0);
plot(t, y);
title('Open-Loop Response to Non-Zero Initial Condition')

p1 = -10 + 10i;
p2 = -10 - 10i;
p3 = -50;

K = place(A, B, [p1, p2, p3]);
sys_cl = ss(A-B*K, B, C, 0);

lsim(sys_cl, u, t, x0);
xlabel('Time (sec)')
ylabel('Ball Position (m)')