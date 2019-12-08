function x = OptReviseNewton(x0, err, MaxIter)
%{
�������ܣ�����ţ�ٷ������Լ������:  min f(x)��
���룺
  x0����ʼ�㣻
  err���ݶ������ֵ��
  MaxIter��������������
�����
  x����Сֵ�㣻
���ø�ʽ��
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
   error('����������㣡');
end
n = length(x0);
beta = 0.5;
sigma = 0.4;
tau = 0.0;
k = 0;
while k < MaxIter
    gk = gfun(x0);            % �����ݶ�
    muk = norm(gk)^(1 + tau);
    Gk = Hessian(x0);     % ����Hesse��
    Ak=Gk+muk*eye(n);
    dk=-Ak\gk;                  % �ⷽ���� Ak*dk = -gk, ������������
    if(norm(gk) < err)
        break;
    end 
    m=0;
    mk=0;
    while m < 20      % �� Armijo �����󲽳�
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
% Ŀ�꺯��
f = 100 * (x(1)^2 - x(2))^2 + (x(1) - 1)^2;

function gf = gfun(x)
% �ݶ�
gf = [400 * x(1) * (x(1)^2 - x(2)) + 2 * (x(1) - 1);
      -200 * (x(1)^2 - x(2))];

function He = Hessian(x)
% Hessian
He = [400 * (3 * x(1)^2 - x(2)) + 2, -400 * x(1);
      -400 * x(1), 200];