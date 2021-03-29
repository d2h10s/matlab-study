close all, clc, clear
%% modeling constant
M = 1000; % kg
b = 10; % N.s/m
k = 20; % N/m
F = 1; % input is unit function

%% step function
subplot(2,3,1)
num = 1; % numerator 분자
den = [1 10 20]; % denominator 분모
step(num, den); % 1/(s^2+10*s+20) 세 번째 인수로 시간을 넣을 수 있음

%% P-Control
subplot(2,3,2)
Kp = 300;
num = Kp;
den = [1 10 20+Kp];
t = 0:0.01:2;
step(num, den, t);
title('P-Contorl')
%% 매트랩 함수로 전달함수 계산
subplot(2,3,3)
num = 1;
den = [1 10 20];
Kp = 300;
[numCL, denCL] = cloop(Kp*num, den); % 전달함수 계산
t = 0:0.01:2;
step(numCL, denCL, t);
title('P-Contorl')
%% P-D Control
subplot(2,3,4)
Kp = 300;
Kd = 10;
num = [Kd Kp];
den = [ 1 10+Kd 20 + Kp];
t = 0:0.01:2;
step(num, den, t);
title('PD-Contorl')
%% P-I Control
subplot(2,3,5)
Kp = 30;
Ki = 70;
num = [Kp Ki];
den = [1 10 20+Kp Ki];
t = 0:0.01:2;
step(num, den, t)
title('PI-Contorl')
%% P-I-D Control
subplot(2,3,6)
Kp = 350;
Ki = 300;
Kd = 50;
num = [Kd Kp Ki];
den = [1 10+Kd 20+Kp Ki];
t = 0:0.01:2;
step(num, den, t)
title('PID-Contorl')