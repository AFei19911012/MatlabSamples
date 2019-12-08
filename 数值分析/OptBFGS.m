function x = OptBFGS(x0, err, MaxIter)
%{
函数功能：BFGS算法求解无约束问题:  min f(x)；
输入：
  x0：初始点；
  err：梯度误差阈值；
  MaxIter：最大迭代次数；
输出：
  x：最小值点；
调用格式：
clear; clc;
x = OptBFGS([10 -10 2 8]', 1e-5, 1000)
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
beta = 0.55;  
sigma = 0.4;
n = length(x0);
H = eye(n);     % 初始Hesse矩阵
k = 0;
while k < MaxIter 
    g = gfun(x0);        % 计算梯度
    if norm(g) < err
        break; 
    end
    d = -H \ g;          % 搜索方向
    m = 0; 
    mk = 0;
    while m < 20         % 用 Armijo 搜索求步长
        newf = fun(x0 + beta^m * d);
        oldf = fun(x0);
        if newf <= oldf + sigma * beta^m * g' * d
            mk = m; 
            break;
        end
        m = m + 1;
    end
    % BFGS 校正
    x = x0 + beta^mk * d;
    dx = x - x0;            % 迭代点差值
    dg = gfun(x) - g;       % 梯度差值
    if dg' * dx > 0 
        H = H - (H * (dx * dx') * H) / (dx' * H * dx) + (dg * dg') / (dg' * dx);   % Hesse矩阵更新
    end
    k = k + 1;
    x0 = x;
end
x = x0;

function f = fun(x)
f = (x(1) + 10 * x(2))^2 + 5 * (x(3) - 10 * x(4))^2 + (x(2) - 2 * x(3))^2 + 10 * (x(1) - x(4))^2;

function gf = gfun(x)
gf = [2 * (x(1) + 10 * x(2)) + 20 * (x(1) - x(4))
      20 * (x(1) + 10 * x(2)) + 2 * (x(2) - 2 * x(3))
      10 * (x(3) - 10 * x(4)) - 4 * (x(2) - 2 * x(3))
      -100 * (x(3) - 10 * x(4)) - 20 * (x(1) - x(4))];