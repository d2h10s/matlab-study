clc, clear, close all
%% 상수 설정
l1 = 0.4; l2 = 0.4; l3 = 0.4; l4 = 0.2; lee = 0.15; % ee: end effector
th3 = 0;
th2 = 0;
th4 = 0;
th5 = 0;
%% DH-Parameter 시뮬레이션
%           a    alpha    d    theta
DHparams = [ 0,  pi/2, l1,  0;
             l2, 0,     0,  th2;
             l3, 0,     0,  th3;
             l4, pi/2,  0,  th4;
             0,  0,     lee, th5];

robot = rigidBodyTree;

body1 = rigidBody('body1');
body2 = rigidBody('body2');
body3 = rigidBody('body3');
body4 = rigidBody('body4');
body5 = rigidBody('body5');

joint1 = rigidBodyJoint('joint1', 'revolute');
joint2 = rigidBodyJoint('joint2', 'revolute');
joint3 = rigidBodyJoint('joint3', 'revolute');
joint4 = rigidBodyJoint('joint4', 'revolute');




setFixedTransform(joint1, DHparams(1,:), 'dh')
setFixedTransform(joint2, DHparams(2,:), 'dh')
setFixedTransform(joint3, DHparams(3,:), 'dh')
setFixedTransform(joint4, DHparams(4,:), 'dh')

body2.Joint = joint1;
body3.Joint = joint2;
body4.Joint = joint3;
body5.Joint = joint4;

addBody(robot, body1, 'base');
addBody(robot, body2, 'body1');
addBody(robot, body3, 'body2');
addBody(robot, body4, 'body3');
addBody(robot, body5, 'body4');

addVisual(body1, "Mesh", 'link123.stl')
addVisual(body2, 'Mesh', 'link123.stl')
addVisual(body3, 'Mesh', 'link123.stl')
addVisual(body4, 'Mesh', 'link123.stl')
addVisual(body5, 'Mesh', 'ee.stl')

showdetails(robot)
show(robot, 'Visuals', 'on');
