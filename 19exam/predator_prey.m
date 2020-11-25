% predator_prey
clear; clc; 
tspan = [0 40];
x0 = [1000 500];
h = 0.1;
[t,x] = odesolver(@predprey,tspan,x0,h);
figure(1)
plot(t,x(:,1),t,x(:,2),'--')