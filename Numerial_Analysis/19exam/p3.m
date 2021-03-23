clear all; close all; clc;
x = [1:100];
polyx5 = x.^3;
exp5x = 3.^x;
factx = factorial(x);
figure
semilogy(x, polyx5, 'b', x, exp5x, 'g', x, factx, 'r')
legend('x^3 (polynomial)', '3^x (exponential)', 'x! (factorial)')