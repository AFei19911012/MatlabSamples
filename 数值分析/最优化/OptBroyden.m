function x = OptBroyden(x0, err, MaxIter)
%{
函数功能：Broyden族算法求解无约束问题:  min f(x)；
输入：
  x0：初始点；
  err：梯度误差阈值；
  MaxIter：最大迭代次数；
输出：
  x：最小值点；
调用格式：
clear; clc;
x = OptBroyden([0 0]', 1e-5, 1000)
%}
if nargin < 3
    MaxIter = 1000; 
end
if nargin < 2
    err = 1e-5; 
end
beta=0.55;  
sigma=0.4;
n = length(x0);  
Hk = eye(n);
phi = 0.5;  
k = 0;
while k < MaxIter 
    gk = gfun(x0);      % 计算梯度
    if norm(gk) < err 
        break; 
    end  
    dk = -Hk*gk;        % 计算搜索方向
    m = 0; 
    mk = 0;
    while m < 20        % 用 Armijo 搜索求步长
        if fun(x0 + beta^m*dk) <= fun(x0) + sigma*beta^m*gk'*dk
            mk = m; 
            break;
        end
        m = m+1;
    end
    % Broyden族校正
    x = x0 + beta^mk*dk;
    sk = x - x0;  
    yk = gfun(x) - gk;
    Hy = Hk*yk;  
    sy = sk'*yk;
    yHy = yk'*Hk*yk;
    if sy < 0.2*yHy 
        theta = 0.8*yHy/(yHy - sy);
        sk = theta*sk + (1 - theta)*Hy;
        sy = 0.2*yHy;
    end
    vk = sqrt(yHy)*(sk/sy - Hy/yHy);
    Hk = Hk - (Hy*Hy')/yHy + (sk*sk')/sy + phi*(vk*vk');
    x0 = x; 
    k = k + 1;
end
x = x0;

function f = fun(x)
f = 100 * (x(1)^2 - x(2))^2 + (x(1) - 1)^2;

function gf = gfun(x)
gf = [400 * x(1) * (x(1)^2 - x(2)) + 2 * (x(1) - 1);
      -200 * (x(1)^2 - x(2))];