function x = OptBFGS(x0, err, MaxIter)
%{
�������ܣ�BFGS�㷨�����Լ������:  min f(x)��
���룺
  x0����ʼ�㣻
  err���ݶ������ֵ��
  MaxIter��������������
�����
  x����Сֵ�㣻
���ø�ʽ��
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
   error('����������㣡');
end
beta = 0.55;  
sigma = 0.4;
n = length(x0);
H = eye(n);     % ��ʼHesse����
k = 0;
while k < MaxIter 
    g = gfun(x0);        % �����ݶ�
    if norm(g) < err
        break; 
    end
    d = -H \ g;          % ��������
    m = 0; 
    mk = 0;
    while m < 20         % �� Armijo �����󲽳�
        newf = fun(x0 + beta^m * d);
        oldf = fun(x0);
        if newf <= oldf + sigma * beta^m * g' * d
            mk = m; 
            break;
        end
        m = m + 1;
    end
    % BFGS У��
    x = x0 + beta^mk * d;
    dx = x - x0;            % �������ֵ
    dg = gfun(x) - g;       % �ݶȲ�ֵ
    if dg' * dx > 0 
        H = H - (H * (dx * dx') * H) / (dx' * H * dx) + (dg * dg') / (dg' * dx);   % Hesse�������
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