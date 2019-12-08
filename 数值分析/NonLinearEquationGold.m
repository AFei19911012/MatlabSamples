function root = NonLinearEquationGold(fun, a, b, err)
%{
函数功能：黄金分割法求解非线性方程的根；
输入：
  fun：方程句柄；
  a：搜索区间下限；
  b：搜多区间上限；
  err：精度阈值；
输出：
  root：近似解；
示例：
clear; clc;
fun = @(x) x + 6 * sin(4 * x) + 9 * cos(5 * x);
root = NonLinearEquationGold(fun, 3, 4, 1e-6)
fplot(fun, [3, 4]);
hold on
plot([3, 4], [0, 0], root, fun(root), 'p');
hold off
%} 
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
if nargin < 4
   err = 1e-6;   % 默认精度
end
if nargin < 3
   error('输入参数不足！');
end
% 初始情况
root = NaN;   %  返回非数
if fun(a) == 0
   root = a;
end;
if fun(b) == 0
   root = b;
end
if fun(a) * fun(b) > 0
   disp('两端点函数值乘积大于0，无解！');
   return;
else
   x1 = a + 0.382*(b - a);
   x2 = a + 0.618*(b - a);
   f1 = fun(x1);
   f2 = fun(x2);
   while abs(b - a) > err        %  控制精度
      if f1 * f2 < 0             %  区间两端点都调整
         a = x1;
         b = x2;
      else
         fa = fun(a);
         if f1 * fa > 0          %  左端点a和x1之间没有根，调整左端点的值
            a = x2;
         else
            b = x1;              %  左端点a和x1之间有根，调整右端点的值
         end
      end
      x1 = a + 0.382 * (b - a);
      x2 = a + 0.618 * (b - a);
      f1 = fun(x1);
      f2 = fun(x2);  
   end
   root = (b + a) / 2;       % 输出根   
end