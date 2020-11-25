%prob1
clear all; close all; clc;
x = 1:1:100;
pol = x.^5;
exp = 5.^x;
fac = factorial(x);
semilogy(x, pol, 'b', x, exp, 'g', x, fac, 'r')
legend('x^5 (polynomial)', '5^x (exponential)', 'x! (factorial)')