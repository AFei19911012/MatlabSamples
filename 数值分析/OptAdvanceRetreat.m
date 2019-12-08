function [lb, ub] = OptAdvanceRetreat(fun, x0, h0)
%{
�������ܣ����˷�ȷ��������Сֵ����
���룺
  fun��Ŀ�꺯�������
  x0����ʼ�㣻
  h0����ʼ������Ĭ��ֵΪ0.0125��
�����
  lb������������˵㣻
  rb�����������Ҷ˵㣻
���ø�ʽ��
clear; clc;
fun = @(x) x + 6 * sin(4 * x) + 9 * cos(5 * x);
[lb, ub] = OptAdvanceRetreat(fun, 0, 0.0125)
fplot(fun, [-2, 2])
hold on 
plot([lb, ub], fun([lb, ub]), 'p');
hold off
%}
if nargin < 3
   h0 = 0.0125;
end
if nargin < 2
   error('����������㣡');
end
% ��ʼ���
k = 0;
x = x0;
h = h0;
while 1
    x2 = x + h;           % �µ�����˵�
    k = k + 1;
    f2 = fun(x2);
    f = fun(x);
    if f2 < f             % x1�Ҳ����½����ƣ���������
        x1 = x;
        x = x2;
        h = 2 * h;
    else
        if k == 1         % x1�Ҳ����������ƣ���������
            h = -h;       % �������� 
            x1 = x2;
        else
            % �����ȷ������Ϊ x1 �� x2 ֮��
            lb = min(x1, x2);
            ub = max(x1, x2);
            break;  
        end
    end
end