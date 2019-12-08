function [lam, newxk, fk, newfk] = OptGoldstein(xk, dk)
a = 0;     % 搜索下界
b = 10;    % 搜索上界
lam = 1;   % 初始点
c1 = 0.25;
c2 = 0.75;
t = 2;
% 循环求解最佳的步长 
while a < b  
    % 搜索步长满足 Goldstein 第一个准则 
    if fun(xk + lam * dk) <= fun(xk) + c1 * lam * gfun(xk)' * dk 
        % 搜索步长满足 Goldstein 第二个准则 
        if fun(xk + lam*dk) >= fun(xk) + c2 * lam * gfun(xk)' * dk
            % 输出最佳的步长 
            newxk = xk + lam * dk;
            fk = fun(xk);
            newfk = fun(newxk);
            break; 
        % 搜索步长不满足 Goldstein 准则，继续迭代 
        else 
            a = lam; 
            lam = 0.5 * (a + b); 
            if b < inf 
                lam = 0.5 * (a + b); 
            else 
                lam = t * lam; 
            end 
        end 
    else 
        b = lam; 
        lam = 0.5 * (a + b); 
    end 
    if abs(a - b) < 1e-3
        break;
    end
end

function f=fun(x)
f = 100 * (x(1)^2 - x(2))^2 + (x(1) - 1)^2;

function gf=gfun(x)
gf = [400 * x(1) * (x(1)^2 - x(2)) + 2 * (x(1) - 1);
      -200 * (x(1)^2 - x(2))];