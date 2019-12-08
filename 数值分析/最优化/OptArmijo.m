function [alpha, newxk, fk, newfk] = OptArmijo(xk, dk)
beta = 0.5;  
sigma = 0.2;
m = 0;  
mk = 0;
maxm = 20;
while m <= maxm
    if fun(xk + beta^m * dk) <= fun(xk) + sigma * beta^m * gfun(xk)' * dk
        mk = m;  
        break;
    end
    m = m + 1;
end
alpha = beta^mk;
newxk = xk + alpha * dk;
fk = fun(xk);
newfk = fun(newxk);

function f = fun(x)
f = 100 * (x(1)^2 - x(2))^2 + (x(1) - 1)^2;

function gf = gfun(x)
gf = [400 * x(1) * (x(1)^2 - x(2)) + 2 * (x(1) - 1);
      -200 * (x(1)^2 - x(2))];