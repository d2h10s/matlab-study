clc, clear
len = 10;
theta = randi([0, 360], len,6);
d = [74, 0, 0, 164, 120, 70];
a = [0, 400, 411, 0, 0, 0];
alpha = [pi/2, 0, 0, pi/2, -pi/2, 0];
result = zeros(len,3);

for i = 1:len
    D = 1;
    for j = 1:6
        D = D*[ cos(theta(i,j)), -sin(theta(i,j))*cos(alpha(j)),  sin(theta(i,j))*sin(alpha(j)), a(j)*cos(theta(i,j));
            sin(theta(i,j)),  cos(theta(i,j))*cos(alpha(j)), -cos(theta(i,j))*sin(alpha(j)), a(j)*sin(theta(i,j));
            0,         sin(alpha(j)),         cos(alpha(j)),        d(j);
            0,              0,              0,        1];
    end
    result(i,1:3) = D(1:3,4);
end

subplot(2,2,1)
plot3(result(:,1), result(:,2), result(:,3), 'o', 'MarkerSize', 2)
xlabel('x'); ylabel('y'); zlabel('z'); grid on
subplot(2,2,2)
plot(result(:,1), result(:,2), 'o', 'MarkerSize', 2)
xlabel('x'); ylabel('y'); grid on
subplot(2,2,3)
plot(result(:,1), result(:,3), 'o', 'MarkerSize', 2)
xlabel('x'); ylabel('z'); grid on
subplot(2,2,4)
plot(result(:,2), result(:,3), 'o', 'MarkerSize', 2)
xlabel('y'); ylabel('z'); grid on

disp_theta(theta, result)

function disp_theta(theta, result)
fprintf("         th1 th2 th3 th4 th5 th6       Px    Py     Pz")
for i = 1:60
    fprintf("\ncase %2d: ", i)
    for j = 1:6
        fprintf("%3d ", theta(i,j))
    end
    fprintf("   ")
    for j = 1:3
        fprintf("%6.1f ", result(i,j))
    end
end
end