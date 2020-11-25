clc, clear
syms th1 th2 th3 d1 a2 a3
a1 = [cos(th1) 0 sin(th1) 0;
    sin(th1) 0 -cos(th1) 0;
    0 1 0 d1;
    0 0 0 1;];
a2 = [cos(th2) -sin(th2) 0 a2*cos(th2);
    sin(th2) cos(th2) 0 a2*sin(th2);
    0 0 1 0;
    0 0 0 1];
a3 = [cos(th3) -sin(th3) 0 a3*cos(th3);
    sin(th3) cos(th3) 0 a3*sin(th3);
    0 0 1 0;
    0 0 0 1];
a1*a2*a3