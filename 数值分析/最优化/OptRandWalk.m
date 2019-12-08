function[mx, minf] = OptRandWalk(x, lamda, N, n)
%{ 
函数功能：随机行走法求函数的极小值
x：初始值；
lamda：步长；
N：为了产生较好点的迭代次数；
n：单步循环行走次数，目的是尽可能走到全局最优点附近
mx：最优解；
minf：最优值。
clear; clc;
[mx, minf] = OptRandWalk([0, 0], 10, 100, 10)
%}
F = zeros(n, 1);
D = length(x);
X = zeros(n, D);
epsilon = 1e-5;
f1 = func(x);
while lamda  >= epsilon
    k = 1;
    while(k <= N)
        u = 2*rand(10, D) - 1;
        for ii =1 : n
            X(ii, :) = x + lamda*(u(ii, :) / norm(u(ii, :)));
            F(ii) = func(X(ii, :));
        end
        [f11, kk] = min(F);
        if f11 < f1
            f1 = f11;
            x = X(kk, :);
            k = 1;
        else
            k = k + 1;
        end
    end
lamda = lamda / 2;
end
mx = X(kk, :);
minf = f1;

function f = func(x)
f = -sin(sqrt((x(1) - 50).^2 + (x(2) - 50).^2 ) + exp(1)) ./ (sqrt((x(1) - 50).^2 + (x(2) - 50).^2 ) + exp(1)) - 1;
% f = sum(x.^2);
% f = 3*cos(x(1)*x(2)) + x(1) + x(2)^2;
% f = 4*x(1)^2-2.1*x(1)^4+x(1)^6/3+x(1)*x(2)-4*x(2)^2+4*x(2)^4;
% f = 0.5 + (sin(sqrt(x(1)^2 + x(2)^2))^2 - 0.5) / (1 + 0.001*(x(1)^2 + x(2)^2))^2;