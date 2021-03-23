function fout = multiplication(xi,xf)
x = 1;
for k = xi:xf;
x = x*sym(k);
end
fout = x;
end