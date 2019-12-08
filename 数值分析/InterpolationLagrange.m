function [y0, coef] = InterpolationLagrange(x, y, x0)
%{
函数功能：拉格朗日插值法；
输入：
  x：已知点横坐标；
  y：已知点纵坐标；
  x0：未知点横坐标；
输出：
  y0：未知点纵坐标；
  coef：插值系数；
示例：
clear; clc;
x = 0 : 0.1 : 2;
y = sin(x);
x0 = 0.55;
[y0, coef] = Interpolation_Lagrange(x, y, x0);
plot(x, y, 'o-', x0, y0, '*');
%} 
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
if nargin < 3
   error('输入参数不足！');
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