function GaussSeidel(A, b, es, max_iter)
[m,n] = size(A); 
C=A;
D = zeros(m,n);
if nargin <2, error('at least 2 input arguments required'); end
if nargin < 4||isempty(max_iter), max_iter = 50; end
if nargin <3||isempty(es), es = 1; end
if m ~= n,  error('A Matirix is not square matrix'); end
% D = diag(diag(A))
for i = 1:n
    C(i,i) = 0; % 대각 원소만 0인 C 행렬 생성
    D(i,i) = A(i,i); % 대각 원소만 가지는 D 행렬 생성
    x(i) = 0; % 해를 넣을 공간을 만들어 줌, 초기값 0으로 설정 
end
x  = x'; % 해공간을 전치시켜서 열공간으로 만들어 줌
for i = 1:n
    C(i,1:n) = C(i,1:n)/A(i,i); % 계수를 나눠서 ax=를 x=로 바꿔줌
    b(i) = b(i)/A(i,i); % 계수를 나눠서 ax=를 x=로 바꿔줌
end
for iter = 1:max_iter
    xold = x;
    for i = 1:n
        x(i) = b(i) - C(i,1:n) * x; % x = b - Cx
        ea(i) = abs((x(i) - xold(i)) / x(i) * 100);
    end
    fprintf('%d번째\n',iter);
    disp('            x1             x2              x3              x4')
    fprintf('%15.4f %15.4f %15.4f %15.4f\n',x(1), x(2), x(3), x(4));
    disp('           ea1            ea2             ea3             ea4')
    fprintf('%15.4f %15.4f %15.4f %15.4f\n\n\n',ea(1), ea(2), ea(3), ea(4));
    if max(ea) <es, break; end
end