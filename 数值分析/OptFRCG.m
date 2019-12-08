function x = OptFRCG(x0, err, MaxIter)
%{
函数功能：FR非线性共轭梯度法求解无约束问题:  min f(x)；
输入：
  x0：初始点；
  err：梯度误差阈值；
  MaxIter：最大迭代次数；
输出：
  x：最小值点；
调用格式：
clear; clc;
x = OptFRCG([10 -10 2 8]', 1e-5, 1000)
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
beta = 0.6;
sigma = 0.4;
k = 0;
while k < MaxIter
    gk = gfun(x0);         % 计算梯度
    k = k + 1;     % 计算搜索方向
    if k == 1
        dk = -gk;
    else
        betak = (gk'*gk)/(g0'*g0);
        dk = -gk + betak*d0;
        gd = gk'*dk;
        if(gd >= 0.0)
            dk = -gk;
        end
    end
    if norm(gk) < err
        break;
    end   
    m = 0;
    mk = 0;
    while m < 20    % 用 Armijo 搜索求步长
        if fun(x0 + beta^m*dk) <= fun(x0) + sigma*beta^m*gk'*dk
            mk = m;
            break;
        end
        m = m + 1;
    end
    x = x0 + beta^mk*dk;
    g0 = gk;
    d0 = dk;
    x0 = x;
    k = k + 1;
end

function f = fun(x)
f = (x(1) + 10 * x(2))^2 + 5 * (x(3) - 10 * x(4))^2 + (x(2) - 2 * x(3))^2 + 10 * (x(1) - x(4))^2;

function gf = gfun(x)
gf = [2 * (x(1) + 10 * x(2)) + 20 * (x(1) - x(4))
      20 * (x(1) + 10 * x(2)) + 2 * (x(2) - 2 * x(3))
      10 * (x(3) - 10 * x(4)) - 4 * (x(2) - 2 * x(3))
      -100 * (x(3) - 10 * x(4)) - 20 * (x(1) - x(4))];