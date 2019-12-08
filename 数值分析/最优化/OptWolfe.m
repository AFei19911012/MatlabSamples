function [alpha, newxk, fk, newfk] = OptWolfe(xk, dk)
rho = 0.25; 
sigma = 0.75;
alpha = 1; 
a = 0; 
b = 1; 
while a < b
    if fun(xk + alpha * dk) <= fun(xk) + rho * alpha * gfun(xk)' * dk
        if gfun(xk + alpha * dk)' * dk >= sigma * gfun(xk)' * dk
            break;
        else
            a = alpha;
            alpha = 0.5 * (a + b);
        end
    else
        b = alpha;
        alpha = (alpha + a) / 2;
    end
end
newxk = xk + alpha * dk;
fk = fun(xk);
newfk = fun(newxk);

function f = fun(x)
f = 100 * (x(1)^2 - x(2))^2 + (x(1) - 1)^2;

function gf = gfun(x)
gf = [400 * x(1) * (x(1)^2 - x(2)) + 2 * (x(1) - 1);
      -200 * (x(1)^2 - x(2))];