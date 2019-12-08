function [xv, fv, iter] = OptRouteTrack(H, c, A, b, x0)
%{
函数功能：路径跟踪法求解二次规划问题；
    min f(x) = 0.5 * x'*H*x + c'*x, s.t. A*x >= b
输入：
    H：正定矩阵；
    c：一次项系数；
    A：不等式约束系数矩阵；
    b：不等式约束右端矩阵；
    x0：初始点；
输出：
    xv：最优解；
    fv：最优解对应目标函数值；
    iter：迭代次数；
实例：
min f(x) = x1^2 + x2^2 - 2*x1*x2 + x1 + x2;
s.t. -x1, - x2 >= -1;
      x1, x2 >= 0.5;
clear; clc;
H = [2 -2;-2 2];
c = [1;1];
A = [-1, 0; 0, -1; 1, 0; 0, 1];
b = [-1; -1; 0.5; 0.5];
x0 = [1, 1]';
[xv, fv, iter] = OptRouteTrack(H, c, A, b,x0)
%}
y0 = ones(size(A, 1), 1);    % 初始 y 向量；
w0 = ones(size(A, 1), 1);   % 初始 x 向量；
p = 0.9;     
delta = 0.1;
tolX = 1e-6;
m = size(A, 1);
tol = 1;
iter = 0;
itermax = 1000;
while tol > tolX && iter < itermax
    Y = diag(y0);
    W = diag(w0);
    lu = b - A*x0 + w0;
    sigma = c + H*x0 - transpose(A)*y0;
    gama = transpose(y0)*w0;
    mu = delta*gama/m;
    SA = [-H, A'; A, SolveEquations(Y, W)];
    SB = [c + H*x0 - A'*y0; b - A*x0 + mu*SolveEquations(Y, ones(m,1))];
    ds = SolveEquations(SA, SB);
    dx = ds(1 : length(x0));
    dy = ds((length(x0) + 1) : length(ds));
    dw = SolveEquations(Y, mu*ones(m,1) - Y*W*ones(m,1) - W*dy);
    ry = - dy ./ y0;
    rw = -dw ./ w0;
    vec = [ry; rw];
    mr = max(vec);
    lamda = min(p/mr ,1); 
    x0 = x0 + lamda*dx;
    y0 = y0 + lamda*dy;
    w0 = w0 + lamda*dw;
    tollu = norm(lu);
    tolsigma = norm(sigma);
    tolgama = abs(gama);
    tol = max(tollu, tolsigma);
    tol = max(tol, tolgama);
    iter = iter + 1;
end
xv = x0;
fv = transpose(xv)*H*xv/2 + transpose(c)*xv;

function x = SolveEquations(A, y)
[m, n] = size(A);
[u, s, v] = svd(A);
s(s < 1e-10) = 0;
for i = 1 : min(m, n)
    if s(i, i) > 0
        s(i, i) = 1 / s(i, i);
    end
end
x = v * s' * u' * y;
    

    