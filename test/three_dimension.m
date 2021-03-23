[x,y] = meshgrid(-10:10,-10:10);
z = 2*x.^2-8*x+2*y.^2-4*y+20;
c = x.*y;
surf(x,y,z,cQ)