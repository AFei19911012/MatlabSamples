function [x, n] = NonLinearEquationsNewtonDown(x0, err)
%{
�������ܣ�ţ����ɽ���������Է����飻
���룺
  x0����ʼֵ��
  err��������ֵ��
�����
  x�����ƽ⣻
  n������������
ʾ����
clear; clc;
[x, n] = NonLinearEquationsNewtonDown([0 0 0], 1e-6)
%} 
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
x = x0 - myfun(x0) / dmyfun(x0);
n = 1;
tol = 1;
while tol > err
    x0 = x;
    ttol = 1;
    w = 1;
    F1 = norm(myfun(x0));
    while ttol >= 0
        x = x0 - w * myfun(x0) / dmyfun(x0);
        ttol = norm(myfun(x)) - F1;
        w = w / 2;
    end
    tol = norm(x - x0);
    n = n + 1;
    if(n > 1000)
        disp('��������̫�࣬���ܲ�������');
        return;
    end
end

% ������
function f = myfun(x)
x1 = x(1);
x2 = x(2);
x3 = x(3);
f(1) = 3 * x1 - cos(x2 * x3) -1/2;
f(2) = x1^2 - 81 * (x2 + 0.1) + sin(x3) + 1.06;
f(3) = exp(-x1 * x2) + 20 * x3 + 1/3 * (10 * pi - 3);

% �ݶ�
function df =dmyfun(x)
x1 = x(1);
x2 = x(2);
x3 = x(3);
df=[3, x3 * sin(x2 * x3), x2 * sin(x2 * x3); 
    2 * x1, -81, cos(x3); 
    -x2 * exp(-x1 * x2), -x1 * exp(-x1 * x2), 20];