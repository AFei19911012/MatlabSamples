function [lam, newxk, fk, newfk] = OptGoldstein(xk, dk)
a = 0;     % �����½�
b = 10;    % �����Ͻ�
lam = 1;   % ��ʼ��
c1 = 0.25;
c2 = 0.75;
t = 2;
% ѭ�������ѵĲ��� 
while a < b  
    % ������������ Goldstein ��һ��׼�� 
    if fun(xk + lam * dk) <= fun(xk) + c1 * lam * gfun(xk)' * dk 
        % ������������ Goldstein �ڶ���׼�� 
        if fun(xk + lam*dk) >= fun(xk) + c2 * lam * gfun(xk)' * dk
            % �����ѵĲ��� 
            newxk = xk + lam * dk;
            fk = fun(xk);
            newfk = fun(newxk);
            break; 
        % �������������� Goldstein ׼�򣬼������� 
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