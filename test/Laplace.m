clc, clear
syms t s T;
%D = sym(dirac(t));
u = sym(heaviside(t-4));
fx = t*u
laplace(fx, t, s)