clc, clear, close all
%% 상수 설정
l1 = 0.4; l2 = 0.4; l3 = 0.4; l4 = 0; l5 = 0.2+0.15; % end effector
l = [l1 l2 l3 l4 l5];
m1 = 2.0; m2 = 2.7; m3 = 2.7; m4 = 0; m5 = 2.4+0.004;
m = [m1 m2 m3 m4 m5];

%% 경로 계획
px = 0.6;
py = 0.3;
thd = -pi/2;

%% 역기구학
x3 = px - (l5).*cos(thd);
y3 = py - (l5).*sin(thd);

c3 = (x3.^2 + (y3-l1).^2 - l2.^2 - l3.^2)./(2*l2*l3);
s3 = -sqrt(1-c3.^2);

th3 = atan2(s3, c3);
th2 = atan2(y3 - l1, x3) - atan2(l3.*sin(th3),l2+l3.*cos(th3));
th4 = thd - th3 - th2;
th5 = 0;

%% 암 이미지 비교를 통한 역기구학 검증
Ax = [0,  0,    l2.*cos(th2),    l2.*cos(th2)+l3.*cos(th2+th3),    l2.*cos(th2)+l3.*cos(th2+th3)+l5.*cos(th2+th3+th4)];
Ay = [0, l1, l1+l2.*sin(th2), l1+l2.*sin(th2)+l3.*sin(th2+th3), l1+l2.*sin(th2)+l3.*sin(th2+th3)+l5.*sin(th2+th3+th4)];
subplot(2,3,1)
plot(Ax, Ay, 'lineWidth', 4)
axis([-(l2+l3+l4+l5),l2+l3+l4+l5,l1-(l2+l3+l4+l5),l1+l2+l3+l4+l5])
grid on

%% DH-Parameter 시뮬레이션
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
    body{i}.Joint = joint{i}(1);
    if i > 1
        addBody(robot, body{i}, 'body'+string(i-1));
    else
        addBody(robot, body{i}, 'base')
    end
end
addVisual(body{1}, 'Mesh', 'link123.stl')%, [1, 0, 0, 0; 0, cosd(90), -sind(90), 0; 0, sind(90), cosd(90), 0; 0, 0, 0, 1])
addVisual(body{2}, 'Mesh', 'link123.stl')%, [cosd(-90), -sind(-90), 0, 0; sind(-90), cosd(-90), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1])
addVisual(body{3}, 'Mesh', 'link123.stl')%, [cosd(-90), -sind(-90), 0, 0; sind(-90), cosd(-90), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1])
addVisual(body{5}, 'Mesh', 'link5.stl')%, [cosd(-90), -sind(-90), 0, 0; sind(-90), cosd(-90), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]*[cosd(-90), 0, sind(-90), 0; 0, 1, 0, 0; -sind(-90), 0, cosd(-90), 0; 0, 0, 0, 1])

showdetails(robot)
plot1 = subplot(2,3,2);
show(robot, 'visuals', 'on');
set(plot1, 'position', [0.33 0.5 0.33 0.5])
axis([-0.5, 1.5, -0.5, 0.5, -0.5, 1])
