function [y0, coef] = InterpolationLagrange(x, y, x0)
%{
�������ܣ��������ղ�ֵ����
���룺
  x����֪������ꣻ
  y����֪�������ꣻ
  x0��δ֪������ꣻ
�����
  y0��δ֪�������ꣻ
  coef����ֵϵ����
ʾ����
clear; clc;
x = 0 : 0.1 : 2;
y = sin(x);
x0 = 0.55;
[y0, coef] = Interpolation_Lagrange(x, y, x0);
plot(x, y, 'o-', x0, y0, '*');
%} 
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
if nargin < 3
   error('����������㣡');
end
m = length(x);
coef = zeros(m, 1);
y0 = 0;
for i = 1 : m
    coef(i) = 1;
    for j = 1 : m
        if j ~= i
            coef(i) = coef(i)*(x0 - x(j)) / (x(i) - x(j));
        end
    end
    y0 = y0 + y(i)*coef(i);
end