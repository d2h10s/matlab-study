function Euler(fx, lower, upper, y0, h)
yi = y0; i=0;
for ti = lower:h:upper-h
    yf = yi +fx(ti,yi)*h;
    fprintf('t%d = %.4f, y%d = %.4f, fx%d = %.4f, y%d = %.4f\n', i, ti, i, yi, i, fx(ti,yi), i+1, yf)
    yi = yf;
    i = i + 1;
end
fprintf('\n\n')