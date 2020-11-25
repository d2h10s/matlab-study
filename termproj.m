clc, clear, close all
%% 상수 설정
l1 = 0.4; l2 = 0.4; l3 = 0.4; l4 = 0; l5 = 0.2+0.15; % end effector
l = [l1 l2 l3 l4 l5];
m1 = 2.0; m2 = 2.7; m3 = 2.7; m4 = 0; m5 = 2.4+0.004;
m = [m1 m2 m3 m4 m5];

%% 경로 계획

cal_trajectory = @(xi, yi, dy_dx_i, xf, yf, dy_dx_f) [1 xi xi^2 xi^3; 0 1 2*xi 3*xi^2; 1 xf xf^2 xf^3; 0 1 2*xf 3*xf^2]\[yi dy_dx_i yf dy_dx_f]';

thd = -pi/2;

x0 = 0.1;
y0 = 0.3;
dy_dx_0 = -2;
t0 = 0;

x1 = 0.45;
y1 = 0.03;
dy_dx_1 = -3;
t1 = 3;

del_t = 0.1;
len1 = numel(t0:del_t:t1);
px1 = zeros(1, len1);
py1 = zeros(1, len1);

A1 = cal_trajectory(x0, y0, dy_dx_0, x1, y1, dy_dx_1);

for i = 0:len1-1
    px1(i+1) = x0*(1-i/(len1-1)) + x1*(i/(len1-1));
    py1(i+1) = A1'*[1 px1(i+1) px1(i+1)^2 px1(i+1)^3]';
end

x2 = 

figure
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

%% 암 이미지 비교를 통한 역기구학 검증
Ax = [zeros(1, len1);    zeros(1, len1);    l2.*cos(th2);    l2.*cos(th2)+l3.*cos(th2+th3);    l2.*cos(th2)+l3.*cos(th2+th3)+l5.*cos(th2+th3+th4)];
Ay = [zeros(1, len1); ones(1, len1).*l1; l1+l2.*sin(th2); l1+l2.*sin(th2)+l3.*sin(th2+th3); l1+l2.*sin(th2)+l3.*sin(th2+th3)+l5.*sin(th2+th3+th4)];
figure
for i=1:len1
    plot(Ax(:,i)',Ay(:,i)', 'lineWidth', 4)
    axis([-(l2+l3+l4+l5),l2+l3+l4+l5,l1-(l2+l3+l4+l5),l1+l2+l3+l4+l5])
    grid on
    drawnow;
end

%{
plot(Ax, Ay, 'lineWidth', 4)
axis([-(l2+l3+l4+l5),l2+l3+l4+l5,l1-(l2+l3+l4+l5),l1+l2+l3+l4+l5])
grid on
%}

%% DH-Parameter 시뮬레이션
%{
%           a    alpha    d    theta
DHparams = [  0, pi/2, l1,  0;
             l2,    0, 0,   th2;
             l3,    0, 0,   th3;
             0, -pi/2, 0,   th4;
              0,    0, l5, th5];

robot = rigidBodyTree;
body = cell(1,5);
joint = cell(1,5);
for i = 1:5
    body{i} = rigidBody('body'+string(i));
    body{i}.Mass = m(i);
    joint{i} =  rigidBodyJoint('joint'+string(i), 'revolute');
    setFixedTransform(joint{i}, DHparams(i,:), 'dh');
    body{i}.Joint = joint{i};
end
addVisual(body{1}, 'Mesh', 'link123.stl',[cosd(-90), -sind(-90), 0, 0; sind(-90), cosd(-90), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1])
addVisual(body{2}, 'Mesh', 'link123.stl', [cosd(-90), -sind(-90), 0, 0; sind(-90), cosd(-90), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1])
addVisual(body{3}, 'Mesh', 'link5.stl')
addVisual(body{5}, 'Mesh', 'ee.stl', [1, 0, 0, 0; 0, cosd(90), -sind(90), 0; 0, sind(90), cosd(90), 0; 0, 0, 0, 1])

addBody(robot, body{1}, 'base')
for i = 2:5, addBody(robot, body{i}, 'body'+string(i-1)); end

showdetails(robot)
plot1 = subplot(2,3,2);
show(robot, 'visuals', 'on');
set(plot1, 'position', [0.33 0.5 0.33 0.5])
axis([-0.5, 1.5, -0.5, 0.5, -0.5, 1])
%}
