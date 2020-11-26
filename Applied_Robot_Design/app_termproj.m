clc, clear, close all
%% 상수 설정
l1 = 0.4; l2 = 0.4; l3 = 0.4; l4 = 0; l5 = 0.2+0.15; % end effector
l = [l1 l2 l3 l4 l5];
m1 = 2.0; m2 = 2.7; m3 = 2.7; m4 = 0; m5 = 2.4+0.004;
m = [m1 m2 m3 m4 m5];

%% 경로 계획

cal_trajectory = @(xi, yi, dy_dx_i, xf, yf, dy_dx_f) [1 xi xi^2 xi^3; 0 1 2*xi 3*xi^2; 1 xf xf^2 xf^3; 0 1 2*xf 3*xf^2]\[yi dy_dx_i yf dy_dx_f]';

thd = -pi/2;

x0 = 0.15;
y0 = 0.3;
dy_dx_0 = 0;
t0 = 0;

x1 = 0.45;
y1 = 0.03;
dy_dx_1 = -3;
t1 = 3;

del_t = 0.07;
len1 = numel(t0:del_t:t1);
px1 = zeros(1, len1);
py1 = zeros(1, len1);

A1 = cal_trajectory(x0, y0, dy_dx_0, x1, y1, dy_dx_1);

for i = 0:len1-1
    px1(i+1) = (x1-x0)*0.5*(1-cos(pi/(len1-1)*i))+x0;
    py1(i+1) = A1'*[1 px1(i+1) px1(i+1)^2 px1(i+1)^3]';
end
subplot(2,2,1)
plot(0:len1-1, px1,'o')

subplot(2,2,2)
plot(px1, py1)
%% 역기구학
x3 = px1 - (l5).*cos(thd);
y3 = py1 - (l5).*sin(thd);

c3 = (x3.^2 + (y3-l1).^2 - l2.^2 - l3.^2)./(2*l2*l3);
s3 = -sqrt(1-c3.^2);

th3 = atan2(s3, c3);
th2 = atan2(y3 - l1, x3) - atan2(l3.*sin(th3),l2+l3.*cos(th3));
th4 = thd - th3 - th2;
th5 = 0;
%% DH-Parameter 시뮬레이션
%{
%           a    alpha    d    theta
DHparams = [  0,  pi/2, l1,   0;
             l2,     0,  0, th2;
             l3,     0,  0, th3;
              0, -pi/2,  0, th4;
              0,     0, l5, th5]
%}
%  L = Link([th  d   a  alpha])
L(1) = Link([0, l1,  0,  pi/2]);
L(2) = Link([0,  0, l2,     0], 'R');
L(3) = Link([0,  0, l3,     0], 'R');
L(4) = Link([0,  0, l4, -pi/2], 'R');
L(5) = Link([0, l5,  0,     0], 'R');
robot = SerialLink(L, 'name', 'bobper')
subplot(2,2,3)

for i =1:numel(th3)
    robot.plot([0 th2(i) th3(i) -pi/2+th4(i) th5], 'floorlevel', 0, 'jvec', 'fps', 60, 'base', 'trail',{'r','LineWidth', 1})
end
figure

%% Dynamics
