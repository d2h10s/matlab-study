function lsm(xi, yi,d)
% conduct Least Square Method
clc, close all
n = length(xi)
Z = zeros(length(xi),d+1);
Y = yi';
for i = 1:length(xi)
    for j = 0:d
        Z(i,j+1) = xi(i)^j;
    end
end
Z
a = ((Z'*Z)^-1)*Z'*Y
a(10)=0;
fx = @(t) a(1)+a(2)*t+a(3)*t.^2+a(4)*t.^3;
%subplot(1,3,1)
fplot(fx)
hold on
plot(xi,yi,'o')
axis([0 80 0 2])
ylabel('V')
xlabel('mA')
title('I-V Linear Regression with Least Square Method')

St = sum((yi-sum(yi)/n).^2)
Sr = sum((yi-fx(xi)).^2)
R = sqrt((St-Sr)/St)
R2 = (St-Sr)/St
Slope = a(2)
%% 내장 함수를 이용한 선형회기분석 결과
% p = polyfit(xi,yi,d);
% p = p'
% p = p';
% p = fliplr(p);
% p(10) = 0;
% 
% gx = @(t) p(1)+p(2)*t+p(3)*t.^2+p(4)*t.^3;
% subplot(1,3,2)
% fplot(gx)
% hold on
% plot(xi,yi, 'o')
%% 내장 함수와 numerical analysis 분석 매치
%subplot(1,3,3)
%fplot(gx)
%hold on
%fplot(fx)