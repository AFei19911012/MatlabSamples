function x = OptReviseNewton(x0, err, MaxIter)
%{
函数功能：修正牛顿法求解无约束问题:  min f(x)；
输入：
  x0：初始点；
  err：梯度误差阈值；
  MaxIter：最大迭代次数；
输出：
  x：最小值点；
调用格式：
clear; clc;
x = OptReviseNewton([0 0]', 1e-5, 1000)
%}
if nargin < 3
    MaxIter = 1000;
end
if nargin < 2
    err = 1e-5;
end
if nargin < 1
   error('输入参数不足！');
end
n = length(x0);
beta = 0.5;
sigma = 0.4;
tau = 0.0;
k = 0;
while k < MaxIter
    gk = gfun(x0);            % 计算梯度
    muk = norm(gk)^(1 + tau);
    Gk = Hessian(x0);     % 计算Hesse阵
    Ak=Gk+muk*eye(n);
    dk=-Ak\gk;                  % 解方程组 Ak*dk = -gk, 计算搜索方向
    if(norm(gk) < err)
        break;
    end 
    m=0;
    mk=0;
    while m < 20      % 用 Armijo 搜索求步长
        if(fun(x0+beta^m*dk)<=fun(x0)+sigma*beta^m*gk'*dk)
            mk=m;
            break;
        end
        m=m+1;
    end
    x0 = x0 + beta^mk*dk;
    k = k + 1;
end
x = x0;

function f = fun(x)
% 目标函数
f = 100 * (x(1)^2 - x(2))^2 + (x(1) - 1)^2;

function gf = gfun(x)
% 梯度
gf = [400 * x(1) * (x(1)^2 - x(2)) + 2 * (x(1) - 1);
      -200 * (x(1)^2 - x(2))];

function He = Hessian(x)
% Hessian
He = [400 * (3 * x(1)^2 - x(2)) + 2, -400 * x(1);
      -400 * x(1), 200];